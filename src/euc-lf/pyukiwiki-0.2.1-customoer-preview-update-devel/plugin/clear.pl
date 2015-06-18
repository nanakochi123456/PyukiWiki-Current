######################################################################
# clear.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:23:35
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

use strict;
package clear;

sub plugin_inline {
	return '<div class="clear"></div>';
}
1;

__END__

=head1 NAME

clear.pl - PyukiWiki / YukiWiki Plugin

=head1 SYNOPSIS

 &clear;

=head1 DESCRIPTION

Disable a surroundings lump of a text

inserts a CSS class 'clear', to set 'clear:both'

This plugin is compatible with YukiWiki.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/clear

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/clear/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/clear.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/clear.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/clear.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/clear.pl?view=log>

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
