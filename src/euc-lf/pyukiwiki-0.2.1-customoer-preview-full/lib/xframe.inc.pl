######################################################################
# xframe.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'xframe.inc.cgi'
######################################################################
#
# フレーム下に表示されないようにするプラグイン
# http://www.jpcert.or.jp/ed/2009/ed090001.pdf
#
######################################################################
#
# DENY:他のWebページのframe上またはiframe上での表示を拒否する。
# SAMEORIGIN:Top-level-browsing-contextが一致した時のみ、他のWebページ
#            上のframe又はiframe上での表示を許可する。
$XFRAME::MODE="DENY"
#$XFRAME::MODE="SAMEORIGIN"
	if(!defined($XFRAME::MODE));
# Initlize
sub plugin_xframe_init {
	my $agent=$ENV{HTTP_USER_AGENT};
	my $header;
	$header=<<EOM;
X-FRAME-OPTIONS: $XFRAME::MODE
EOM
	return ('http_header'=>$header, 'init'=>1, 'func'=>'');
}
1;
__DATA__
sub plugin_xframe_setup {
	return(
		ja=>'フレーム下に表示されないようにするプラグイン',
		en=>'Disable view page on apper on the bottom frame',
		override=>'none',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/xframe/'
	);
}
__END__
