######################################################################
# wiki_plugin.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
sub _exec_plugin {
	my $exec = 1;
	# add plugin securityh v0.2.1						# comment
	return if($::plugin_disable{$::form{cmd}}+0);
	# add 0.2.0-p4 fix add security fix
	if ($::form{cmd}=~/^\w{1,64}$/) {
		if (&exist_plugin($::form{cmd}) == 1) {
			my $action = "\&plugin_" . $::form{cmd} . "_action";
			my %ret = eval $action;
			$::debug.=$@;
			if (($ret{msg} ne '') && ($ret{body} ne '')) {
				$::HTTP_HEADER.=$ret{http_header};
				$::IN_HEAD.=$ret{header};
				$::IN_CSSHEAD.=$ret{cssheader};
				$::IN_JSHEAD.=$ret{jsheader};
				$::IN_JSHEADVALUE.=$ret{jsheadervalue};
				$::IN_BODY.=$ret{bodytag};
				$exec = 0;
				$::allview = 0 if($ret{notviewmenu} eq 1);
				$::pageplugin=1 if($ret{ispage} eq 1);
				&skinex($ret{msg}, $ret{body});
			}
		}
	}
	return $exec;
}
sub _exec_explugin {
	# /lib/*.inc.cgiを検索し、すべて実行				# comment
	opendir(DIR,"$::explugin_dir");
	while(my $dir=readdir(DIR)) {
		if($dir=~/(.*?)\.inc\.cgi$/) {
			next if($1 eq 'gzip'); # gzip.inc.cgi 廃止に伴う	# comment
			my $explugin=$1;
			&exec_explugin_sub($explugin);
		}
	}
}
sub _exec_explugin_sub {
	my($explugin)=@_;
	foreach(@::loaded_explugin) {
		return if($explugin eq $_);
	}
	if (&exist_explugin($explugin) eq 1) {
		# initメソッドの実行							# comment
		my $action = "\&plugin_" . $explugin . "_init";
		push(@::loaded_explugin,$explugin);
		my %ret = eval $action;
		$::debug.=$@;
		# 0.2.0-p4 change
		if($ret{init}) {
			$::_exec_plugined{$explugin} = 2;
			$::IN_HEAD.=&jscss_include($explugin);
		}
		# 重複関数の検査								# comment
		foreach(split(/,/,$ret{func})) {
			if($_exec_plugined_func{$_} ne '' ) {
				&skinex("\t\t$ErrorPage","$::resource{dupexplugin}<ul><li>$_exec_plugined_func{$_}<li>$explugin</li></ul>");
				exit;
			}
			$_exec_plugined_func{$_}=$explugin;
			$::functions=$ret{$_};
		}
		# 重複上書き関数の検査							# comment
		foreach(split(/,/,$ret{value})) {
			if($_exec_plugined_value{$_} ne '' ) {
				&skinex("\t\t$ErrorPage","$::resource{dupexplugin}<ul><li>$_exec_plugined_value{$_}<li>$explugin</li></ul>");
				exit;
			}
			$_exec_plugined_value{$_}=$explugin;
			$::values=$ret{$_};
		}
		# ヘッダを設定									# comment
		$::HTTP_HEADER.="$ret{http_header}\n";
		$::IN_HEAD.=$ret{header};
		$::IN_CSSHEAD.=$ret{cssheader};
		$::IN_JSHEAD.=$ret{jsheader};
		$::IN_JSHEADVALUE.=$ret{jsheadervalue};
		$::IN_BODY.=$ret{bodytag};
		# 終了時関数を設定								# comment
		$explugin_last.="$ret{last_func},";
		# msg, body 設定時、表示して終了（エラー時等用）	# comment
		if (($ret{msg} ne '') && ($ret{body} ne '')) {
			$exec = 0;
			&skinex($ret{msg}, $ret{body});
			exit;
		}
	}
}
sub _exist_plugin {
	my ($plugin) = @_;
	# add plugin securityh v0.2.1						# comment
	return if($::plugin_disable{$plugin}+0);
	if (!$_plugined{$plugin}) {
		# bug fix 0.2.0-p3								# comment
		if($plugin=~/^\w{1,64}$/) {
			my $path = "$::plugin_dir/$plugin" . '.inc.pl';
			if (-e $path) {
				require $path;
				$::debug.=$@;
				$_plugined{$1} = 1;	# Pyuki
				# 0.2.0-p4										# comment
				# 0.2.1
				if($plugin eq "smedia") {
					$::IN_HEAD.=&jscss_include($plugin, ",");
				} else {
					$::IN_HEAD.=&jscss_include($plugin);
				}
				# v0.1.6										# comment
				$path="$::res_dir/$plugin.$::lang.txt";
				%::resource = &read_resource($path,%::resource) if(-r $path);
				return 1;
			} else {
				$path = "$::plugin_dir/$plugin" . '.pl';
				if (-e $path) {
					require $path;
					$::debug.=$@;
					$_plugined{$1} = 2;	# Yuki
					return 2;
				}
			}
		}
		return 0;
	}
	return $_plugined{$plugin};
}
sub _exist_explugin {
	my ($explugin) = @_;
	if (!$_exec_plugined{$explugin}) {
		# bug fix 0.2.0-p3								# comment
		if($explugin=~/^\w{1,64}$/) {
			my $path = "$::explugin_dir/$explugin" . '.inc.cgi';
			if (-e $path) {
				require $path;
				$::debug.=$@;
				$_exec_plugined{$1} = 1;	# Loaded		# comment
				$path="$::res_dir/$explugin.$::lang.txt";
				%::resource = &read_resource($path,%::resource) if(-r $path);
				return 1;
			}
		}
		return 0;
	}
	return $_exec_plugined{$explugin};
}
sub _exec_explugin_last {
	if($::useExPlugin > 0) {
		foreach(split(/,/,$explugin_last)) {
			next if ($_ eq '');
			my $action = $_;
			eval $action;
		}
	}
}
sub _embedded_to_html {
	my $embedded = shift;
	if ($embedded =~ /$embed_plugin/) {
		my $exist = &exist_plugin($1);
		my $action = '';
		if ($exist == 1) {
			$action = "\&plugin_" . $1 . "_convert('$3')";
		} elsif ($exist == 2) {
			$action = "\&$1::plugin_block('$3');";
		}
		if ($action ne '') {
			$_ = eval $action;
			$::debug.=$@;
			return ($_) ? $_ : &htmlspecialchars($embedded);
		}
	}
	return $embedded;
}
sub _embedded_inline {
	my ($embedded,$opt)=@_;
	my($cmd,$arg);
	if($embedded=~/$::embedded_inline/g) {
		if($1 ne '') {
			$cmd=$1;
			$arg=$2;
		} elsif($3 ne '') {
			$cmd=$3;
		} elsif($4 ne '') {
			$cmd=$4;
			$arg=$5;
		} elsif($6 ne '') {
			$cmd=$6;
			$arg="$7,$8";
		}
		my $exist = &exist_plugin($cmd);
		my $action = '';
		if ($exist == 1) {
			$action = "\&plugin_" . $cmd . "_inline('$arg')";
		} elsif ($exist == 2) {
			$action = "\&" . $cmd . "::plugin_inline('$arg');";
		}
		if ($action ne '') {
			$_ = eval $action;
			$::debug.=$@;
			return $_ if ($_);
		}
	}
	# buf fix v0.2.0									# comment
	return $embedded;
}
1;
