######################################################################
# size.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:55:59
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
package size;
sub plugin_inline {
	my ($size, $body) = split(/,/, shift);
	if ($size eq '' or $body eq '') {
		return "";
	}
	return "<span style=\"font-size:" . $size . "px;display:inline-block;line-height:130%;text-indent:0px\">$body</span>";
}
1;
__END__
