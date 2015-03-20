######################################################################
# antispam.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 10:03:23
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'antispam.inc.cgi'
######################################################################
#
# メールアドレス自動収集防止
#
# 使い方：
#   ・antispam.inc.plをantispam.inc.cgiにリネームするだけで使えます
#
######################################################################
# Initlize												# comment
sub plugin_antispam_init {
	$::AntiSpam_Count=0;
	$::AntiSpam="enable";
	$::functions{make_link_mail}=\&make_link_mail;
	return ('init'=>1
		, 'func'=>'make_link_mail', 'make_link_mail'=>\&make_link_mail);
}
# hack wiki.cgi of make_link_mail						# comment
sub make_link_mail {
	my($chunk,$escapedchunk)=@_;
	my $adr=$chunk;
	if($::Token eq '') {
		$::IN_JSHEADVALUE.=&maketoken;
	}
	$adr=~s/^[Mm][Aa][Ii][Ll][Tt][Oo]://g;
	my $mailtoadr="mailto:$adr";
	return qq(<a href="$mailtoadr" class="mail">$escapedchunk</a>) if($::Token eq '');
	my $chunk1=&Enc_UntiSpam("mailto:$adr");
	$::AntiSpam_Count++;
	my $id="antispammail$::AntiSpam_Count";
	if($adr eq $escapedchunk || $mailtoadr eq $escapedchunk) {
		$escapedchunk=&Enc_UntiSpam("$escapedchunk");
		$::AntiSpam_Count++;
		$::IN_JSHEAD.=<<EOM;
addec_text('$escapedchunk','$id');
EOM
		return qq(<span class="mail" id="$id" onclick="addec_link('$chunk1\')" onkeypress="void(0);"></span>);
	} else {
		return qq(<span class="mail" id="$id" onclick="addec_link('$chunk1\','$id')" onkeypress="void(0);">$escapedchunk</span>);
	}
}
sub Enc_UntiSpam {
	my($ad) = @_;
	return &password_encode($ad,$::Token);
}
1;
__DATA__
sub plugin_antispam_setup {
	return(
		ja=>'迷惑メール防止',
		en=>'Anti Spam Plugin',
		override=>'make_link_mail',
		require=>'',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/antispam/'
	);
}
__END__
