######################################################################
# sup.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:05:24
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################

use strict;

package sup;

sub plugin_inline {
	my ($escaped_argument) = @_;
	my ($string) = split(/,/, $escaped_argument);
	return qq(<sup>$string</sup>);
}

sub plugin_usage {
	return {
		name => 'sup',
		version => '1.0',
		author => 'Nekyo',
		syntax => '&sup(string)',
		description => 'Make sub.',
		example => '&sup(string)',
	};
}

1;
__END__
=head1 NAME

sup.pl - PyukiWiki / YukiWiki Plugin

=head1 SYNOPSIS

 &sup(strings);
 2&sup(2);=4

=head1 DESCRIPTION

Character display at upper.

This plugin is compatible with YukiWiki.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/sup

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/sup/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/sup.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/sup.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/sup.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/sup.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2004-2007 by Nekyo.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
