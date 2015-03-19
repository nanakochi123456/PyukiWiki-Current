######################################################################
# hr.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
package hr;
sub plugin_block {
	return &plugin_inline;
}
sub plugin_inline {
	return '<hr class="short_line" />';
}
sub plugin_usage {
	return {
		name => 'hr',
		version => '1.0',
		author => 'Nanami <nanami (at) daiba (dot) cx>',
		syntax => '#hr',
		description => '',
		example => '#hr',
	};
}
1;
__END__
