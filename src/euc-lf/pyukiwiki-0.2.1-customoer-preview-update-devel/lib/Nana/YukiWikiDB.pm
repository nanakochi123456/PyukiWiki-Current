######################################################################
# YukiWikiDB.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:54:59
#
# "Nana::YukiWikiDB" ver 0.9 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

package Nana::YukiWikiDB;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION="0.9";

use Nana::File;

# Constructor							# comment
sub new {
	return shift->TIEHASH(@_);
}

# error
sub die {
	$::debug.="YukiWikiDB:$_[0]\n";
	return undef;
}

# tying												# comment
sub TIEHASH {
	my ($class, $dbname) = @_;
	my $self = {
		dir => $dbname,
		keys => [],
		ext => $::db_extention{$dbname}
	};
	if (not -d $self->{dir}) {
		if (!mkdir($self->{dir}, 0777)) {
			return &die("mkdir $self->{dir} fail");
			return undef;
		}
	}
	return bless($self, $class);
}

# Store												# comment
sub STORE {
	my ($self, $key, $value) = @_;
	my ($mode, $filename) = &make_filename($self, $key);
	my ($mode, $filename_gz) = &make_filename_gz($self, $key);
	Nana::File::lock_delete($filename_gz);
	return Nana::File::lock_store($filename,$value);
}

# Fetch												# comment
sub FETCH {
	my ($self, $key) = @_;
	my ($mode, $filename) = &make_filename($self, $key);
	my ($mode, $filename_gz) = &make_filename_gz($self, $key);
	if(-e $filename) {
		return (stat($filename))[9] if($mode eq "update");
		return Nana::File::lock_fetch($filename);
	}
	if(-e $filename_gz) {
		if($self->{gzip}->{init} eq 0) {
			&load_module("Nana::GZIP");
			$self->{gzip}=new Nana::GZIP();
		}
		my $gz=$self->{gzip};
		if($gz->{init} eq 1) {
			return (stat($filename_gz))[9] if($mode eq "update");
			return
				($gz->uncompress(Nana::File::lock_fetch($filename_gz)));
		}
	}
}

# Exists											# comment
sub EXISTS {
	my ($self, $key) = @_;
	my ($mode, $filename) = &make_filename($self, $key);
	my ($mode, $filename_gz) = &make_filename_gz($self, $key);
	return 1 if (-e $filename);
	return 1 if (-e $filename_gz);
	return 0;
}

# Delete											# comment
sub DELETE {
	my ($self, $key) = @_;
	my $filename = &make_filename($self, $key);
	my $filename_gz = &make_filename_gz($self, $key);
	Nana::File::lock_delete($filename);
	Nana::File::lock_delete($filename_gz);
}

sub FIRSTKEY {
	my ($self) = @_;
	if(opendir(DIR, $self->{dir})) {
		@{$self->{keys}} = grep /\.$self->{ext}$/, readdir(DIR);
		foreach my $name (@{$self->{keys}}) {
			$name =~ s/\.$self->{ext}$//;
			$name =~ s/([0-9A-F][0-9A-F])/$::_dbmname_decode{$1}/g;
		}
		closedir(DIR);
		return shift @{$self->{keys}};
	} else {
		return &die("FIRSTKEY: $self->{dir} fail");
	}
	return;
}

sub NEXTKEY {
	my ($self) = @_;
	return shift @{$self->{keys}};
}

sub make_filename {
	my ($self, $key) = @_;
	my $mode="";
	if($key=~/^\_\_(.+?)\_\_(.+?)$/) {
		$mode=$1;
		$key=$2;
	}
	$key =~ s/(.)/$::_dbmname_encode{$1}/g;
	return ($mode, $self->{dir} . "/$key.$self->{ext}");
}

sub make_filename_gz {
	my ($self, $key) = @_;
	my $mode="";
	if($key=~/^\_\_(.+?)\_\_(.+?)$/) {
		$mode=$1;
		$key=$2;
	}
	$key =~ s/(.)/$::_dbmname_encode{$1}/g;
	return ($mode, $self->{dir} . "/$key.$self->{ext}.gz");
}

1;
__END__

=head1 NAME

Nana::YukiWikiDB - Filebase hash database

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/YukiWikiDB.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/YukiWikiDB.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/YukiWikiDB.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/YukiWikiDB.pm?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nano.daiba.cx/> etc...

=item Hiroshi Yuki

L<http://www.hyuki.com/>

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
