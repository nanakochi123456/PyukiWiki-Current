######################################################################
# sub.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
package sub;
sub plugin_inline {
	my ($escaped_argument) = @_;
	my ($string) = split(/,/, $escaped_argument);
	return qq(<sub>$string</sub>);
}
sub plugin_usage {
	return {
		name => 'sub',
		version => '1.0',
		author => 'Nekyo <nekyo (at) yamaneko (dot) club (dot) ne (dot) jp>',
		syntax => '&sub(string)',
		description => 'Make sub.',
		example => '&sub(string)',
	};
}
1;
__END__
