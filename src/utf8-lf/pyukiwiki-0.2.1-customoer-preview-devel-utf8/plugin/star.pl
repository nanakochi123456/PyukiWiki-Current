######################################################################
# star.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:05:20
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################

use strict;

$STAR::STRING1=qq(<span class="star1">&#9733;</span>)
	if(!defined($STAR::STRING1));
$STAR::STRING2=qq(<span class="star2">&#9734;</span>)
	if(!defined($STAR::STRING2));

package star;

sub plugin_inline {
	my @args = split(/,/, shift);
	my $max=5;
	my $now=0;

	if(@args >= 2) {
		if($args[1]+0 > 0) {
			$max=$args[1];
		}
	}
	if($args[0]+0 > 0) {
		$now=$args[0];
	}

	my $out;
	for (my $i=1; $i <= $max; $i++) {
		if($i <= $now) {
			$out.=$STAR::STRING1;
		} else {
			$out.=$STAR::STRING2;
		}
	}
	return $out;
}

1;
__END__

=head1 NAME

star.pl - PyukiWiki / YukiWiki Plugin

=head1 SYNOPSIS

 &star(4);
 &star(3,10);

=head1 DESCRIPTION

Display rank of star.

This plugin is compatible with YukiWiki.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/star

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/star/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/star.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/star.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/star.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/star.pl?view=log>

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
