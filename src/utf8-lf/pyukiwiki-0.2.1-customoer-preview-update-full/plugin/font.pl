######################################################################
# font.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:40:04
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
# Usage: &font(font name) { body };
# v0.2.0-p3 : 新規作成
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
