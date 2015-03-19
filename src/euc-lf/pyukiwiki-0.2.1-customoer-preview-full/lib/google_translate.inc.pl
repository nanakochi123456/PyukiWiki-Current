######################################################################
# google_translate.inc.pl - This is PyukiWiki yet another Wiki clone
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
# This is extented plugin.
# To use this plugin, rename to 'google_transrate.inc.cgi'
######################################################################
#
# transrate.google.com サービスによる、サイト全体翻訳システム
#
# http://translate.google.com/
#
# 使い方：
#   ・google_transrate.inc.plをgoogle_transrate.inc.cgiにリネーム
#
######################################################################
# Initlize											# comment
sub plugin_google_translate_init {
	my $html;
	&exec_explugin_sub("google_analytics");
	if($GOOGLEANALTYCS::ACCOUNT ne '') {
		$html=<<EOM;
<div style="float:right;font-weight:normal">
<div id="google_translate_element"></div>
<script type="text/javascript"><!--
function googleTranslateElementInit(){new google.translate.TranslateElement({pageLanguage:'$::lang',gaTrack:true,gaId:'$GOOGLEANALTYCS::ACCOUNT',layout:google.translate.TranslateElement.InlineLayout.SIMPLE},'google_translate_element');}
//--></script>
<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
</div>
EOM
	} else {
		$html=<<EOM;
<div style="float:right;font-weight:normal">
<div id="google_translate_element"></div>
<script type="text/javascript"><!--
function googleTranslateElementInit(){new google.translate.TranslateElement({pageLanguage:'$::lang',layout:google.translate.TranslateElement.InlineLayout.SIMPLE},'google_translate_element');}
//--></script>
<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
</div>
EOM
	}
	push(@::addnavi,"googletranslate-nobr::help");
	$::navi{"googletranslate-nobr_html"}=$html;
	return ('init'=>1);
}
1;
__DATA__
sub plugin_google_transrate_setup {
	return(
		ja=>'サイト翻訳システム for transrate.google.com',
		en=>'Site Translate System for transrate.google.com',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/google_transrate/'
	);
}
__END__
