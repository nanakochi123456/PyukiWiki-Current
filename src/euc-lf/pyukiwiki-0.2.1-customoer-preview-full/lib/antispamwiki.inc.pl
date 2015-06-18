######################################################################
# antispamwiki.inc.pl - This is PyukiWiki yet another Wiki clone
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
# This is extented plugin.
# To use this plugin, rename to 'antispamwiki.inc.cgi'
######################################################################
#
# Wikiスパミング防止
#
# JavaScriptとcookieを用いた簡易的なスパミング防止です。
# 前回閲覧時刻をcookieに記録します。
# 以下の条件で強制的にFrontPageに飛ばします
# ・前回閲覧時刻から有効期限を越えた時
# ・$::form{mymsg} が存在する、または POSTメソッド時、
#   有効期限を越えた時またはcookie不設定の場合
#
# 使い方：
#   ・antispamwiki.inc.plをantispamwiki.inc.cgiにリネームするだけで使えます
#
######################################################################
# 有効期限（１時間）
$AntiSpamWiki::expire=1*60*60
	if(!defined($AntiSpamWiki::expire));
#
# 最短書き込み時間（３秒）
$AntiSpamWiki::mintime=3
	if(!defined($AntiSpamWiki::mintime));
#
%::antispamwiki_cookie;
$::antispamwiki_cookie="PAW_"
				. &dbmname($::basepath);
$::antispamwiki_cookie_name="t";
$::antispamwiki_cookie_expire=60*60*60;
######################################################################
# Initlize												# comment
sub plugin_antispamwiki_init {
	my $stat=0;
	%::antispamwiki_cookie=();
	%::antispamwiki_cookie=&getcookie($::antispamwiki_cookie,%::antispamwiki_cookie);
	my $time=time;
	if($::antispamwiki_cookie{$::antispamwiki_cookie_name} eq '') {
		$stat=1;
	} elsif($::antispamwiki_cookie{$::antispamwiki_cookie_name}+0+$AntiSpamWiki::expire < $time) {
		$stat=-1;
	} elsif($time-$::antispamwiki_cookie{$::antispamwiki_cookie_name}+0 < $AntiSpamWiki::mintime) {
		$stat=-1;
	}
$::debug.="now:$time, cookie:$::antispamwiki_cookie{$::antispamwiki_cookie_name}\n";
	if($stat+0 ne 0) {
		if($::form{mymsg} ne '' ||$::form{msg} ne '') {
			$::form{cmd}="read";
			$::form{mypage}=$::FrontPage;
		}
	}
	$::antispamwiki_cookie{$::antispamwiki_cookie_name}=$time;
	&setcookie($::antispamwiki_cookie,$::antispamwiki_cookie_expire,%::antispamwiki_cookie);
	return('init'=>1, 'func'=>'skinhead', 'skinhead'=>&skinhead);
}
1;
__DATA__
sub plugin_antispamwiki_setup {
	return(
		ja'=>'Wikiスパミング防止',
		en=>'Anti Spam for WikiPlugin',
		override=>'',
		require=>'',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/antispamwiki/'
	);
}
__END__
