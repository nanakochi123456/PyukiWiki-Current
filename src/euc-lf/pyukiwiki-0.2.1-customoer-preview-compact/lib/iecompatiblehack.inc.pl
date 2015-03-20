######################################################################
# iecompatiblehack.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'iecompatiblehack.inc.cgi'
######################################################################
#
# IEの互換表示ボタンをなくすプラグイン
#
######################################################################
# Initlize
sub plugin_iecompatiblehack_init {
	my $agent=$ENV{HTTP_USER_AGENT};
	my $header;
	if($ENV{HTTP_USER_AGENT}=~/Trident\/\d+.\d+; rv:(\d+).(\d+)/) {
		$header=<<EOM;
X-UA-Compatible: IE=$1
EOM
	}
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
		ja=>'IEの互換表示ボタンを強制的になくすプラグイン',
		en=>'For Internet Explorer, disable compatible button',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/iecompatiblehack/'
	);
}
__END__
