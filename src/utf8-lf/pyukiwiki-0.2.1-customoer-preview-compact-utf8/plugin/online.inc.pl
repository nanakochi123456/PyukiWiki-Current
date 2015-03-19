######################################################################
# online.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
