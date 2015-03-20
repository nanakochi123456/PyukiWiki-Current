######################################################################
# Sitemaps.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:44:42
#
# "Nana::Sitemaps" ver 0.3 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################

package Nana::Sitemaps;
use strict;
use integer;
use vars qw($VERSION);

$VERSION = '0.3';

# The constructor.
sub new {
	my ($class, %hash) = @_;
	my $self = {
		version => $hash{version},
		encoding => $hash{encoding},
		index => $hash{index},
	};
	return bless $self, $class;
}

# Adding item.
sub add_item {
	my ($self, %hash) = @_;
	push(@{$self->{items}}, \%hash);
	return $self->{items};
}

#
sub as_string {
	my ($self) = @_;
	my $doc;
	if($self->{index} eq 1) {
		$doc=<<EOM;
<?xml version="1.0" encoding="utf-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
@{[
	map {
		qq {
<sitemap>
<loc>$_->{link}</loc>
<lastmod>$_->{dc_date}</lastmod>
</sitemap>
		}
	} @{$self->{items}}
]}
</sitemapindex>
EOM
	} else {
		$doc = <<EOM;
<?xml version="1.0" encoding="utf-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
@{[
	map {
		qq{
<url>
<loc>$_->{link}</loc>
<lastmod>$_->{dc_date}</lastmod>
<priority>$_->{priority}</priority>
@{[$_->{changefreq} ne '' ? "<changefreq>$_->{changefreq}</changefreq>" : ""]}
</url>
		}
	} @{$self->{items}}
]}
</urlset>
EOM
	}
}
1;
__END__

=head1 NAME

Nana::Sitemaps - Generate sitemaps module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/Sitemaps.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/Sitemaps.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/Sitemaps.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/Sitemaps.pm?view=log>

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
