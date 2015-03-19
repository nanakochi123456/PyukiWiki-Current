#!/usr/bin/perl
#!/usr/local/bin/perl --
#!c:/perl/bin/perl.exe
#!c:\perl\bin\perl.exe
#!c:\perl64\bin\perl.exe
######################################################################
# index.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:50:13
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
	require "$::$setup_file" if(-r "$::setup_file");

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
#	chdir("C:/inetpub/cgi-bin/pyuki");
#	push @INC, "C:/inetpub/cgi-bin/pyuki/lib/";
#	push @INC, "C:/inetpub/cgi-bin/pyuki/lib/CGI";
#	push @INC, "C:/inetpub/cgi-bin/pyuki/";
#	$::_conv_start = (times)[0];
#}

require "$::sys_dir/wiki.cgi";

__END__

=head1 NAME

index.cgi - This is PyukiWiki Wrapper

=head1 DESCRIPTION

This file is a wrapper program for starting wiki.

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

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

=cut
