######################################################################
# ipv6check.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
