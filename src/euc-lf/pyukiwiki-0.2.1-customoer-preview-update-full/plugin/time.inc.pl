######################################################################
# time.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:16:45
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
sub plugin_time_convert {
	return &plugin_time_inline(@_);
}
sub plugin_time_inline {
	my ($format,$time) = split(/,/, shift);
	my ($h,$m,$s);
	$format=&htmlspecialchars($format);
	$time=&htmlspecialchars($time);
	if($format eq '') {
		return &date($::time_format);
	}
	$time=time if($time eq '');
	if($time=~/\:/) {
		my($sec, $min, $hour, $mday, $mon, $year,$wday, $yday, $isdst) = localtime;
		($h,$m,$s)=split(/\:/,$time);
		$time=Time::Local::timelocal($s,$m,$h,$mday,$mon,$year);
	}
	return &date($format,$time);
}
1;
__END__
