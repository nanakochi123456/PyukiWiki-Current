######################################################################
# YukiWikiDB.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:44:46
#
# "Yuki::YukiWikiDB" ver 2.1.2a $$
# Author Hiroshi Yuki
# http://www.hyuki.com/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################

package Yuki::YukiWikiDB;
$VERSION="2.1.2a";

use strict;
use Fcntl ':flock';

# Constructor
sub new {
	return shift->TIEHASH(@_);
}

# tying
sub TIEHASH {
	my ($class, $dbname) = @_;
	my $self = {
		dir => $dbname,
		keys => [],
	};
	if (not -d $self->{dir}) {
		if (!mkdir($self->{dir}, 0777)) {
			die "mkdir(" . $self->{dir} . ") fail";
		}
	}
	return bless($self, $class);
}

# Store
sub STORE {
	my ($self, $key, $value) = @_;
	my $filename = &make_filename($self, $key);
	&lock_store($filename, $value);
	return $value;
}

# Fetch
sub FETCH {
	my ($self, $key) = @_;
	my $filename = &make_filename($self, $key);
	my $value = &lock_fetch($filename);
	return $value;
}

# Exists
sub EXISTS {
	my ($self, $key) = @_;
	my $filename = &make_filename($self, $key);
	return -e($filename);
}

# Delete
sub DELETE {
	my ($self, $key) = @_;
	my $filename = &make_filename($self, $key);
	unlink $filename;
	# return delete $self->{$key};
}

sub FIRSTKEY {
	my ($self) = @_;
	opendir(DIR, $self->{dir}) or die $self->{dir};
	@{$self->{keys}} = grep /\.txt$/, readdir(DIR);
	foreach my $name (@{$self->{keys}}) {
		$name =~ s/\.txt$//;
		$name =~ s/[0-9A-F][0-9A-F]/pack("C", hex($&))/eg;
	}
	return shift @{$self->{keys}};
}

sub NEXTKEY {
	my ($self) = @_;
	return shift @{$self->{keys}};
}

sub make_filename {
	my ($self, $key) = @_;
	my $enkey = '';
	foreach my $ch (split(//, $key)) {
		$enkey .= sprintf("%02X", ord($ch));
	}
	return $self->{dir} . "/$enkey.txt";
}

sub lock_store {
	my ($filename, $value) = @_;
	open(FILE, "+< $filename") or open(FILE, "> $filename") or die "$filename cannot be created";
	eval("flock(FILE, LOCK_EX)");
	if ($@) {
		# Your platform does not support flock.
		# Implement another EXCLUSIVE LOCK here.
	}
	truncate(FILE, 0);
	# binmode(FILE);
	$value =~ s/\x0D\x0A/\n/g;
	print FILE $value;
	eval("flock(FILE, LOCK_UN)");
	if ($@) {
		# Your platform does not support flock.
		# Implement another UNLOCK here.
	}
	close(FILE);
}

sub lock_fetch {
	my ($filename) = @_;
	open(FILE, "$filename") or return(undef);
	eval("flock(FILE, LOCK_SH)");
	if ($@) {
		# Your platform does not support flock.
		# Implement another SHARED LOCK here.
	}
	local $/;
	my $value = <FILE>;
	eval("flock(FILE, LOCK_UN)");
	if ($@) {
		# Your platform does not support flock.
		# Implement another UNLOCK here.
	}
	close(FILE);
	return $value;
}

1;
__END__

=head1 NAME

Yuki::YukiWikiDB - Filebase hash database

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Yuki/YukiWikiDB.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Yuki/YukiWikiDB.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Yuki/YukiWikiDB.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Yuki/YukiWikiDB.pm?view=log>

=back

=head1 AUTHOR

=over 4

=item Hiroshi Yuki

L<http://www.hyuki.com/>

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2002-2015 by Hiroshi Yuki.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
