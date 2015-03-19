######################################################################
# ipv6check.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:15
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

sub plugin_ipv6check_inline {
	return &plugin_ipv6check_convert(shift);
}

sub plugin_ipv6check_convert {
	my($ipv6page,$ipv4page)=split(/,/,shift);
	my $ipmode="v4";
	my $addr=$ENV{REMOTE_ADDR};
	if($addr=~/^(?:::(?:f{4}:)?)?((?:0*(?:2[0-4]\d|25[0-5]|[01]?\d\d|\d)\.){3}0*(?:2[0-4]\d|25[0-5]|[01]?\d\d|\d)|(?:\d+))$/) {
		$ipmode="v4";
	} elsif($addr=~/:/) {
		$ipmode="v6";
	} else {
		$ipmode="v4";
	}
	if($ipmode eq 'v6') {
		return &text_to_html($::database{$ipv6page}) . " ";
	} else {
		return &text_to_html($::database{$ipv4page}) . " ";
	}
}
1;
__END__

=head1 NAME

ipv6check.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 &ipv6check([ipv6page],[ipv4page]);

=head1 DESCRIPTION

Display cliant access for IPV4 or IPV6 check

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/ipv6check

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/ipv6check/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/ipv6check.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/ipv6check.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/ipv6check.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/ipv6check.inc.pl?view=log>

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
