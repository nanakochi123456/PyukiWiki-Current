######################################################################
# pathmenu.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:14:28
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'pathmenu.inc.cgi'
######################################################################
use strict;
$pathmenu::loaded=1;
sub plugin_pathmenu_init {
	if(&exist_plugin("topicpath") ne 0) {
		my $mypage=$::form{mypage};
		my @path_array = split($topicpath::SEPARATOR,$mypage);
		my $c=0;
		my @paths=();
		my $pathtop;
		foreach my $pagename(@path_array) {
			if($c eq 0) {
				$pathtop=$pagename;
			} else {
				$pathtop .= $topicpath::SEPARATOR . $pagename;
			}
			push(@paths, $pathtop);
			$c++;
		}
		foreach my $pagename(@paths) {
			$::MenuBar		=&chkbars($pagename, $::MenuBar);
			$::SideBar		=&chkbars($pagename, $::SideBar);
			$::TitleHeader	=&chkbars($pagename, $::TitleHeader);
			$::Header		=&chkbars($pagename, $::Header);
			$::Footer		=&chkbars($pagename, $::Footer);
			$::BodyHeader	=&chkbars($pagename, $::BodyHeader);
			$::BodyFooter	=&chkbars($pagename, $::BodyFooter);
			$::SkinFooter	=&chkbars($pagename, $::SkinFooter);
		}
		return('init'=>1);
	}
	return('init'=>0);
}
sub chkbars {
	my($pg,$menu)=@_;
	if($::database{"$pg$topicpath::SEPARATOR$menu"} ne '') {
		return "$pg$topicpath::SEPARATOR$menu";
	}
	return $menu;
}
1;
__DATA__
sub plugin_pathmenu_setup {
	return(
		ja=>'階層下にMenuBar等を作る',
		en=>'Create a hierarchy under MenuBar etc. system page.',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/pathmenu/'
	);
__END__
