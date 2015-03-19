######################################################################
# wiki_init.cgi - $Id$
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
sub _writablecheck {
	my $err;
	$err.=&writechk($::data_dir);
	$err.=&writechk($::diff_dir);
	$err.=&writechk($::cache_dir);
	$err.=&writechk($::counter_dir);
	$err.=&writechk($::upload_dir);
	&print_error($err) if($err ne '');
}
sub _writechk {
	my($dir)=shift;
	return "Directory is not found or not writable ($dir)<br />\n"
		if(!-w $dir);
	return '';
}
	# 2005.10.27 pochi: speedy_cgiで実行可能に				# comment
sub _init_global {
	&close_db;
	%::form = ();
	%::database = ();
	%::infobase = ();
	%::diffbase = ();
	%::interwiki = ();
	%::_resource_loaded = ();
	$lastmod = "";
	%::_plugined = ();
	$::pageplugin=0;
	%::_exec_plugined=();
	%::_exec_plugined_func=();
	%::_exec_plugined_value=();
	%::_module_loaded=();
	# 0〜255のテーブル生成
	foreach my $i (0x00 .. 0xFF) {
		$::_urlescape{chr($i)} = sprintf('%%%02x', $i);
		$::_dbmname_encode{chr($i)} = sprintf('%02X', $i);
		$::_dbmname_decode{sprintf('%02X', $i)} = chr($i);
	}
	$::_urlescape{chr(32)} ='+';
}
sub _init_lang {
	$::defaultcode="utf8";
	$::charset="utf-8";
	$::kanjicode="utf8";
	# $::modifierlinkが存在しない時、基準URLを代入			# comment
	$::modifierlink=$::basehref if($::modifierlink eq '');}
sub _init_form {
	if ($qCGI->param()) {
		foreach my $var ($qCGI->param()) {
			$::form{$var} = $qCGI->param($var);
		}
	} else {
		$ENV{QUERY_STRING} = $::FrontPage;
	}
	# Thanks Mr.koizumi. v0.1.4							# comment
	my $query = $ENV{QUERY_STRING};
	if ($query =~ /&/) {
		my @querys = split(/&/, $query);
		foreach (@querys) {
			$_ = &decode($_);
			$::form{$1} = $2 if (/([^=]*)=(.*)$/);
		}
	} else {
		$query = &decode($query);
	}
	if (&is_exist_page($query)) {
		$::form{cmd} = 'read';
		$::form{mypage} = $query;
	}
	# mypreview_edit			-> do_edit, with preview.			# comment
	# mypreview_adminedit		-> do_adminedit, with preview.		# comment
	# mypreview_write			-> do_write, without preview.		# comment
	# mypreview_blogedit		-> do_edit, with preview.			# comment
	# mypreview_blogadminedit	-> do_adminedit, with preview.		# comment
	# mypreview_blogwrite		-> do_write, without preview.		# comment
	# mypreviewjs_edit			-> do_edit, with preview.			# comment
	# mypreviewjs_adminedit		-> do_adminedit, with preview.		# comment
	# mypreviewjs_write			-> do_write, without preview.		# comment
	# mypreviewjs_blogedit		-> do_edit, with preview.			# comment
	# mypreviewjs_blogadminedit	-> do_adminedit, with preview.		# comment
	# mypreviewjs_blogwrite		-> do_write, without preview.		# comment
	foreach (keys %::form) {
		if (/^mypreview_blog(.*)$/ || /^mypreviewjs_blog(.*)$/) {
			if($::form{$_} ne '') {
				$::form{cmd} = "blog";
				$::form{mode} = $1;
				$::form{mypreview} = 1;
			}
		} elsif (/^mypreview_(.*)$/ || /^mypreviewjs_(.*)$/) {
			if($::form{$_} ne '') {
				$::form{cmd} = $1;
				$::form{mypreview} = 1;
			}
		}
	}
	foreach("mymsg", "word", "myname", "mypage", "page"
		  , "refer", "under", "template") {
		$::form{$_} = &code_convert(\$::form{$_}, $::defaultcode,$::kanjicode)
			if($::form{$_});
	}
}
$::gzip_exec;
sub _gzip_init {
	$::gzip_exec=1;
	# force init setting.inc.cgi
	&exec_explugin_sub("setting")  if($::useExPlugin > 0);
	if($::setting_cookie{gzip} ne '') {
		$::gzip_exec=0 if($::setting_cookie{gzip}+0 eq 0);
	}
	if($::gzip_exec eq 1) {
		&load_module("Nana::HTTPCompress");
		$::HTTP_HEADER.=Nana::HTTPCompress::init($::gzip_path);
	}
}
sub _skin_init {
	$::skin_file="$::skin_dir/" . &skin_check("$::skin_name.skin%s.cgi",".$::lang","");
	$::skin{default_css}=&skin_check("$::skin_name.default%s.css",".$::lang","");
	$::skin{print_css}=&skin_check("$::skin_name.print%s.css",".$::lang","");
	$::skin{common_js}=&skin_check("common%s.js",".unicode.$::lang",".$::kanjicode.$::lang",".$::lang");
	$::IN_CSSFILES.=<<EOM;
<link rel="stylesheet" href="$::skin_url/$::skin{default_css}" type="text/css" media="screen" charset="$::charset" />
<link rel="stylesheet" href="$::skin_url/$::skin{print_css}" type="text/css" media="print" charset="$::charset" />
EOM
	my $common=$::skin{common_js};
	$common=~s/\.js$//g;
	&jscss_include($common);
	$::IN_JSFILES=~s/^,//g;
}
sub _skin_check {
	my($fmt)=shift;
	my(@arg)=@_;
	foreach(@arg) {
		my $f=sprintf($fmt,$_);
		next if($f eq '');
		return $f if(-r "$::skin_dir/$f");
	}
	return '';
}
sub _init_InterWikiName {
	my $content = $::database{$InterWikiName};
	while ($content =~ /$interwiki_definition/g) {
		my ($name, $url) = ($1, $2);
		#v0.1.6												# comment
		$name=~tr/A-Z/a-z/;
		$::interwiki{$name} = $url;
	}
	while ($content =~ /$interwiki_definition2/g) {
		#v0.1.6												# comment
		my ($url,$name,$code)=($1,$2,$3);
		$name=~tr/A-Z/a-z/;
		$::interwiki2{$name}{$code} = $url;
	}
}
sub _init_inline_regex {
	$::inline_regex =qq(($::bracket_name)|($::embedded_inline));
	$::inline_regex.=qq(|($::isurl))				# Direct URL	# comment
		if($::autourllink eq 1);
	$::inline_regex.=qq(|(mailto:$::ismail)|($::ismail))# Mail			# comment
		if($::automaillink eq 1);
	$::inline_regex.=qq(|($::wiki_name)) # LocalLinkLikeThis (WikiName) # comment
		if($::nowikiname ne 1);
}
sub _init_follow {
	if($::follow eq 2) {
		$::followtag_pub=qq( rel="follow");
	} elsif($::follow eq 0) {
		$::followtag_pub=qq( rel="nofollow");
	} else {
		$::followtag_pub=qq( rel="follow");
	}
}
sub init_recovery {
	return if($::auto_recovery eq 0);
	return if($::form{mypage} eq $::FrontPage);
	return if($::FrontPage ne "FrontPage");
	return if($::database{$::FrontPage} ne "");
	return if($::form{cmd} ne "");
	$::form{cmd} = "recovery";
	$::form{all} = 1;
}
1;
