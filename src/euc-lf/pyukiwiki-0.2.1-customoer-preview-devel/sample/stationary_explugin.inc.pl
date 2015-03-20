######################################################################
# stationary_explugin.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:44:44
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
# This is extented plugin sample
# To use this plugin, rename to 'stationary_explugin.inc.cgi'
######################################################################

use strict;

#
# init
#
sub plugin_stationary_init {
	my $http_header="X-PyukiWiki-Stationary:test";
	return(
		'init'=>1,
		'http_header'=>$http_header
		, 'func'=>'convtime', 'convtime'=>\&convtime
	);
}

sub convtime {
	if ($::enable_convtime != 0) {
		return sprintf("PyukiWiki $::version stationary_explugin<br />Powered by Perl $] HTML convert time to %.3f sec.%s",
			((times)[0] - $::_conv_start), $::gzip_header ne '' ? " Compressed" : "");
	}
}


1;
__END__
