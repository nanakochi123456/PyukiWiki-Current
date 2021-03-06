######################################################################
# trackback.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:16:10
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'trackback.inc.cgi'
######################################################################
# ディレクトリ
$trackback::directory="$::data_home/trackback"
	if(!defined($trackback::directory));
use strict;
use Nana::MD5 qw(md5_hex);
@trackback::allowcmd=(
	"read",
	"edit",
	"adminedit",
	"diff",
	"backup",
	"setting",
	"tb",
);
%::trackbackbase;
$trackback::md5pagename;
sub plugin_trackback_init {
	&exec_explugin_sub("lang");
	&exec_explugin_sub("urlhack");
	&exec_explugin_sub("autometarobot");
	if($::_exec_plugined{lang} eq 2) {
		if($::defaultlang ne $::lang) {
			$trackback::directory.=".$::lang";
		}
	}
	my $err;
	my $err=&writechk($trackback::directory);
	if($err ne '') {
		&print_error($err);
		exit;
	}
	my $flg=0;
	foreach(@trackback::allowcmd) {
		$flg=1 if($_ eq $::form{cmd});
	}
	if($flg eq 1 && $::form{mypage} ne '') {
		$trackback::md5pagename=&tb_get_id($::form{mypage});
	} else {
		$flg=0;
	}
	return('init'=>0) if(&chkpage($::form{mypage}) eq 1);
	if($flg eq 1 && $::navi{"trackback_url"} eq '') {
		&dbopen($trackback::directory,\%::trackbackbase);
		# http://www.tohoho-web.com/lng/199912/99120066.htm # comment
		# http://www.aleph.co.jp/~fujiwara/perl/lc.pl # comment
		my $trackbackcount = ($::trackbackbase{$::form{mypage}} =~ tr/\n/\n/);
		&dbclose(\%::trackbackbase);
		push(@::addnavi,"trackback:help");
		my $langflg=$::_exec_plugined{lang}+0 eq 2 ? "lang=$::lang&amp;" : "";
		$::navi{"trackback_url"}="$::script?cmd=tb&amp;tb_id=$trackback::md5pagename&amp;@{[$langflg]}\__mode=view";
		$::navi{"trackback_name"}=$::resource{"trackbackbutton"};
		$::navi{"trackback_name"}=~s/\$COUNT/$trackbackcount/g;
		$::navi{"trackback_type"}="plugin";
	}
	return ('init'=>1
		, 'last_func'=>'&trackback_last;');
}
sub trackback_last {
}
# pukiwiki compatible function					# comment
sub tb_get_id {
	my($page)=@_;
	return md5_hex($page);
}
%trackback::cache;
sub tb_id2page {
	my($tb_id)=@_;
	return $trackback::cache{$tb_id}
		if($trackback::cache{$tb_id} ne '');
	foreach my $page (keys %::database) {
		my $_tb_id=&tb_get_id($page);
		$trackback::cache{$_tb_id}=$page;
		return $trackback::cache{$tb_id}
			if($tb_id eq $_tb_id);
	}
	$trackback::cache{$tb_id}="";
	return "";
}
sub chkpage {
	my ($page)=@_;
	if($page=~/$::resource{help}|$::resource{rulepage}|$::RecentChanges|$::MenuBar|$::SideBar|$::TitleHeader|$::Header|$::Footer$::BodyHeader$::BodyFooter|$::SkinFooter|$::SandBox|$::InterWikiName|$::InterWikiSandBox|$::non_list/
		|| &is_readable($page) eq 0) {
		return 1;
	}
	my $flg=0;
	foreach(@trackback::allowcmd) {
		$flg=1 if($_ eq $::form{cmd});
	}
	return 0 if($flg eq 1);
	return 1;
}
1;
__DATA__
sub plugin_trackback_setup {
	return(
		en=>'Send trackback.',
		jp=>'trackbackを処理する,
		override=>'none',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/trackback/'
	);
__END__
