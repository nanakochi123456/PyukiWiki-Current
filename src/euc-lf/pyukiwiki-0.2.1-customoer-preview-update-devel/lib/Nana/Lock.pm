######################################################################
# Lock.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:23:54
#
# "Nana::Lock" ver 0.2 $$
# Author Nanami
# http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
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

package	Nana::Lock;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.2';

$Nana::Lock::DEBUG=0;
# ���P�ɂ���ƃ��b�N�֌W�̃��b�Z�[�W���ł܂�
# error
sub die {
	$::debug.="Nana::Lock:Error:$_[0]\n";
	return undef;
}
# message
sub msg {
	$::debug.="Nana:Lock:$_[0]\n"
		if($Nana::Lock::DEBUG eq 1);
}

$Nana::Lock::LOCK_SH=1;
$Nana::Lock::LOCK_EX=2;
$Nana::Lock::LOCK_NB=4;
$Nana::Lock::LOCK_DELETE=128;

# rename lock idea
# http://www.din.or.jp/~ohzaki/perl.htm#File_Lock
# ���b�N�t�@�C���̌`��
# (���t�@�C�����ŕs�v����������������).(method).(pid).(time).lk
#       0 : ���b�N���Ȃ��B�ȗ����̃f�t�H���g
#       1 : (LOCK_SH) ���L���b�N�C���g���C����
#       2 : (LOCK_EX) �r�����b�N�C���g���C����
#       5 : (LOCK_SH|LOCK_NB) ���L���b�N�C���g���C�Ȃ�
#       6 : (LOCK_EX|LOCK_NB) �r�����b�N�C���g���C�Ȃ�
#       8 : (LOCK_UN) �g��Ȃ����ƁB
#     128 : (LOCK_DELETE) ���b�N�t�@�C���̍폜

sub lock {
	my $timeout=5;
	my $trytime=2;

	my($fname,$method)=@_;
	# �f�B���N�g���A�t�@�C�����A�g���q�𕪗�
	my($d,$f,$e)=$fname=~/(.*)\/(.+)\.(.+)$/;
	# �t�@�C��������L���炵�����̂�����(�Z�����邽��)
	$f=~s/[.%()[]:*,_]//g;
	# �����n���h���̍쐬
	my %lfh=(
		dir=>$d,
		basename=>$f,
		timeout=>$timeout,
		trytime=>($method & $Nana::Lock::LOCK_NB ? 0 : $trytime),
		fname=>$fname,
		method=>$method & 3,
		path=>"$d/$f.lk"
	);
	# ���b�N�t�@�C���̍폜
	if($method eq $Nana::Lock::LOCK_DELETE) {
		return &lock_del(%lfh);
	}
	# method�����������ꍇreturn
	if($lfh{method} eq 0) {
		&msg("lock error:$fname $lfh{method} - $method");
		return;
	}
	return if($lfh{method} eq 0);

	for(my $i=0; $i < $lfh{trytime}*10; $i++) {
		# ���b�N���\�b�h�A�v���Z�XID�A���ݎ�������
		$lfh{current}=sprintf("%s/%s.%x.%x.%x.%d.lk"
			,$lfh{dir},$lfh{basename},$lfh{method},$$,time);
		# ���b�N�A�������͐���I��
		if(rename($lfh{path},$lfh{current})) {
			&msg(sprintf("%s:%s->%s"
				,($lfh{method} eq 1 ? 'LOCK_SH' : 'LOCK_EX'), $lfh{path},$lfh{current}));
			return \%lfh;
		}
		return \%lfh if(rename($lfh{path},$lfh{current}));

		# �ߋ��̃��b�N�t�@�C��������
		my @filelist=&lock_getdir(%lfh);
		my @locklist=();
		my $fcount=0;
		my $excount=0;
		my $shcount=0;
		foreach (@filelist) {
			if (/^$lfh{basename}\.(\d)\.(.+)\.(.+)\.lk$/) {
				push(@locklist,"$1\t$2\t$3");
				$fcount++;
				$shcount++ if($1 eq 1);
				$excount++ if($1 eq 2);
				&msg(sprintf("Found:%s.%s.%s.%s.lk(method=%d,all=%d,ex=%d,sh=%d)"
					,$lfh{basename},$1,$2,$3,$lfh{method},$fcount,$excount,$shcount));
			}
		}
		# ���b�N�t�@�C�������݂��Ȃ���ΐV�K�쐬
		if($fcount eq 0) {
			&msg("Create $lfh{path}");
			open(LFHF,">$lfh{path}");# or return undef;
			close(LFHF);
			next;
		# ���L���b�N�̏ꍇ
		} elsif($lfh{method} eq 1) {
			# �r�������݂��Ȃ��ꍇ
			&msg("SH Lock Check $lfh{basename}");
			if($shcount > 0 && $excount eq 0) {
				# �P�`���C�X���āA���l�[������
				foreach(@locklist) {
					my($method,$pid,$time)=split(/\t/,$_);
					my $orgf=sprintf("%s/%s.%x.%s.%s.lk"
						,$lfh{dir},$lfh{basename},$method,$pid,$time);
					&msg("new fn=$orgf");
					# �ă��b�N
					if(rename($orgf,$lfh{current})) {
						&msg(sprintf("%s:%s->%s"
							,"LOCK_SH",$orgf,$lfh{current}));
						return \%lfh;
					}
					return \%lfh if(rename($orgf,$lfh{current}));
				}
			}
		}
		# �r���ł���or�ُ펞
		# 0.1�b��sleep�A�g���Ȃ����1�b
		eval("select undef, undef, undef, 0.1;");
		if($@) {
			sleep 1;
			$i+=9;
			&msg("waiting 1sec count $i");
		} else {
			&msg("waiting 0.1sec count $i");
		}
	}
	# �Ď��s�I��
	# �ߋ��̃��b�N�t�@�C��������
	my @filelist=&lock_getdir(%lfh);
	foreach (@filelist) {
		if (/^$lfh{basename}\.(\d)\.(.+)\.(.+)\.lk$/) {
			# �^�C���A�E�g���Ă���̂����݂�����
			if (time - hex($3) > $lfh{timeout}) {
				my $orgf=sprintf("%s/%s.%s.%s.%s.lk"
					,$lfh{dir},$lfh{basename},$1,$2,$3);
				if(rename($orgf,$lfh{current})) {
					&msg(sprintf("%s:%s->%s"
						,"FORCE_LOCK",$orgf,$lfh{current}));
					return \%lfh;
				}
				return \%lfh if(rename($orgf,$lfh{current}));
			}
		}
	}
	&msg("lock:can't lock");
	return undef;
}

sub unlock {
	if(rename($_[0]->{current}, $_[0]->{path})) {
		&msg("LOCK_UN" . $_[0]->{current} . "->" . $_[0]->{path});
	}
	rename($_[0]->{current}, $_[0]->{path});
}

sub lock_del {
	my(%lfh)=@_;
	unlink($lfh{path});
	&msg("LOCK_DELETE: $lfh{path}");
	my @filelist=&lock_getdir(%lfh);
	foreach (@filelist) {
		if (/^$lfh{basename}\.(\d)\.(.+)\.(.+)\.lk$/) {
			unlink($_);
			&msg("LOCK_DELETE: $_");
		}
	}
}

sub lock_getdir {
	my(%lfh)=@_;
	opendir(LOCKDIR, $lfh{dir});
	my @filelist = readdir(LOCKDIR);
	closedir(LOCKDIR);
	return @filelist;
}

1;
__END__

=head1 NAME

Nana::Lock - Rename file lock module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/Lock.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/Lock.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/Lock.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/Lock.pm?view=log>

=item perl file lock how to

L<http://www.din.or.jp/~ohzaki/perl.htm#File_Lock>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

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
