######################################################################
# color.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:55:08
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# Usage: &color(color,bgcolor) { body };
# Usage: &color(color) { body };
# Usage: &color(,bgcolor) { body };
# v0.2.0-p3 : îwåiêFÇÃÇ›ÇÃê›íËÇÇ≈Ç´ÇÈÇÊÇ§Ç…ÇµÇΩÅB
######################################################################

use strict;
package color;

sub plugin_inline {
	my @args = split(/,/, shift);
	my ($color, $bgcolor, $body);

	if (@args == 3) {
		$color = $args[0];
		$bgcolor = $args[1];
		$body = $args[2];
		if ($body eq '') {
			$body = $bgcolor;
			$bgcolor = '';
		}
	} elsif (@args == 2) {
		$color = $args[0];
		$body = $args[1];
	} else {
		return '';
	}
	if ($color eq '' && $bgcolor eq '' || $body eq '') {
		return '';
	}
	my $style;
	$style.="color:$color;" if($color ne '');
	$style.="background-color:$bgcolor;" if($bgcolor ne '');

	return "<span style=\"$style\">$body</span>";
}

1;
__END__

=head1 NAME

color.pl - PyukiWiki / YukiWiki Plugin

=head1 SYNOPSIS

 &color(color, [background-color]){text};
 &color(red){Sample Text};
 &color(#ff0000,#000000){Sample Text};
 &color(,white){Sample Text};

=head1 DESCRIPTION

The character color and background color of a text are specified.

This plugin is compatible with YukiWiki.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/color

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/color/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/color.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/color.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/color.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/color.pl?view=log>

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
