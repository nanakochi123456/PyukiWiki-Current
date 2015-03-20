######################################################################
# env.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
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
