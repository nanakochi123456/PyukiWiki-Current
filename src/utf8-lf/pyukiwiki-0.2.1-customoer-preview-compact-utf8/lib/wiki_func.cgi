######################################################################
# wiki_func.cgi - $Id$
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
	# SGMLの顔文字のエスケープコードの実体参照の正規表現		# comment
$::_sgmlescape=q{aelig|aacute|acirc|agrave|aring|atilde|auml|ccedil|eth|eacute|ecirc|egrave|euml|iacute|icirc|igrave|iuml|ntilde|oacute|ocirc|ograve|oslash|otilde|oumltimes|thorn|uacute|ucirc|ugrave|uuml|yacute|acute|amp|bdquo|big|big_plus|bigsmile|brvbar|bull|cedil|cent|copy|curren|dagger|deg|divide|euro|frac12|frac14|frac34|heart|heart2|heartplus|huh|iexcl|iquest|laquo|ldquo|lsquo|macr|mdash|micro|middot|nbsp|ndash|not|oh|oh2|ohplus|ordf|ordm|ouml|para|permil|plusmn|pound|raquo|rdquo|reg|rsquo|sad|sad2|sadplus|sbquo|sect|shy|smile|smile2|smileplus|star|sup1|sup2|sup3|szlig|tear|trade|uml|ummr|wink|wink2|winkplus|worried|worried2|worriedplus|yen|yuml};
	# HTMLエスケープのテーブル									# comment
%::_htmlspecial = (
	'&' => '&amp;',
	'<' => '&lt;',
	'>' => '&gt;',
	'"' => '&quot;',
);
	# HTMLアンエスケープのテーブル								# comment
%::_unescape = (
	'amp'  => '&',
	'lt'   => '<',
	'gt'   => '>',
	'quot' => '"',
);
sub _getbasehref {
	# Thanks moriyoshi koizumi.
	return if($::basehref ne '');
	$::basehost = "$ENV{'HTTP_HOST'}";
	my $schme;
	my $port;
	# changed on 0.2.1
	if($ENV{'https'} =~ /on/i) {
		$schme="https";
		if($ENV{SERVER_PORT} ne 443 && $::basehost!~/:\d/) {
			$port=$ENV{SERVER_PORT};
		}
	}
	if($ENV{SERVER_PORT} eq 443) {
		$schme="https";
	}
	if($schme eq "") {
		$schme="http";
		if($ENV{SERVER_PORT} ne 80 && $::basehost!~/:\d/) {
			$port=$ENV{SERVER_PORT};
		}
	}
	$::basehost=$schme . '://' . $::basehost;
	$::basehost.=":$port" if($port ne "");
	# URLの生成									# comment
	my $uri;
	my $req=$ENV{REQUEST_URI};
	$req=~s/\?.*//g;
	if($req ne '') {
		if($req eq $ENV{SCRIPT_NAME}) {
			$uri= $ENV{'SCRIPT_NAME'};
		} else {
			for(my $i=0; $i<length($ENV{SCRIPT_NAME}); $i++) {
				if(substr($ENV{SCRIPT_NAME},$i,1) eq substr($req,$i,1)) {
					$uri.=substr($ENV{SCRIPT_NAME},$i,1);
				} else {
					last;
				}
			}
		}
	} else {
		$uri .= $ENV{'SCRIPT_NAME'};
	}
	$uri=~s/($::defaultindex)//g;
	$uri=~s/\/\//\//g;
	$::basehref=$::basehost . $uri;
	$::basepath=$uri;
	$::basepath=~s/\/[^\/]*$//g;
	$::basepath="/" if($::basepath eq '');
	$::script=$uri if($::script eq '');
	return($::basehref, $::basepath, $::script);
}
my $oldflg=0;
sub _jscss_include {
	my($v, $sub, $p)=@_;
	my($name, $func)=split(/:/,$v);
	my @jsarray;
	my $jsmax=0;
	if(!$::jscss_included{$name}) {
		if($oldflg eq 0) {
			$oldflg=&is_no_xhtml(1) eq 0 ? 2 : 1;
		}
		$::jscss_included{$name}=1;
		return if($name!~/^\w{1,64}/);
		foreach("$name%s.css", "$name%s.js") {#, "$::skin_name.$name%s.js") {
			my $result=&skin_check($_, "");
			if($result ne '') {
				if($result=~/\.js$/) {
						my $pro=$p + 0 > 0 ? $p : $name=~/common/ ? 6 : $name eq "jquery" ? 9 : $name=~/jquery/ ? 7 : 3;
	#					my $pro=$p+0>0 ? $p : $_pro;
						#$::IN_JSFILES.=',"' . "$pro,$::skin_url/$result@{[$func ? qq(\|$func) : qq()]}" . '"';
						#$::IN_JSFILES.="," . '"' . "$pro,$::skin_url/$result" . '"';
						$::IN_JSMAX=$::IN_JSMAX+0 < $pro ? $pro : $::IN_JSMAX+0;
						$::IN_JSARRAY[$pro].="\t$result";
#<script type="text/javascript" src="$::skin_url/$result" charset="$::charset"></script>
#EOM
					$::jscss_included{$name}=2;
				} elsif($result=~/\.css$/) {
					$sub='media="screen"' if($sub eq "");
					push(@::CSSFILES, "$result\t$sub");
					$::jscss_included{$name}=2;
				}
			}
		}
	}
	return '';
}
sub _getcookie {
	&load_module("Nana::Cookie");
	return Nana::Cookie::getcookie(@_);
}
sub _setcookie {
	&load_module("Nana::Cookie");
	return Nana::Cookie::setcookie(@_);
}
sub _read_resource {
	my ($file,%buf) = @_;
	return %buf if $::_resource_loaded{$file}++;
	my $fp=&_safe_open($file);
	my $addkey;
	my $addvalue;
	my $flg=0;
	while (<$fp>) {
		next if /^#/;
		s/[\r\n]//g;
		s/\\n/\n/g;
		if(/\\$/) {
			s/\\$//;
			if(/=/ && $flg eq 0) {
				($addkey, $addvalue) = split(/=/, $_, 2);
				$flg=1;
			} else {
				$addvalue.=$_;
			}
		} else {
			$flg=0;
			if($addkey ne "" && $addvalue ne "") {
				$buf{$addkey}=(defined($::resource_patch{$addkey}) ? $::resource_patch{$addkey} : $addvalue . $_);
				$addkey="";
				$addvalue="";
			} else {
				my ($key, $value) = split(/=/, $_, 2);
				$buf{$key}=(defined($::resource_patch{$key}) ? $::resource_patch{$key} : $value);
			}
		}
	}
	close($fp);
	return %buf;
}
sub _armor_name {
	my ($name) = @_;
	return ($name =~ /^$wiki_name$/o) ? $name : "[[$name]]";
}
sub _unarmor_name {
	my ($name) = @_;
	return ($name =~ /^$bracket_name$/o) ? $1 : $name;
}
sub _is_bracket_name {
	my ($name) = @_;
	return ($name =~ /^$bracket_name$/o) ? 1 : 0;
}
sub _dbmname {
	my ($name) = @_;
	if($::_module_loaded{NanaXS::func}) {
		return NanaXS::func::dbmname($name);
	} else {
		$name =~ s/(.)/$::_dbmname_encode{$1}/g;
		return $name;
	}
}
sub _undbmname {
	my ($name) = @_;
	if($::_module_loaded{NanaXS::func}) {
		return NanaXS::func::undbmname($name);
	} else {
		$name =~ s/([0-9A-F][0-9A-F])/$::_dbmname_decode{$1}/g;
		return $name;
	}
}
sub _decode {
	my ($s) = @_;
	if($::_module_loaded{NanaXS::func}) {
		return NanaXS::func::decode($name);
	} else {
		$s =~ tr/+/ /;
		$s =~ s/%([A-Fa-f0-9][A-Fa-f0-9])/chr(hex($1))/eg;
		# add 0.2.0-p1	# comment
		$s =~ s/%(25)/chr(hex($1))/eg;
		return $s;
	}
}
sub _encode {
	my ($encoded) = @_;
	if($::_module_loaded{NanaXS::func}) {
		return NanaXS::func::encode($name);
	} else {
		$encoded =~ s/(\W)/$::_urlescape{$1}/g;
		$encoded =~ s/\%20/+/g;
		return $encoded;
	}
}
sub _get_now {
	my (@week) = qw(Sun Mon Tue Wed Thu Fri Sat);
	my ($sec, $min, $hour, $day, $mon, $year, $weekday) = localtime(time);
	$weekday = $week[$weekday];
	return sprintf("%d-%02d-%02d ($weekday) %02d:%02d:%02d",
		$year + 1900, $mon + 1, $day, $hour, $min, $sec);
}
sub _load_module{
	my $mod = shift;
	return $mod if $::_module_loaded{$mod}++;
	# bug fix 0.2.0-p3								# comment
	if($mod=~/^[\w\:]{1,64}$/) {
		eval qq( require $mod; );
		$mod=undef if($@);
		return $mod;
	}
	return undef;
}
sub _code_convert {
	my ($contentref, $kanjicode, $icode) = @_;
	&load_module("Nana::Code");
	return Nana::Code::conv($contentref, $kanjicode, $icode);
}
sub _is_exist_page {
	my ($name) = @_;
	return 0 if($name eq '');
	foreach(keys %::fixedpage) {
		if($::fixedpage{$_} ne '' && $_ eq $name) {
			return 1;
		}
	}
	return ($use_exists) ?
		 exists($::database{$name}) ? 1 : 0
		: $::database{$name} ne '' ? 1 : 0;
}
sub _replace {
	my($s, %h)=@_;
	foreach(keys %h) {
		$s=~s/\$$_/$h{$_}/g;
	}
	$s;
}
sub _trim {
	my ($s) = @_;
	$s =~ s/^\s*(\S+)\s*$/$1/o; # trim		# comment
	return $s;
}
sub _escape {
	return &htmlspecialchars(shift);
}
sub _unescape {
	my $s=shift;
	$s=~s/\&(amp|lt|gt|quot);/$::_unescape{$1}/g;
	return $s;
}
sub _htmlspecialchars {
	my($s,$flg)=@_;
	if($::_module_loaded{NanaXS::func}) {
		return NanaXS::func::date(@_);
	} else {
		return $s if($s!~/([<>"&])/);
		$s=~s/([<>"&])/$::_htmlspecial{$1}/g;
		return $s if($flg eq 1);
		# 顔文字、SGML実体参照を戻す						# comment
		$s=~s/&amp;($::_sgmlescape);/&$1;/ig;
		# 10進、16進実態参照を戻す							# comment
		$s=~s/&amp;#([0-9A-Fa-fXx]+)?;/&#$1;/g;
		return $s;
	}
}
sub _javascriptspecialchars {
	my($s)=@_;
	if($::_module_loaded{NanaXS::func}) {
		return NanaXS::func::javascriptspecialchars(@_);
	} else {
		$s=&htmlspecialchars($s);
		$s=~s|'|&apos;|g;
		return $s;
	}
}
sub _strcutbytes {
	my ($src, $maxlen) = @_;
	if ($::lang eq 'ja') {
		if($::defaultcode ne "utf8") {
			$src=&code_convert(\$src, "utf8", $::defaultcode);
		}
	}
	my $buf=&strcutbytes_utf8(substr($src, 0, $maxlen), $maxlen);
	if ($::lang eq 'ja') {
		if($::defaultcode ne "utf8") {
			$buf=&code_convert(\$buf, $::defaultcode, "utf8");
		}
	}
	return $buf;
}
sub _strcutbytes_utf8 {
	my ($src, $maxlen) = @_;
	my $srclen = length($src);
	my $srcpos = 0;
	while($srcpos < $srclen) {
		my $character = substr($src, $srcpos, 1);
		my $value = ord($character);
		if($value < 0x80) { # ASCII characters
			$srcpos ++;
			next;
		}
		my $width = 6;
		$width = 5 if($value < 0xFC);
		$width = 4 if($value < 0xF8);
		$width = 3 if($value < 0xF0);
		$width = 2 if($value < 0xE0);
		my $nextpos = $srcpos + $width;
		last if($nextpos > $maxlen);
		last if($nextpos > $srclen); # sequence is incomplete
		$srcpos = $nextpos;
	}
	return substr($src, 0, $srcpos);
}
sub _fopen {
	my ($fname, $fmode) = @_;
	my $_fname;
	my $fp;
	if ($fname =~ /^http:\/\//) {
		&load_module("Nana::HTTP");
		my $http=new Nana::HTTP(module=>"fopen");
		my($stat, $fp)=$http->open($fname);
		return "" if($stat ne 0);
		autoflush $fp(1);
		return $fp;
	} else {
		reutrn &_safe_open($fname, $fmode);
	}
}
sub _escapeoff {
	my ($flg)=@_;
	return if($::escapeoff_exec eq 1);
	$::escapeoff_exec = 1;
	return if($::form{cmd}!~/edit/);
	$::IN_JSHEAD.=<<EOM;
ev.add("onload", "ebak");
ev.add("onkeydown", @{[$flg eq 2 ? '"eprsc"' : $flg eq 1 ? '"eprs"' : '"eprn"']});
EOM
}
sub _gettz {
	&load_module("Nana::Date");
	return Nana::Date::gettz;
}
sub _getwday {
	&load_module("Nana::Date");
	return Nana::Date::getwday(@_);
}
sub _lastday {
	&load_module("Nana::Date");
	return Nana::Date::lastday(@_);
}
sub _dateinit {
}
sub _date {
	if($::_module_loaded{NanaXS::func}) {
		return NanaXS::func::date(@_);
	} else {
		&load_module("Nana::Date");
		return Nana::Date::date(@_);
	}
}
sub _http_date {
	my ($tm)=@_;
	if($tm+0 eq 0) {
		$tm=time;
	}
	if(&load_module("HTTP::Date")) {
		my $tmp;
		eval {
			$tmp=&HTTP::Date::time2str($tm);
		};
		if($tmp ne '') {
			return $tmp;
		}
	}
	return &_date("D, j M Y G:i:S",0,"gmtime");
}
sub _getremotehost {
	&load_module("Nana::RemoteHost");
	Nana::RemoteHost::get();
}
sub _safe_open {
	my $mode = shift;
	my $file;
	if($mode=~/[\<\>]/) {
		$file=shift;
	} else {
		$file=$mode;
		$mode=lc shift;
	}
	if($file=~/[\<\>]/) {
		die "safe_open:not support $file";
	}
	if($mode eq "" || $mode eq "<" || $mode eq "r") {
		$mode="<";
	} elsif($mode eq "w" || $mode eq ">") {
		$mode=">";
	} elsif($mode eq "w+" || $mode eq "+>") {
		$mode="+>";
	} elsif($mode eq "a" || $mode eq ">>") {
		$mode=">>";
	} else {
		die "safe_open:not support $mode mode";
	}
	my $result;
	my $fh;
	$result = open $fh, $mode, $file;
	unless ($result) {
		warn "$!: $file";
		my $basename=$file;
		$basename=~s/.*\///g;
		$basename=~s/.*\\//g;
		die "safe_open:[$basename] can't access";
	}
	return $fh;
}
sub _location {
	my ($url, $code, $header)=@_;
	$code=302 if($code+0 eq 0);
	print &http_header(
		"Status: $code " . ($code eq 301 ? "Moved Permanently" : "Found"),
		"Location: $url",
		$header,
		"\n\n"
	);
}
1;
