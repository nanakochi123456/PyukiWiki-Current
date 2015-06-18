######################################################################
# rss10page.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:21:19
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# rss10page.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:21:19
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 2012/09/28 ˆÚ“®
######################################################################

sub plugin_rss10page_action {
	&getbasehref;
	&location(
		"$::basehref?cmd=rss10page&ver=1.0"
		. ($::form{lang} ne "" ? ("&lang=" . $::form{lang}) : "")
		, 301);
	exit;
}

sub plugin_rss10page_inline {
	require "$::plugin_dir/rsspage.inc.pl";
	return &plugin_rsspage_inline(@_);
}

sub plugin_rss10page_convert {
	require "$::plugin_dir/rsspage.inc.pl";
	return &plugin_rsspage_convert(@_);
}

1;
__END__

=head1 NAME

rss10page.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 ?cmd=rss10page&page=pagename[&lang=lang]
 #rss10page(- or *)

=head1 DESCRIPTION

Output RSS (RDF Site Summary) 1.0 from it's page

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/rss10page

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/rss10page/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/rss10page.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/rss10page.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/rss10page.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/rss10page.inc.pl?view=log>

=item YukiWiki

Using Yuki::RSS

L<http://www.hyuki.com/yukiwiki/>

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
