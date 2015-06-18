######################################################################
# location.inc.pl - This is PyukiWiki yet another Wiki clone
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
# v0.2.1 2012/09/27 JavaScriptでの移動をできるようにした。
# v0.2.1 2012/04/25 0のとき、Locationヘッダで移動するようにした。
# v0.1.9 2011/02/23 新規作成
#
# *Usage
# #location(http:�・ or wikiページ名)
#
# 安全の為、凍結されているページでしか実行されません。
######################################################################
use strict;
$::location::move_time=3
	if(!defined($::location::move_time));
$location::301redirect=1
	if(!defined($location::301redirect));
sub plugin_location_convert {
	my ($url, $time, $jsflag, $nomsg, $fakeurl)=split(/,/,shift);
	return if(!&is_frozen($::form{mypage}));
	if(&is_exist_page($url)) {
		my $tmp=&make_cookedurl($url);
		$url="$::basehref$tmp";
	}
	$::location::move_time=$time if($time ne "");
	if($::location::move_time eq 0) {
		&location($url, $location::301redirect eq 1 ? 301 : 302, $::HTTP_HEADER);
		exit;
	}
	if($jsflag=~/js/) {
		$::IN_JSHEAD.=<<EOM;
jslocation("sec",'$url',$::location::move_time, '$fakeurl');
EOM
		return qq(<span id="sec"></span>);
	}
	$::IN_HEAD.=<<EOM;
<meta http-equiv="Refresh" content="$::location::move_time;url=$url" />
EOM
	my $body=$::resource{location_plugin_message};
	$body=~s/\$URL/$url/g;
	return ' ' if($nomsg eq "nomsg");
	return $body;
}
1;
__END__
