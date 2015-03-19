######################################################################
# MD5.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:18:57
#
# "Nana::MD5" ver 0.3 $$
# Author Nanami
# http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
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

=head1 NAME

Nana::MD5 - MD5 wrapper module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/MD5.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/MD5.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/MD5.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/MD5.pm?view=log>

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
