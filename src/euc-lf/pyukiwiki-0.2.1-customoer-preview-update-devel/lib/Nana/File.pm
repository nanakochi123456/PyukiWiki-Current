######################################################################
# File.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:23:04
#
# "Nana::File" ver 0.2 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
#
# 大崎氏のrenameファイルロックに対して、以下の改良点があります。
# ・ディレクトリを使わない
#   全体ロックではなく、各ファイルでロック
#
# YukiWikiDBから、以下の改良点があります。
# ・lock関係を共通化できるように、ファイル読み書きをこのファイルへ
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

# テストするときは、コメントアウトして下さい
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
					return &die("lock_store: $filename locked");
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
			return &die("lock_store: $filename can't created");
			return undef;
		}
		alarm(0);
	};
	if ($@ =~ /timeout/) {
		return &die("lock_store: $filename timeout");
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
#	my $value = <FILE>;
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

=head1 NAME

Nana::File - File access module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/File.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/File.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/File.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/File.pm?view=log>

=item perl file lock how to

L<http://www.din.or.jp/~ohzaki/perl.htm#File_Lock>

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
