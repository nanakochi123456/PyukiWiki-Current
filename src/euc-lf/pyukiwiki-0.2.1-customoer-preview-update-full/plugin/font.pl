######################################################################
# font.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:50:09
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# Usage: &font(font name) { body };
# v0.2.0-p3 : êVãKçÏê¨
######################################################################
use strict;
package font;
sub plugin_inline {
	my ($font, $body) = split(/,/, shift);
	if ($font eq '' or $body eq '') {
		return "";
	}
	return "<span style=\"font-family:$font;\">$body</span>";
}
1;
__END__
