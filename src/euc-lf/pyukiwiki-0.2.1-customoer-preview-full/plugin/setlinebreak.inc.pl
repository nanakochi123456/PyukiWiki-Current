######################################################################
# setlinebreak.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
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
sub plugin_setlinebreak_convert {
	my($mode)=split(/,/, shift);
	if($mode eq '') {
		$::lfmode=$::lfmode eq 0 ? 1 : 0;
	} elsif(lc $mode eq 'default') {
		$::lfmode=$::line_break;
	} elsif($mode=~/^(1|[Oo][Nn])/) {
		$::lfmode=1;
	} else {
		$::lfmode=0;
	}
	return ' ';
}
1;
__END__
