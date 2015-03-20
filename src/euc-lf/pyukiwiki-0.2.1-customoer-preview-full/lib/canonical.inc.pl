######################################################################
# canonical.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'canonical.inc.cgi'
######################################################################
# canonical (url)
$canonical::url=""
	if(!defined($canonical::url));
# Initlize
sub plugin_canonical_init {
	my ($base, $canonicalflg)=&getbase;
	my $hgeader;
	if($canonicalflg && $::form{mypage} && $::form{cmd} eq "read") {
		my $url="$base" . &make_cookedurl($::form{mypage});
		$url=~s/\/\//\//g;
		$::IN_HEAD.=<<EOM;
<link rel="canonical" href="$url" />
EOM
	}
	return ('init'=>1);
}
sub getbase {
	&getbasehref;
	if($canonical::url=~/$::isurl/) {
		if(substr($canonical::url, 0, length($canonical::url)) ne substr($::basehref, 0, length($canonical::url))) {
			if($::IN_HEAD!~/rel="canonical"/) {
				return ($canonical::url, 1);
			}
		}
	}
	return ($::basehref, 0);
}
1;
__DATA__
sub plugin_canonical_setup {
	return(
		ja=>'検索エンジンに対して重複URLのオリジナルを指定する',
		en=>'Identify the original of duplicate URL to search engines',
		override=>'none',
		require=>'',
		url'=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/canonical/'
	);
}
__END__
