######################################################################
# ignoreoldbrowser.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'ignoreoldbrowser.inc.cgi'
######################################################################
# Initlize											# comment
$ignoreoldbrowser::browser{msie}=6;
$ignoreoldbrowser::browser{firefox}=0;
$ignoreoldbrowser::browser{netscape}=-1;
$ignoreoldbrowser::browser{opera}=0;
$ignoreoldbrowser::browser{chrome}=0;
$ignoreoldbrowser::browser{safari}=3;
$ignoreoldbrowser::support{windows31}="";
$ignoreoldbrowser::support{windows9}="";
$ignoreoldbrowser::support{windowsnt3}="";
$ignoreoldbrowser::support{windowsnt4}="";
#$ignoreoldbrowser::support{windowsnt51}="";
$ignoreoldbrowser::support{windowsnt50}="firefox";
$ignoreoldbrowser::support{windowsnt51}="msie8,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt52}="msie8,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt60}="msie,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt61}="msie,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt62}="msie,firefox,chrome,opera";
sub plugin_ignoreoldbrowser_init {
	my $title;
	my $ua=lc $ENV{HTTP_USER_AGENT};
	$ua=~s/[\s]//g;
	$os=$ua;
	$os=~s/[\.]//g;
	my $link;
	my $text="";
	foreach my $list(sort keys %ignoreoldbrowser::support) {
		if($os=~/$list/) {
			my $sup=$ignoreoldbrowser::support{$list};
			if($sup eq "") {
				$title=$::resource{ignoreoldbrowser_plugin_title_ignoreos};
				$text=$::resource{ignoreoldbrowser_plugin_ignoreos};
			} else {
				my $browser;
				my $ver;
				if($ua=~/opera\/(\d+)\.(\d+)/) {
					$browser="opera";
					$ver=$1;
				}
				if($ua=~/trident\/\d+.\d+; rv:(\d+).(\d+)/) {
					$browser="msie";
					$ver=$1;
				}
				if($ua=~/msie(\d+).(\d+)/) {
					$browser="msie";
					$ver=$1;
				}
				if($ua=~/firefox\/(\d+)\./) {
					$browser="firefox";
					$ver=$1;
				}
				if($ua=~/chrome\/(\d+)\./) {
					$browser="chrome";
					$ver=$1;
				}
				if($ua=~/version\/(\d+).+safari/) {
					$browser="safari";
					$ver=$1;
				}
				if($browser ne "") {
					if($ver <= $ignoreoldbrowser::browser{$browser}) {
					$title=$::resource{ignoreoldbrowser_plugin_title_notsupportbrowser};
					$text.=$::resource{ignoreoldbrowser_plugin_nosupportbrowser};
					foreach my $blist(split(/,/,$sup)) {
						$text.="[" . $::resource{"ignoreoldbrowser_plugin_" . $blist} . "]&nbsp;";
					}
				}
			}
		}
		if($title ne "") {
			$text=~s/\$wiki_title/$::wiki_title/g;
			my $html=$::resource{ignoreoldbrowser_plugin_html};
			$html=~s/\$title/$title/g;
			$html=~s/\$text/$text/g;
			print <<EOM;
Content-type: text/html
$html
EOM
			exit;
			}
		}
	}
	return ('init'=>0);
}
1;
__DATA__
sub plugin_ignoreoldbrowser_setup {
	return(
		ja=>'古いブラウザーでの表示を拒否する'.
		en=>'Ignore old browser',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/ignoreoldbrowser/'
	);
}
__END__
