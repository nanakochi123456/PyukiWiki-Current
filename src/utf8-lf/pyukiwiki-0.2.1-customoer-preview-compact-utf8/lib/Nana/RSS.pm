######################################################################
# RSS.pm - $Id$
#
# "Nana::RSS" ver 0.3 $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package Nana::RSS;
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
		version => $hash{version},
		channel => { },
		items => [],
	};
	return bless $self, $class;
}
# Setting channel.
sub channel {
	my ($self, %hash) = @_;
	foreach (keys %hash) {
		$self->{channel}->{$_} = $hash{$_};
	}
	return $self->{channel};
}
# Adding item.
sub add_item {
	my ($self, %hash) = @_;
	foreach(keys %hash) {
		if($hash{$_} =~ /\n/) {
			my $s=$hash{$_};
			if($self->{version} eq "atom") {
				$s=~s/\n//g;
			} else {
				$s=~s/\n/\<br \/\>\n/g;
			}
			$hash{$_}="<![CDATA[$s]]>";
		}
	}
	push(@{$self->{items}}, \%hash);
	return $self->{items};
}
#
sub as_string {
	my ($self) = @_;
	my $doc;
	if($self->{version} eq "1.0") {
		$doc = <<"EOD";
<?xml version="1.0" encoding="$self->{encoding}" ?>
<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns="http://purl.org/rss/1.0/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
>
<channel rdf:about="$self->{channel}->{link}">
 <title>$self->{channel}->{title}</title>
 <link>$self->{channel}->{link}</link>
 <description>$self->{channel}->{description}</description>
 <items>
  <rdf:Seq>
   @{[
    map {
     qq{<rdf:li rdf:resource="$_->{link}" />}
    } @{$self->{items}}
   ]}
  </rdf:Seq>
 </items>
</channel>
@{[
 map {
  qq{
   <item rdf:about="$_->{link}">
    <title>$_->{title}</title>
    <link>$_->{link}</link>
    <description>$_->{description}</description>
    <dc:date>$_->{dc_date}</dc:date>
   </item>
  }
 } @{$self->{items}}
]}
</rdf:RDF>
EOD
	} elsif($self->{version} eq "2.0") {
		$doc = <<"EOD";
<?xml version="1.0" encoding="$self->{encoding}"?>
<rss
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:content="http://purl.org/rss/1.0/modules/content/"
 version="2.0">
<channel>
<title>$self->{channel}->{title}</title>
<link>$self->{channel}->{link}</link>
<description>$self->{channel}->{description}</description>
<language>$self->{channel}->{language}</language>
<lastBuildDate>$self->{channel}->{lastbuilddate}</lastBuildDate>
@{[
 map {
  qq{
	<item>
		<title>$_->{title}</title>
		<link>$_->{link}</link>
		<description>$_->{description}</description>
		<pubDate>$_->{dc_date}</pubDate>
	</item>
  }
 } @{$self->{items}}
]}
</channel>
</rss>
EOD
	} elsif($self->{version} eq "atom") {
		$doc = <<"EOD";
<?xml version="1.0" encoding="$self->{encoding}"?>
<feed version="0.3" xml:lang="$self->{language}" xmlns="http://purl.org/atom/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/">
<title>$self->{channel}->{title}</title>
<link rel="alternate" type="text/html" href="$self->{channel}->{basehref}" />
<generator uri="$self->{channel}->{basehref}">$self->{channel}->{wikititle}</generator>
<tagline>$self->{channel}->{description}</tagline>
@{[
 map {
  qq{
	<entry>
		<title>$_->{title}</title>
		<link rel="alternate" type="text/html" href="$_->{link}" />
		<modified>$_->{dc_date}</modified>
		<summary>$_->{description}</summary>
	</entry>
  }
 } @{$self->{items}}
]}
</feed>
EOD
	}
	$doc;
}
1;
__END__
