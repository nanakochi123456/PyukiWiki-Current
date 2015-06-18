######################################################################
# wiki_spam.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:23:26
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

=head1 NAME

wiki_spam.cgi - This is PyukiWiki, yet another Wiki clone.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Dev/Specification/wiki_spam.cgi

L<http://pyukiwiki.info/PyukiWiki/Dev/Specification/wiki_spam.cgi/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/wiki_spam.cgi?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/wiki_spam.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/wiki_spam.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/wiki_spam.cgi?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

=item Nanami

L<http://nano.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2004-2007 by Nekyo.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

=lang ja

=head2 snapshot

=over 4

=item 設定

$::deny_log = 1 詳細出力をpyukiwiki.ini.cgiに設定した$::deny_logに出力する。

$::filter_flg = 1 スパムフィルターを設定したときに$::black_logに出力する。

=item 入力値

&snapshot(ログ出力の理由のメッセージ);

=item 出力

なし

=item オーバーライド

不可

=item 概要

スパムフィルター &spam_filter においてのロギングをする。 add by Nekyo

=back

=cut

sub _snapshot {
	my $title = shift;
	my $fp;

	if ($::deny_log) {
		&getremotehost;
		open $fp, ">>$::deny_log";
		my $envs=<<EOM;
HTTP_USER_AGENT:$::ENV{'HTTP_USER_AGENT'}
HTTP_REFERER:$::ENV{'HTTP_REFERER'}
REMOTE_ADDR:$::ENV{'REMOTE_ADDR'}
REMOTE_HOST:$::ENV{'REMOTE_HOST'}
REMOTE_IDENT:$::ENV{'REMOTE_IDENT'}
HTTP_ACCEPT_LANGUAGE:$::ENV{'HTTP_ACCEPT_LANGUAGE'}
HTTP_ACCEPT:$::ENV{'HTTP_ACCEPT'}
HTTP_HOST:$::ENV{'HTTP_HOST'}
MYPAGE:$::form{mypage}
LANG:$::lang
EOM

		print $fp <<EOM;
<<$title @{[date("Y-m-d H:i:s")]}>>
$envs

EOM
		close $fp;
		my $forms;
		foreach(sort keys %form) {
			$forms.=<<EOM;
$_
$::form{$_}

EOM
		}
		my $msg=<<EOM;
<<$title @{[date("Y-m-d H:i:s")]}>>
-------------------------------------
envs
-------------------------------------
$envs

-------------------------------------
forms
-------------------------------------
$forms
EOM

		&send_mail_to_admin($::form{mypage}, $::mail_head{spam}, $msg);

	}
	if ($::filter_flg == 1) {
		my $denylistflg=0;

		if(-r "$::black_log") {
			open($fp, "$::black_log");
			while (<$fp>) {
				tr/\r\n//d;
				s/\./\\\./g;
				my($ip, $time)=split(/\t/, $_);
				if ($time ne '' && $::ENV{'REMOTE_ADDR'} =~ /$ip/i) {
					$denylistflg++;
					close($fp);
				}
			}
			close($fp);
		}
		if(!$denylistflg) {
			open($fp, ">>$::black_log");
			print $fp $::ENV{'REMOTE_ADDR'} . "\t" . time . "\n";
			close $fp;
		}

		$denylistflg=0;
		if(-r $::deny_list) {
			open($fp, "$::deny_list");
			while (<$fp>) {
				tr/\r\n//d;
				s/\./\\\./g;
				my($ip, $time)=split(/\t/, $_);
				next if (!(time < $time + 0 + $::deny_expire));
				if($::ENV{'REMOTE_ADDR'} =~ /$ip/i) {
					$denylistflg++;
				}
			}
			close($fp);
		}
		if($denylistflg <= $::auto_add_deny) {
			open($fp, ">>$::deny_list");
			print $fp $::ENV{'REMOTE_ADDR'} . "\t" . time . "\n";
			close $fp;
		}
	}
}

=lang ja

=head2 spam_filter

=over 4

=item 入力値

&spam_filter(なし 文字列指定, レベル, URIカウント, メールカウント, リターンフラグ);

レベル

0または指定なしの場合Over Httpのみのチェックをする。

1の場合日本語チェックをする

2の場合Over Httpと日本語チェックのみをする。

3の場合、無効フォームへのポストのみのチェック

=item 出力

なし

=item オーバーライド

不可

=item 概要

掲示板、コメント等のスパムフィルター  add by Nekyo

=back

=cut

sub _spam_filter {
	my ($chk_str, $level, $uricount, $mailcount, $retflg) = @_;
	my $reason;

	if(-r $::deny_list) {
		my $denycount=0;
		open(R, $::deny_list) || &print_error("$::deny_list can't read");
		foreach(<R>) {
			my($ip, $time)=split(/\t/,$_);
			chmop;

			if($ENV{REMOTE_HOST} eq "") {
				if($ENV{REMOTE_HOST}=~/$ip/) {
				next if (!(time < $time + 0 + $::deny_expire));
					$denycount++;
					next if($denycount <= $::auto_add_deny);
					&snapshot('Blacklisted');
					return "spam" if($retflg+0 eq 1);
					$reason=$::resource{auth_fobidden_reason_always};
					&skinex($::form{mypage},
						&message("$::resource{auth_writefobidden} - $reason"), 0);
					&close_db;
					return "spam" if($retflg+0 eq 1);
					exit;
				}
			}
			if($ENV{REMOTE_ADDR}=~/$ip/) {
				next if (!(time < $time + 0 + $::deny_expire));
				$denycount++;
				next if($denycount <= $::auto_add_deny);
				&snapshot('Blacklisted');
				return "spam" if($retflg+0 eq 1);
				$reason=$::resource{auth_fobidden_reason_always};
				&skinex($::form{mypage},
					&message("$::resource{auth_writefobidden} - $reason"), 0);
				&close_db;
				return "spam" if($retflg+0 eq 1);
				exit;
			}
		}
	}
	return if ($::filter_flg != 1);	# フィルターオフなら何もしない。 # comment
	return if ($chk_str eq '');		# 文字列が無ければ何もしない。	 # comment
	# v 0.2.0 fix													 # comment

	my $chk_jp_regex=$::chk_jp_hiragana ? '[あ-んア-ン]' : '[\x80-\xFE]';

	if($uricount+0 eq 0 || $uricount+0 > $::chk_uri_count+0) {
		$uricount=$::chk_uri_count;
	}

	# レベル 3 無効フォームのポスト（警告出力のみ）					# comment
	if ($level eq 3) {
		&snapshot('Ignore Form');
		return "Ignore Form" if($retflg+0 eq 1);
		$reason=$::resource{auth_fobidden_reason_ignoreform};

	# レベル 2　を除きOver Httpチェックを行う。						# comment
	# changed by nanami and v 0.2.0-p2 fix
	} elsif (($level ne  1) && ($uricount > 0) && (($chk_str =~ s/https?:\/\///g) >= $uricount)) {
		&snapshot('Over http');
		return "Over http" if($retflg+0 eq 1);
		$reason=$::resource{auth_fobidden_reason_overhttp};

	# Over Mailチェックを行う。
	} elsif (($level ne  1) && ($mailcount+0 > 0) && (($chk_str =~ s/$::ismail//g) >= $uricount)) {
		&snapshot('Over Mail', $retflg+0);
		return "Over Mail" if($retflg+0 eq 1);
		$reason=$::resource{auth_fobidden_reason_overmail};

	# レベルが 1 の時のみ 日本語チェックを行う。					# comment
	# changed by nanami and v 0.2.0 fix
	} elsif (($level >= 1) && ($::chk_jp_only == 1) && ($chk_str !~ /$chk_jp_regex/)) {
		&snapshot('No Japanese', $retflg+0);
		return "No Japanese" if($retflg+0 eq 1);
		$reason=$::resource{auth_fobidden_reason_nojapanese};

	} else {
		return;
	}
	if($reason ne "") {
		&skinex($::form{mypage},
			&message("$::resource{auth_writefobidden} - $reason"), 0);
	} else {
		&skinex($::form{mypage},
			&message("$::resource{auth_writefobidden}"), 0);
	}
	&close_db;
	return "spam" if($retflg+0 eq 1);
	exit;
}
1;
