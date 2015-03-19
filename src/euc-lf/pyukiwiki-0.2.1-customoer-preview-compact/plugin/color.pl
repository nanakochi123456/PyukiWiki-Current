######################################################################
# color.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
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
