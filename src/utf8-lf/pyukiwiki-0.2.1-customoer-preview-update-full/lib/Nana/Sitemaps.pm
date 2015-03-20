######################################################################
# Sitemaps.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:54:04
#
# "Nana::Sitemaps" ver 0.3 $$
# Author Nanami
# http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
