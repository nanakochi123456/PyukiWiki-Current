######################################################################
# rss10.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 10:04:50
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 2012/09/28 移動
######################################################################
sub plugin_rss10_action {
	&getbasehref;
	&location(
		"$::basehref?cmd=rss&ver=1.0"
		. ($::form{lang} ne "" ? ("&lang=" . $::form{lang}) : "")
		, 301);
	exit;
}
1;
__END__
