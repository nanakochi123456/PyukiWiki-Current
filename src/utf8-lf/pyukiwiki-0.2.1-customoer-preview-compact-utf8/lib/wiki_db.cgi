######################################################################
# wiki_db.cgi - $Id$
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
sub _open_db {
	&dbopen($::data_dir,\%::database);
}
sub _open_info_db {
	&dbopen($::info_dir,\%::infobase);
}
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
sub _close_db {
	&dbclose(\%::database);
}
sub _close_info_db {
	&dbclose(\%::infobase);
}
sub _dbclose {
	my($db)=@_;
	if ($modifier_dbtype eq 'dbmopen') {
		dbmclose(%$db);
	} else {
		untie(%$db);
	}
}
sub _open_diff {
	&dbopen($::diff_dir,\%::diffbase);
}
sub _close_diff {
	&dbclose(\%::diffbase);
}
sub _init_db {
	if($::modifier_dbtype eq 'Nana::YukiWikiDB') {
		&load_module("Nana::YukiWikiDB");
	} else {
		&load_module($::modifier_dbtype);
	}
}
1;
