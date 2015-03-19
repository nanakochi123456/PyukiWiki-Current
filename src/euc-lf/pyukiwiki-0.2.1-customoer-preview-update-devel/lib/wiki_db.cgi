######################################################################
# wiki_db.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:24:02
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################

=head1 NAME

wiki_db.cgi - This is PyukiWiki, yet another Wiki clone.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Dev/Specification/wiki_db.cgi

L<http://pyukiwiki.info/PyukiWiki/Dev/Specification/wiki_db.cgi/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/wiki_db.cgi?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/wiki_db.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/wiki_db.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/wiki_db.cgi?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

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

=head2 open_db

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

データベースを開く。

=back

=cut

sub _open_db {
	&dbopen($::data_dir,\%::database);
}


=lang ja

=head2 open_info_db

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

infoデータベースを開く。

=back

=cut

sub _open_info_db {
	&dbopen($::info_dir,\%::infobase);
}

=lang ja

=head2 dbopen

=over 4

=item 入力値

&dbopen(dir, \%db [, extention]);

=item 出力

なし

=item オーバーライド

可

=item 概要

データベースを開く。

=back

=cut

sub _dbopen {
	my($dir,$db,$ext)=@_;
	$::db_extention{$dir}=$ext;
	$::db_extention{$dir}="txt" if($ext eq "");
	if ($modifier_dbtype eq 'dbmopen') {
		dbmopen(%$db, $dir, 0666) or &print_error("(dbmopen) $dir");
	} elsif($modifier_dbtype eq 'AnyDBM_File') {
		tie(%$db, "AnyDBM_File", $dir, O_RDWR|O_CREAT, 0666) or &print_error("(tie AnyDBM_File) $dir");
	} else {
		tie(%$db, "$modifier_dbtype", $dir) or &print_error("(tie $modifier_dbtype) $dir");
	}
	return %db;
}

=lang ja

=head2 dbopen_gz

=over 4

=item 入力値

&dbopen_gz(dir, \%db [, extention]);

=item 出力

なし

=item オーバーライド

可

=item 概要

gzip圧縮データベースを開く。

=back

=cut

sub _dbopen_gz {
	my($dir,$db,$ext)=@_;
	$::db_extention{$dir}=$ext;
	$::db_extention{$dir}="txt" if($ext eq "");
	if ($modifier_dbtype eq 'dbmopen') {
		dbmopen(%$db, $dir, 0666) or &print_error("(dbmopen) $dir");
	} elsif($modifier_dbtype eq 'AnyDBM_File') {
		tie(%$db, "AnyDBM_File", $dir, O_RDWR|O_CREAT, 0666) or &print_error("(tie AnyDBM_File) $dir");
	} elsif($modifier_dbtype eq "Nana::YukiWikiDB") {	# Nana::YukiWikiDB_GZIP	# comment
		tie(%$db, "Nana::YukiWikiDB_GZIP", $dir) or &print_error("(tie Nana::YukiWikiDB_GZIP) $dir");
	} else {
		tie(%$db, "$modifier_dbtype", $dir) or &print_error("(tie $modifier_dbtype) $dir");
	}
	return %db;
}


=lang ja

=head2 close_db

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

データベースを閉じる

=back

=cut

sub _close_db {
	&dbclose(\%::database);
}

=lang ja

=head2 close_info_db

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

infoデータベースを閉じる

=back

=cut

sub _close_info_db {
	&dbclose(\%::infobase);
}

=lang ja

=head2 dbclose

=over 4

=item 入力値

&dbclose(\%db);

=item 出力

なし

=item オーバーライド

可

=item 概要

データベースを開く。

=back

=cut

sub _dbclose {
	my($db)=@_;
	if ($modifier_dbtype eq 'dbmopen') {
		dbmclose(%$db);
	} else {
		untie(%$db);
	}
}

=lang ja

=head2 opendiff

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

diffデータベースを開く。

=back

=cut

sub _open_diff {
	&dbopen($::diff_dir,\%::diffbase);
}

=lang ja

=head2 close_diff

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

diffデータベースを閉じる。

=back

=cut

sub _close_diff {
	&dbclose(\%::diffbase);
}

=lang ja

=head2 openbackup

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

backupデータベースを開く。

=back

=cut

sub _open_backup {
	&dbopen_gz($::backup_dir,\%::backupbase);
}

=lang ja

=head2 close_backup

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

backupデータベースを閉じる。

=back

=cut

sub _close_backup {
	&dbclose(\%::backupbase);
}

=lang ja

=head2 init_db

=over 4

=item 入力値

なし

=item 出力

なし

=item オーバーライド

可

=item 概要

データベースエンジンを初期化する

=back

=cut

sub _init_db {
	if($::modifier_dbtype eq 'Nana::YukiWikiDB') {
		&load_module("Nana::YukiWikiDB");
		&load_module("Nana::YukiWikiDB_GZIP");
	} else {
		&load_module($::modifier_dbtype);
	}
}
1;
