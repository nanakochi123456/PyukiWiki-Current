######################################################################
# font.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:23:38
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# Usage: &font(font name) { body };
# v0.2.0-p3 : êVãKçÏê¨
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

=head1 NAME

font.pl - PyukiWiki / YukiWiki Plugin

=head1 SYNOPSIS

 &font(font name){text};

=head1 DESCRIPTION

Set display font.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/font

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/font/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/font.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/font.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/font.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/font.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nano.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2005-2015 by Nanami.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
