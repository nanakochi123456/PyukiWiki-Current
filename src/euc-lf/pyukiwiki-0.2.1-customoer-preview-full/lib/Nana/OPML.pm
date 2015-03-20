######################################################################
# OPML.pm - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "Nana::OPML" ver 0.2 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package	Nana::OPML;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.2';
# The constructor.
sub new {
	my ($class, %hash) = @_;
	my $self = {
		version => $hash{version},
		encoding => $hash{encoding},
		channel => { },
		items => [ ],
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
	push(@{$self->{items}}, \%hash);
	return $self->{items};
}
sub as_string {
	my ($self) = @_;
	my $nest=0;
	my $doc = <<"EOD";
<?xml version="1.0" encoding="$self->{encoding}"?>
<opml version="1.0">
<head>
	<title>$self->{channel}->{title}</title>
</head>
<body>
EOD
	foreach(@{$self->{items}}) {
		$_->{link}=~s/[\r\n]//g;
		$_->{title}=~s/[\r\n]//g;
		$_->{xmlurl}=~s/[\r\n]//g;
		if($_->{xmlurl} eq '') {
			$doc.=qq(</outline>\n) if($nest eq 1);
			$doc.=qq(<outline text="$_->{title}" title="$_->{title}">\n);
			$nest=1;
		} else {
			$doc.=qq(<outline htmlUrl="$_->{link}" text="$_->{title}" title="$_->{title}" type="@{[$_->{type} eq '' ? 'rss' : $_->{type}]}" language="$_->{language}" xmlUrl="$_->{xmlurl}" />\n);
		}
	}
	$doc.=qq(</outline>\n) if($nest eq 1);
	$doc.=<<EOD;
</body>
</opml>
EOD
	return $doc;
}
1;
__END__
