######################################################################
# star.pl - This is PyukiWiki yet another Wiki clone
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
$STAR::STRING1=qq(<span class="star1">&#9733;</span>)
	if(!defined($STAR::STRING1));
$STAR::STRING2=qq(<span class="star2">&#9734;</span>)
	if(!defined($STAR::STRING2));
package star;
sub plugin_inline {
	my @args = split(/,/, shift);
	my $max=5;
	my $now=0;
	if(@args >= 2) {
		if($args[1]+0 > 0) {
			$max=$args[1];
		}
	}
	if($args[0]+0 > 0) {
		$now=$args[0];
	}
	my $out;
	for (my $i=1; $i <= $max; $i++) {
		if($i <= $now) {
			$out.=$STAR::STRING1;
		} else {
			$out.=$STAR::STRING2;
		}
	}
	return $out;
}
1;
__END__
