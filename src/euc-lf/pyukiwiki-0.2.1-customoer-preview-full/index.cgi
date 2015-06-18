#!/usr/bin/perl
#!/usr/local/bin/perl --
#!c:/perl/bin/perl.exe
#!c:\perl\bin\perl.exe
#!c:\perl64\bin\perl.exe
######################################################################
# index.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# If don't work, please comment on this.
use Time::HiRes;
# You MUST modify following initial file.
BEGIN {
	$::ini_file = "pyukiwiki.ini.cgi";
######################################################################
	eval {
		$::_conv_start_hires = [Time::HiRes::gettimeofday];
	};
	$::_conv_start = (times)[0];
	$::setup_file="";
	$::ini_file = "pyukiwiki.ini.cgi" if($::ini_file eq "");
	require "$::ini_file";
	require "$::setup_file" if(-r "$::setup_file");
	# don't delete for XS module
	push @INC, "$sysxs_dir";
	push @INC, "$sysxs_dir/lib";
	push @INC, "$sysxs_dir/arch";
	push @INC, "$sysxs_dir/arch/auto";
	push @INC, "$sys_dir";
	push @INC, "$sys_dir/CGI";
}
######################################################################
# If Windows NT Server, use sample it
#BEGIN {
#}
require "$::sys_dir/wiki.cgi";
__END__
