######################################################################
# verb.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:23:32
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Hiroshi Yuki http://www.hyuki.com/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
=head1 NAME

verb.pl - PyukiWiki / YukiWiki Plugin

=head1 SYNOPSIS

 &verb(text...);

=head1 DESCRIPTION

Disregards the format rule of PyukiWiki

It is for compatibility with YukiWiki.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/verb

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/verb/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/verb.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/verb.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/verb.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/verb.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Hiroshi Yuki

L<http://www.hyuki.com/>

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2002-2015 by Hiroshi Yuki.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
