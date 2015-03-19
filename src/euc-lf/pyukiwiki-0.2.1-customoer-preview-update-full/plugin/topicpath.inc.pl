######################################################################
# topicpath.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:14:47
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Junichi http://www.re-birth.com/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# ���ꥸ�ʥ�Ȥ��ѹ���
# ��$topicpath::ARROW, $topicpath::FRONTPAGE �ؤ��������ѹ�
# ��PukiWiki�饤����ɽ��������ɲ�
# ��0.1.6�Ѥ�URL�������ѹ�
######################################################################
# select or edit style
######################################################################
# Re-Birth Original
#$topicpath::AutoLoad=1					if(!defined($topicpath::AutoLoad));
#$topicpath::SEPARATOR = $::separator	if(!defined($topicpath::SEPARATOR));
#$topicpath::FRONTMARK = ' �� '			if(!defined($topicpath::FRONTMARK));
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
	# wiki.cgi������ɤ߹��ߤ�Ƚ�Ǥ���				# commnt
	my($wikicgiflag,$page)=split(/,/, shift);
	return '' if(shift eq 1 && $topicpath::AutoLoad eq 0);
	my $mypage = $page eq '' ? $::form{mypage} : $page;
	if(!(&is_exist_page($mypage))) {
		return "";
	}
	my @path_array = split($topicpath::SEPARATOR,$mypage);
	# FrontPage�Υ��å�										# commnt
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
		# �����Ĥ��� fix 0.2.0								# commnt
		$result .= $topicpath::ARROW;
	}
	# �Ǹ������������										# commnt
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
