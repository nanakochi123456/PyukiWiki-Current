######################################################################
# date.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
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
