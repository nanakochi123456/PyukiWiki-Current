######################################################################
# br.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
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
		description_ja => '改行をします',
		example => '&br;',
	};
}
1;
__END__
