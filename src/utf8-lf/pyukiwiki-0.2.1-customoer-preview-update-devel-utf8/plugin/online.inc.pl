######################################################################
# online.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:16:52
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# 現在参照中のおおよそのユーザー数を表示する。
# :書式|
#  #online
#  &online;
# @author Nekyo.
# @version v0.2 2004/12/06 問題があったので、排他lockなし版
######################################################################

$online::timeout = 300
	if(!defined($online::timeout));

######################################################################

use strict;

sub plugin_online_inline {
	return &plugin_online_convert;
}

sub plugin_online_convert {
	my $file = $::counter_dir . 'user.dat';

	if (!(-e $file)) {
		open(FILE, ">$file");
		close(FILE);
	}
	my $addr = $ENV{'REMOTE_ADDR'};

	open(FILE, "<$file");
	my @usr_arr = <FILE>;
	close(FILE);

	open(FILE, ">$file");
#	flock(FILE, 2);		# lock WriteBlock
	my $now = time();
	my ($ip_addr, $tim_stmp);
	foreach (@usr_arr) {
		chomp;
		($ip_addr, $tim_stmp) = split(/|/);

		if (($now - $tim_stmp) < $online::timeout and $ip_addr ne $addr) {
			print FILE "$ip_addr|$tim_stmp\n";
		}
	}
	print FILE "$addr|$now\n";
#	flock(FILE, 8);		# unlock						# comment
	close(FILE);

	open(FILE, "<$file");
	@usr_arr = <FILE>;
	close(FILE);
	return @usr_arr;
}
1;
__END__

=head1 NAME

online.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 &online;
 #online

=head1 DESCRIPTION

The near number of visiters referred to now is displayed.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/online

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/online/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/online.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/online.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/online.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/online.inc.pl?view=log>

=back

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
