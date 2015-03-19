######################################################################
# rss10.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
