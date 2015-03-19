######################################################################
# rss10.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:23
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 2012/09/28 °ÜÆ°
######################################################################

sub plugin_rss10_action {
	&getbasehref;
	&location(
		"$::basehref?cmd=rss&ver=1.0"
		. ($::form{lang} ne "" ? ("&lang=" . $::form{lang}) : "")
		, 301);
	exit;
}
1;
__END__
=head1 NAME

rss10.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 ?cmd=rss10[&lang=lang]

=head1 DESCRIPTION

Output RSS (RDF Site Summary) 1.0 from RecentChanges

for compatible plugin.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/rss10

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/rss10/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/rss10.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/rss10.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/rss10.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/rss10.inc.pl?view=log>

=item YukiWiki

using Yuki::RSS.

L<http://www.hyuki.com/yukiwiki/>

=back

=head1 AUTHOR

=item Nekyo

obsoleted

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=head1 LICENSE

(C)2004-2007 by Nekyo.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
