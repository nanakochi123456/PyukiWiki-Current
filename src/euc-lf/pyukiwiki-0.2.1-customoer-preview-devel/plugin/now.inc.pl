######################################################################
# now.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:20
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################

use strict;

sub plugin_now_convert {
	return &plugin_now_inline(@_);
}

sub plugin_now_inline {
	my ($format,$now) = split(/,/, shift);
	my ($y,$m,$d);
	my ($h,$m,$s);

	$format=&htmlspecialchars($format);
	$now=&htmlspecialchars($now);

	if($format eq '') {
		return &date($::now_format);
	}
	$now=time if($now eq '');

	if($now=~/ /) {
		my($date,$time)=split(/ /,$now);
		if($date=~/-/) {
			($y,$m,$d)=split(/\-/,$date);
		} elsif($now=~/\//) {
			($y,$m,$d)=split(/\//,$now);
		}
		if($time=~/\:/) {
			($h,$m,$s)=split(/\:/,$time);
		}
		$now=Time::Local::timelocal($s,$m,$h,$m-1,$y-1900);
	} else {
		$now=time;
	}
	return &date($format,$now);
}

1;
__END__

=head1 NAME

now.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 &now;
 &now();
 &now(now_format, [yyyy/mm/dd hh:mm:ss]);

=head1 DESCRIPTION

Display the present or specified date and time in a specification format.

If it specifies like "&now;" without specifying '()', it will be automatically changed into the date at the time of writing, and will not perform as plugin.

When other, the present date and time or the specified date and time is displayed.

=head1 USAGE

=over 4

=item now_format

now_format is an internal function.   The form character string of date and time can be specified.

'(' and ')' cannot be used for now_format.

Please look at the following detailed samples.

=item yyyy/mm/dd hh:mm:ss

Specification date and time. It becomes a date on the day at the time of an abbreviation.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/now

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/now/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/now.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/now.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/now.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/now.inc.pl?view=log>

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
