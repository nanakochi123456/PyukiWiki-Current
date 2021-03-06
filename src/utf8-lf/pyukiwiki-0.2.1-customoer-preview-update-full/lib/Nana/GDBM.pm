######################################################################
# GDBM.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:37:41
#
# "Nana::GDBM" ver 0.1 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package Nana::GDBM;
use strict;
#use integer;
use Exporter;
use vars qw($VERSION);
$VERSION="0.1";
use Fcntl;
use GDBM_File;
#use Time::HiRes;
# Constructor
sub new {
	return shift->TIEHASH(@_);
}
# tying												# comment
sub TIEHASH {
	my ($class, $dbname) = @_;
	my $self = {
		dir => $dbname,
		name => $dbname,
		keys => [],
		db => {},
	};
	if (not -d $self->{dir}) {
		if (!mkdir($self->{dir}, 0777)) {
			return undef;
		}
	}
	my $filename="$self->{dir}/$self->{name}.gdbm";
	if(-r $filename) {
		tie %{$self->{db}}, 'GDBM_File' , $filename, O_RDWR, 0666;
	} else {
		tie %{$self->{db}}, 'GDBM_File' , $filename, O_RDWR|O_CREAT, 0666;
	}
	return bless($self, $class);
}
# Store												# comment
sub STORE {
	my ($self, $key, $value) = @_;
	my ($mode, $filename) = &make_filename($self, $key);
	$self->{db}->{$filename}=$value;
	$self->{db}->{"__update__$filename"}=time;
}
# Fetch												# comment
sub FETCH {
	my ($self, $key) = @_;
	my ($mode, $filename) = &make_filename($self, $key);
	for (my $i=0; $i < 3; $i++) {
		my $buf=$self->{db}->{$filename};
		return $buf if ($buf ne "");
		select undef, undef, undef, 0.1;
	}
	return "";
}
# Exists											# comment
sub EXISTS {
	my ($self, $key) = @_;
	my ($mode, $filename) = &make_filename($self, $key);
	for (my $i=0; $i < 3; $i++) {
		my $buf=$self->{db}->{$filename};
		return 1 if ($buf ne "");
		select undef, undef, undef, 0.1;
	}
	return 0;
}
# Delete											# comment
sub DELETE {
	my ($self, $key) = @_;
	my ($mode, $filename) = &make_filename($self, $key);
	delete $self->{db}->{$filename};
	delete $self->{db}->{"__update__$filename"};
}
sub FIRSTKEY {
	my ($self) = @_;
	@{$self->{keys}} = keys %{$self->{db}};
	my $key=shift @{$self->{keys}};
	my ($mode, $filename) = &make_filename($self, $key);
	return  $filename;
}
sub NEXTKEY {
	my ($self) = @_;
	do {
		my $key=shift @{$self->{keys}};
		my ($mode, $filename) = &make_filename($self, $key);
		return $filename if($mode ne "update");
	} while(1);
}
sub make_filename {
	my ($self, $key) = @_;
	my $mode="";
	if($key=~/^\_\_(.+?)\_\_(.+?)$/) {
		$mode=$1;
		$key=$2;
	}
	return ($mode, $key);
}
1;
__END__
