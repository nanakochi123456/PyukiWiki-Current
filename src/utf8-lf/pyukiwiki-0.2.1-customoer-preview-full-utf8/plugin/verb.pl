######################################################################
# verb.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Hiroshi Yuki http://www.hyuki.com/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
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
