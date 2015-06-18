######################################################################
# aguse.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'aguse.inc.cgi'
######################################################################
#
# aguse.jp サービスによる、リンク先のチェックシステム
#
# for Japanese Service
#
# http://www.aguse.jp/
#
# 使い方：
#   ・aguse.inc.plをaguse.inc.cgiにリネームするだけで使えます
#
######################################################################
# 自サイト内もチェックする時に true にする。
$AGUSE::INNER="false"
	if($AGUSE::INNER eq "false" || $AGUSE::INNER eq "true");
#
# リンクにマウスカーソルを乗せたときのリンクの色
# 0 なし 1 ピンク 2 グリーン 3 ブルー 4 灰色
$AGUSE::LINKCOLOR="1"
	if($AGUSE::LINKCOLOR eq "");
#
# リンクにマウスカーソルを乗せてからポップアップするまでの時間
# (600〜9999ms)
$AGUSE::POPUPTIME="3000"
	if($AGUSE::POPUPTIME+0<600 || $AGUSE::POPUPTIME+0 > 9999);
######################################################################
# Initlize												# comment
sub plugin_aguse_init {
	my $header=<<EOM;
<link rel="stylesheet" href="http://www.aguse.jp/bp/aguse_popup_tool.css" type="text/css" /><script type="text/javascript" src="http://www.aguse.jp/bp/aguse_popup_tool.js#inner=$AGUSE::INNER&amp;color=$AGUSE::LINKCOLOR&amp;wait=$AGUSE::POPUPTIME&amp;" charset="UTF-8" ></script>
EOM
	return ('init'=>1, 'header'=>$header);
}
1;
__DATA__
sub plugin_aguse_setup {
	return(
		ja=>'リンク先チェック for aguse.jp',
		en=>'Link check for aguse.jp (for japanese)',
		require=>'',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/aguse/'
	);
}
__END__
