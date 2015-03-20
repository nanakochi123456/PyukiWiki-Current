######################################################################
# func.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:54:12
#
# "NanaXS::func" ver 0.1 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

package NanaXS::func;

use 5.008100;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw(
);
our $VERSION = '0.1';

require XSLoader;
XSLoader::load('NanaXS::func', $VERSION);

sub gettz {
	if($::TZ eq '') {
		my $now=time();
		$::TZ=(timegm(localtime($now))-timegm(gmtime($now)))/3600;
	}
	return $::TZ;
}

sub date {
	my ($format, $tm, $gmtime) = @_;

	if(@_ > 1) {
		$tm=time if($tm + 0 eq 0);
	} else {
		$tm=time;
	}
	$gmtime="" if(@_ < 3);
	$gmtime=$gmtime eq "" ? 0 : 1;
	return NanaXS::func::xdate($format, $tm, $gmtime
		, $::TZ+0
		, $::resource{"date_ampm_en"}
		, $::resource{"date_ampm_".$::lang}
		, $::resource{"date_weekday_en"},
		, $::resource{"date_weekday_en_short"}
		, $::resource{"date_weekday_".$::lang}
		, $::resource{"date_weekday_".$::lang."_short"}
	);
}
1;
__END__
