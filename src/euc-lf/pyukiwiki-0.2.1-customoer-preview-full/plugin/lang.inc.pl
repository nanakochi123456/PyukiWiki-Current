######################################################################
# lang.inc.pl - This is PyukiWiki yet another Wiki clone
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
# 言語cookie設定用プラグイン
# ExPlugin lang.inc.cgi、$::write_location=1を有効にする必要があります
######################################################################
sub plugin_lang_action {
	my $body;
	return if($::lang_cookie eq '' || $::write_location eq 0);
# 0.1.9 fix
	return if($::useExPlugin eq 1 && $::_exec_plugined{lang} ne 2);
	my $page=$::form{refer} ne "" ? $::form{refer} : $::FrontPage;
	$::lang_cookie{lang}=$::form{lang};
	$::lang_cookie{lang}='' if($::langlist{$::form{lang}} eq '');
	&setcookie($::lang_cookie, 1, %::lang_cookie);
	&location("$::basehref?@{[&encode($page)]}", 302, $::HTTP_HEADER);
	close(STDOUT);
	exit;
}
1;
__END__
