######################################################################
# br.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:14:33
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
use strict;
package br;
sub plugin_block {
	return &plugin_inline;
}
sub plugin_inline {
	return qq(<br />);
}
sub plugin_usage {
	return {
		name => 'br',
		version => '1.0',
		type => 'yukiwiki,block,inline',
		author => 'Nekyo',
		syntax => '&br;',
		description => 'line break.',
		description_ja => '���s�����܂�',
		example => '&br;',
	};
}
1;
__END__