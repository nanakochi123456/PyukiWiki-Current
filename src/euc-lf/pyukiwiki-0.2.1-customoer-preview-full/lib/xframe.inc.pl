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
# �ե졼�಼��ɽ������ʤ��褦�ˤ���ץ饰����
# http://www.jpcert.or.jp/ed/2009/ed090001.pdf
#
######################################################################
#
# DENY:¾��Web�ڡ�����frame��ޤ���iframe��Ǥ�ɽ������ݤ��롣
# SAMEORIGIN:Top-level-browsing-context�����פ������Τߡ�¾��Web�ڡ���
#            ���frame����iframe��Ǥ�ɽ������Ĥ��롣
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
		ja=>'�ե졼�಼��ɽ������ʤ��褦�ˤ���ץ饰����',
		en=>'Disable view page on apper on the bottom frame',
		override=>'none',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/xframe/'
	);
}
__END__
