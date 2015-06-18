######################################################################
# date.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:23:37
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

use strict;

sub plugin_date_convert {
	return &plugin_date_inline(@_);
}

sub plugin_date_inline {
	my ($format,$date) = split(/,/, shift);
	my ($y,$m,$d);

	$format=&htmlspecialchars($format);
	$date=&htmlspecialchars($date);

	if($format eq '') {
		return &date($::date_format);
	}
	$date=time if($date eq '');

	if($date=~/-/) {
		($y,$m,$d)=split(/\-/,$date);
		$date=Time::Local::timelocal(0,0,0,$d,$m-1,$y-1900);
	} elsif($date=~/\//) {
		($y,$m,$d)=split(/\//,$date);
		$date=Time::Local::timelocal(0,0,0,$d,$m-1,$y-1900);
	}
	return &date($format,$date);
}

1;
__END__

=head1 NAME

date.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 &date;
 &date();
 &date(date_format, [yyyy/mm/dd]);

=head1 DESCRIPTION

Display the present or specified date in a specification format.

If it specifies like "&date;" without specifying '()', it will be automatically changed into the date at the time of writing, and will not perform as plugin.

When other, the present date or the specified date is displayed.

=head1 USAGE

=over 4

=item date_format

date_format is an internal function.   The form character string of date can be specified.

'(' and ')' cannot be used for date_format.

Please look at the following detailed samples.

=item yyyy/mm/dd

Specification date. It becomes a date on the day at the time of an abbreviation.

=back

=head1 SAMPLES

Date format samples

=over 4

=item &date(Y-n-j[D],2006/1/1)

2006-1-1[Sun]

=item &date(y/m/J,2006/1/1)

06/01/01

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/date

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/date/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/date.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/date.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/date.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/date.inc.pl?view=log>

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
