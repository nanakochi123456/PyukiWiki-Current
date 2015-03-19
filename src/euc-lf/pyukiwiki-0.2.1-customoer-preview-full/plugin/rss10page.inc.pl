######################################################################
# rss10page.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
# rss10page.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 2012/09/28 ˆÚ“®
######################################################################
sub plugin_rss10page_action {
	&getbasehref;
	&location(
		"$::basehref?cmd=rss10page&ver=1.0"
		. ($::form{lang} ne "" ? ("&lang=" . $::form{lang}) : "")
		, 301);
	exit;
}
sub plugin_rss10page_inline {
	require "$::plugin_dir/rsspage.inc.pl";
	return &plugin_rsspage_inline(@_);
}
sub plugin_rss10page_convert {
	require "$::plugin_dir/rsspage.inc.pl";
	return &plugin_rsspage_convert(@_);
}
1;
__END__
