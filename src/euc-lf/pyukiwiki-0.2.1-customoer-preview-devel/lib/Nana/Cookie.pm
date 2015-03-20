######################################################################
# Cookie.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:53:16
#
# "Nana::Cookie" ver 0.2 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

package	Nana::Cookie;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION @ISA @EXPORTER @EXPORT_OK);
$VERSION = '0.2';
@EXPORT_OK = qw(getcookie setcookie);

######################################################################

sub getcookie {
	my($cookieID,%buf)=@_;
	my @pairs;
	my ($pair, $cname, $value);
	my %DUMMY;

	my $decode = $::functions{"decode"};

	@pairs = split(/;/,&$decode($ENV{'HTTP_COOKIE'}));
	foreach $pair (@pairs) {
		($cname,$value) = split(/=/,$pair,2);
		$cname =~ s/ //g;
		$DUMMY{$cname} = $value;
	}
	@pairs = split(/,/,$DUMMY{$cookieID});
	foreach $pair (@pairs) {
		($cname,$value) = split(/:/,$pair,2);
		$buf{$cname} = $value;
	}
	return %buf;
}

sub setcookie {
	my ($cookieID,$expire,%buf)=@_;
	my ($date, $data, $name, $value);

	my $datefunc = $::functions{"http_date"};
	my $tzfunc = $::functions{"gettz"};

	if($expire+0 > 0) {
		$date=&$datefunc(time+&$tzfunc*3600+$::cookie_expire);
	} elsif($expire+0 < 0) {
		$date=&$datefunc(1);
	}
	$buf{cookietime}=time;
	while(($name,$value)=each(%buf)) {
		$data.="$name:$value," if($name ne '');
	}
	$data=~s/,$//g;

	my $encodefunc = $::functions{"encode"};
	$data=&$encodefunc($data);

	$::HTTP_HEADER.=qq(Set-Cookie: $cookieID=$data;);
	$::HTTP_HEADER.=qq( path=$::basepath;);
	$::HTTP_HEADER.=" expires=$date" if($expire ne 0);
	$::HTTP_HEADER.="\n";
}
1;
__END__

=head1 NAME

Nana::Cookie - Simple Cookie module fork from Yuichat.

=head1 SEE ALSO

=over 4

=item YuiChat

L<http://www.cup.com/yui/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/Cookie.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/Cookie.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/Cookie.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/Cookie.pm?view=log>

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
