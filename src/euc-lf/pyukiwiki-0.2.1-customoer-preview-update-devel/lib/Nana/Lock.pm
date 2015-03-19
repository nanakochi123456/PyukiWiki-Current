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

package	Nana::Lock;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.2';

$Nana::Lock::DEBUG=0;
# ↑１にするとロック関係のメッセージがでます
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
# ロックファイルの形式
# (元ファイル名で不要部分を除いたもの).(method).(pid).(time).lk
#       0 : ロックしない。省略時のデフォルト
#       1 : (LOCK_SH) 共有ロック，リトライあり
#       2 : (LOCK_EX) 排他ロック，リトライあり
#       5 : (LOCK_SH|LOCK_NB) 共有ロック，リトライなし
#       6 : (LOCK_EX|LOCK_NB) 排他ロック，リトライなし
#       8 : (LOCK_UN) 使わないこと。
#     128 : (LOCK_DELETE) ロックファイルの削除

sub lock {
	my $timeout=5;
	my $trytime=2;

	my($fname,$method)=@_;
	# ディレクトリ、ファイル名、拡張子を分離
	my($d,$f,$e)=$fname=~/(.*)\/(.+)\.(.+)$/;
	# ファイル名から記号らしきものを除去(短くするため)
	$f=~s/[.%()[]:*,_]//g;
	# 初期ハンドルの作成
	my %lfh=(
		dir=>$d,
		basename=>$f,
		timeout=>$timeout,
		trytime=>($method & $Nana::Lock::LOCK_NB ? 0 : $trytime),
		fname=>$fname,
		method=>$method & 3,
		path=>"$d/$f.lk"
	);
	# ロックファイルの削除
	if($method eq $Nana::Lock::LOCK_DELETE) {
		return &lock_del(%lfh);
	}
	# methodがおかしい場合return
	if($lfh{method} eq 0) {
		&msg("lock error:$fname $lfh{method} - $method");
		return;
	}
	return if($lfh{method} eq 0);

	for(my $i=0; $i < $lfh{trytime}*10; $i++) {
		# ロックメソッド、プロセスID、現在時を入れる
		$lfh{current}=sprintf("%s/%s.%x.%x.%x.%d.lk"
			,$lfh{dir},$lfh{basename},$lfh{method},$$,time);
		# ロック、成功時は正常終了
		if(rename($lfh{path},$lfh{current})) {
			&msg(sprintf("%s:%s->%s"
				,($lfh{method} eq 1 ? 'LOCK_SH' : 'LOCK_EX'), $lfh{path},$lfh{current}));
			return \%lfh;
		}
		return \%lfh if(rename($lfh{path},$lfh{current}));

		# 過去のロックファイルを検索
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
		# ロックファイルが存在しなければ新規作成
		if($fcount eq 0) {
			&msg("Create $lfh{path}");
			open(LFHF,">$lfh{path}");# or return undef;
			close(LFHF);
			next;
		# 共有ロックの場合
		} elsif($lfh{method} eq 1) {
			# 排他が存在しない場合
			&msg("SH Lock Check $lfh{basename}");
			if($shcount > 0 && $excount eq 0) {
				# １つチョイスして、リネームする
				foreach(@locklist) {
					my($method,$pid,$time)=split(/\t/,$_);
					my $orgf=sprintf("%s/%s.%x.%s.%s.lk"
						,$lfh{dir},$lfh{basename},$method,$pid,$time);
					&msg("new fn=$orgf");
					# 再ロック
					if(rename($orgf,$lfh{current})) {
						&msg(sprintf("%s:%s->%s"
							,"LOCK_SH",$orgf,$lfh{current}));
						return \%lfh;
					}
					return \%lfh if(rename($orgf,$lfh{current}));
				}
			}
		}
		# 排他であるor異常時
		# 0.1秒のsleep、使えなければ1秒
		eval("select undef, undef, undef, 0.1;");
		if($@) {
			sleep 1;
			$i+=9;
			&msg("waiting 1sec count $i");
		} else {
			&msg("waiting 0.1sec count $i");
		}
	}
	# 再試行終了
	# 過去のロックファイルを検索
	my @filelist=&lock_getdir(%lfh);
	foreach (@filelist) {
		if (/^$lfh{basename}\.(\d)\.(.+)\.(.+)\.lk$/) {
			# タイムアウトしているのが存在したら
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
