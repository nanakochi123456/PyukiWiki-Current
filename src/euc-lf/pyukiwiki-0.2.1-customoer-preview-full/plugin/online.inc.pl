######################################################################
# online.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
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
	close(FILE);
	open(FILE, "<$file");
	@usr_arr = <FILE>;
	close(FILE);
	return @usr_arr;
}
1;
__END__
