######################################################################
# MD5.pm - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "Nana::MD5" ver 0.3 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package	Nana::MD5;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION @ISA @EXPORTER @EXPORT_OK);
@EXPORT_OK = qw(md5 md5_hex md5_base64);
@ISA = 'Exporter';
$VERSION = '0.3';
$MD5::Method="";
sub init {
	return if($MD5::Method ne "");
	if(&load_module("Digest::MD5")) {
		$MD5::Method="Digest::MD5";
	} elsif(&load_module("Digest::Perl::MD5")) {
		$MD5::Method="Digest::Perl::MD5";
	}
}
sub md5 {
	&init;
	if($MD5::Method eq "Digest::MD5") {
		return Digest::MD5::md5(@_);
	} elsif($MD5::Method eq "Digest::Perl::MD5") {
		return Digest::Perl::MD5::md5(@_);
	}
	die;
}
sub md5_hex {
	&init;
	if($MD5::Method eq "Digest::MD5") {
		return Digest::MD5::md5_hex(@_);
	} elsif($MD5::Method eq "Digest::Perl::MD5") {
		return Digest::Perl::MD5::md5_hex(@_);
	}
	die;
}
sub md5_base64 {
	&init;
	if($MD5::Method eq "Digest::MD5") {
		return Digest::MD5::md5_base64(@_);
	} elsif($MD5::Method eq "Digest::Perl::MD5") {
		return Digest::Perl::MD5::md5_base64(@_);
	}
	die;
}
sub load_module {
	my $funcp = $::functions{"load_module"};
	return &$funcp(@_);
}
1;
__END__
