######################################################################
# env.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:55:10
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
######################################################################
sub plugin_env_convert {
	&plugin_env_inline(@_);
}
sub plugin_env_inline {
	my($env, $regex, $page)=split(/,/,shift);
	return ' ' if(!&is_frozen($::form{mypage}));
	if(lc $regex eq "view") {
		return $ENV{$env};
	}
	if($::ENV{$env}=~/$regex/i) {
		return &text_to_html($::database{$page});
	}
	return " ";
}
1;
__END__
