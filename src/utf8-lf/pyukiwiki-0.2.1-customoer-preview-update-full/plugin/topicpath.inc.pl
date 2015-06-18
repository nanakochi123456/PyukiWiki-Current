######################################################################
# topicpath.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:41:36
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Junichi http://www.re-birth.com/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# オリジナルとの変更点
# ・$topicpath::ARROW, $topicpath::FRONTPAGE への代入を変更
# ・PukiWikiライクの表示設定を追加
# ・0.1.6用のURL処理に変更
######################################################################
# select or edit style
######################################################################
# Re-Birth Original
#$topicpath::AutoLoad=1					if(!defined($topicpath::AutoLoad));
#$topicpath::SEPARATOR = $::separator	if(!defined($topicpath::SEPARATOR));
#$topicpath::FRONTMARK = ' ： '			if(!defined($topicpath::FRONTMARK));
#$topicpath::ARROW = ' &gt; '			if(!defined($topicpath::ARROW));
#$topicpath::FRONTPAGE = $::FrontPage	if(!defined($topicpath::FRONTPAGE));
#$topicpath::FRONTPAGENAME=$::FrontPage	if(!defined($topicpath::FRONTPAGENAME));
#$topicpath::PREFIX = '[ '				if(!defined($topicpath::PREFIX));
#$topicpath::SUFFIX = ' ]'				if(!defined($topicpath::SUFFIX));
######################################################################
# PukiWiki Like
$topicpath::AutoLoad=1					if(!defined($topicpath::AutoLoad));
$topicpath::SEPARATOR = $::separator	if(!defined($topicpath::SEPARATOR));
$topicpath::FRONTMARK = ' /  '			if(!defined($topicpath::FRONTMARK));
$topicpath::ARROW = ' / '				if(!defined($topicpath::ARROW));
$topicpath::FRONTPAGE = $::FrontPage	if(!defined($topicpath::FRONTPAGE));
$topicpath::FRONTPAGENAME='Top'			if(!defined($topicpath::FRONTPAGENAME));
$topicpath::PREFIX = ''					if(!defined($topicpath::PREFIX));
$topicpath::SUFFIX = ''					if(!defined($topicpath::SUFFIX));
######################################################################
sub plugin_topicpath_inline {
	# wiki.cgiからの読み込みか判断する				# commnt
	my($wikicgiflag,$page)=split(/,/, shift);
	return '' if(shift eq 1 && $topicpath::AutoLoad eq 0);
	my $mypage = $page eq '' ? $::form{mypage} : $page;
	if(!(&is_exist_page($mypage))) {
		return "";
	}
	my @path_array = split($topicpath::SEPARATOR,$mypage);
	# FrontPageのセット										# commnt
	$topicpath::FRONTPAGEUrl = &createUrl($topicpath::FRONTPAGE, $topicpath::FRONTPAGE, $topicpath::FRONTPAGE, $topicpath::FRONTPAGENAME);
	if($mypage eq $topicpath::FRONTPAGE) {
		return $topicpath::PREFIX . $topicpath::FRONTPAGEUrl . $topicpath::SUFFIX;
	}
	$result = $topicpath::FRONTPAGEUrl . $topicpath::FRONTMARK;
	my $pathname = "";
	foreach $pagename (@path_array) {
		if($pathname ne "") {
			$pathname .= $topicpath::SEPARATOR . $pagename;
		}else{
			$pathname = $pagename;
		}
		$result .= &createUrl($pagename, $pathname, $topicpath::FRONTPAGE, $topicpath::FRONTPAGENAME);
		# 矢印をつける fix 0.2.0								# commnt
		$result .= $topicpath::ARROW;
	}
	# 最後の矢印を取り除く										# commnt
	$result =~s/$topicpath::ARROW$//g;
	return $topicpath::PREFIX . $result . $topicpath::SUFFIX;
}
# ex.														# commnt
# $pagename : Page											# commnt
# $pathname : Category/Page									# commnt
sub createUrl() {
	my ($pagename,$pathname, $FRONTPAGE, $FRONTPAGENAME) = @_;
	if(&is_exist_page($pathname)) {
		return qq|<a href="@{[&make_cookedurl(&encode($pathname))]}">@{[&escape($pagename eq $FRONTPAGE ? $FRONTPAGENAME : $pagename)]}</a>|;
	} else {
		return qq|@{[&escape($pagename)]}<a href="$::script?cmd=edit&amp;mypage=@{[&encode($pathname)]}">?</a>|;
	}
}
1;
__END__
