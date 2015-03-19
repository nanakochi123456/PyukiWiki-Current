######################################################################
# iecompatiblehack.inc.pl - This is PyukiWiki yet another Wiki clone
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
# To use this plugin, rename to 'iecompatiblehack.inc.cgi'
######################################################################
#
# IE�θߴ�ɽ���ܥ����ʤ����ץ饰����
#
######################################################################
# Initlize
sub plugin_iecompatiblehack_init {
	my $agent=$ENV{HTTP_USER_AGENT};
	my $header;
	if($ENV{HTTP_USER_AGENT}=~/MSIE (\d+).(\d+)/) {
		if($1 > 6) {
			$header=<<EOM;
X-UA-Compatible: IE=$1
EOM
		}
	}
	return ('http_header'=>$header, 'init'=>1, 'func'=>'');
}
1;
__DATA__
sub plugin_iecompatiblehack_setup {
	return(
		ja=>'IE�θߴ�ɽ���ܥ������Ū�ˤʤ����ץ饰����',
		en=>'For Internet Explorer, disable compatible button',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/iecompatiblehack/'
	);
}
__END__