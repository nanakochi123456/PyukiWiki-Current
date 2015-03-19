######################################################################
# skin.inc.pl - This is PyukiWiki yet another Wiki clone
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
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
sub plugin_skin_convert {
	my($mainskin, $subskin)=split(/,/,shift);
	if(&skin_check("$::skin_dir/$mainskin.skin%s.cgi",".$::lang","")) {
		return <<EOM;
<span class="error">Skin $mainskin not found</span>
EOM
	}
	$::skin_name=$mainskin;
	$::skin_name{$mainskin}=$subskin;
	&skin_init;
	return ' ';
}
1;
__END__