######################################################################
# File.pm - $Id$
#
# "Nana::File" ver 0.2 $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
#
# ��莁��rename�t�@�C�����b�N�ɑ΂��āA�ȉ��̉��Ǔ_������܂��B
# �E�f�B���N�g�����g��Ȃ�
#   �S�̃��b�N�ł͂Ȃ��A�e�t�@�C���Ń��b�N
#
# YukiWikiDB����A�ȉ��̉��Ǔ_������܂��B
# �Elock�֌W�����ʉ��ł���悤�ɁA�t�@�C���ǂݏ��������̃t�@�C����
#
# from http://www.din.or.jp/~ohzaki/perl.htm#File_Lock
#
######################################################################
package	Nana::File;
use 5.005;
use strict;
#use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.2';
use Fcntl ':flock';
$Nana::File::LOCK_SH=1;
$Nana::File::LOCK_EX=2;
$Nana::File::LOCK_NB=4;
$Nana::File::LOCK_DELETE=128;
$Nana::File::UseCache=1;
%Nana::File::_Cache=();
sub lock_store {
	my ($filename, $value) = @_;
	my $lfh;
	local $SIG{ALRM} = sub { die "timeout" };
	if($Nana::File::UseCache eq 1) {
		$Nana::File::_Cache{$filename}=$value;
	}
	eval {
		if(open(FILE, "+<$filename") or open(FILE, ">$filename")) {
			alarm(5);
			eval("flock(FILE, LOCK_EX)");
			if ($@) {
				$lfh=&lock($filename,$Nana::File::LOCK_EX);
				if(!$lfh) {
					alarm(0);
					return undef;
				}
			}
			alarm(5);
			truncate(FILE, 0);
			# binmode(FILE);
			print FILE $value;
			alarm(5);
			eval("flock(FILE, LOCK_UN)");
			if ($@) {
				&unlock($lfh);
			}
			alarm(0);
			close(FILE);
		} else {
			alarm(0);
			return undef;
		}
		alarm(0);
	};
	if ($@ =~ /timeout/) {
		return undef;
	}
	return $value;
}
sub lock_fetch {
	my ($filename) = @_;
	if($Nana::File::UseCache eq 1) {
		my $buf=$Nana::File::_Cache{$filename};
		return $buf if($buf ne '');
	}
	my $lfh;
	open(FILE, "$filename") or return(undef);
	eval("flock(FILE, LOCK_SH)");
	if ($@) {
		$lfh=&lock($filename,$Nana::File::LOCK_SH);
	}
	local $/;
	binmode(FILE);
	my $value;
	my $len=sysread(FILE, $value, -s $filename);
	eval("flock(FILE, LOCK_UN)");
	if ($@) {
		&unlock($lfh);
	}
	close(FILE);
	if($Nana::File::UseCache eq 1) {
		$Nana::File::_Cache{$filename}=$value;
	}
	return $value;
}
sub lock_delete {
	my ($filename) = @_;
	my $lfh;
	open(FILE, "$filename") or return(undef);
	eval("flock(FILE, LOCK_SH)");
	if ($@) {
		$lfh=&lock($filename,$Nana::File::LOCK_DELETE);
	}
	eval("flock(FILE, LOCK_UN)");
	close(FILE);
	unlink($filename);
	if($Nana::File::UseCache eq 1) {
		$Nana::File::_Cache{$filename}='';
	}
}
sub lock {
	&load_module("Nana::Lock");
	return Nana::Lock::lock(@_);
}
sub unlock {
	&load_module("Nana::Lock");
	return Nana::Lock::unlock(@_);
}
sub load_module {
	my $funcp = $::functions{"load_module"};
	return &$funcp(@_);
}
1;
__END__
