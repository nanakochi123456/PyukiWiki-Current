######################################################################
# verb.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Hiroshi Yuki
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
package verb;
sub plugin_inline {
	my ($escaped_argument) = @_;
	return qq(<span class="verb">$escaped_argument</span>);
}
sub plugin_usage {
	return {
		name => 'verb',
		version => '1.0',
		author => 'Hiroshi Yuki http://www.hyuki.com/',
		syntax => '&verb(as-is string)',
		description => 'Inline verbatim (hard).',
		example => '&verb(ThisIsNotWikiName)',
	};
}
1;
__END__
