######################################################################
# title.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:41:36
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
# v0.2.0-p2 add option
# v0.2.0 First Release
#
#*Usage
# #title(title tag string)
# #title(title tag string,add)
######################################################################
sub plugin_title_convert {
	my ($arg) = shift;
	return if(!&is_frozen($::form{mypage}));
	my($title,$flg)=split(/,/,$arg);
	if($flg ne '') {
		$::IN_TITLE=&htmlspecialchars($title) . "\t";
	} else {
		$::IN_TITLE=&htmlspecialchars($title);
	}
	return ' ';
}
1;
__END__
