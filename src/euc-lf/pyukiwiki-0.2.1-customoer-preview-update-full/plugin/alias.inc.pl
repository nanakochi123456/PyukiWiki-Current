######################################################################
# alias.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:14:33
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
# Based on PukiWiki Plugin "alias.inc.php" ver.1.5 2005/05/28
# modified by kochi
######################################################################
use strict;
$alias::loopmax=2;
%alias::loopcount;
@alias::pushmypage;
sub plugin_alias_convert {
	# no param											# comment
	my($page,$usethispagetitle)=split(/,/, shift);
	return ' ' if($::form{mypage}=~/($::MenuBar|$::SideBar|$::Header|$::Footer)$/);
	return ' ' if($::form{cmd} ne 'read');
	return ' ' if($::form{noalias} eq 'true');
	return ' ' if($alias::loopcount{$::form{mypage}} > 0);
	$alias::loopcount{$::form{mypage}}++;
	$alias::loopcount{""}++;
	return ' ' if($alias::loopcount{""} >= $alias::loopmax);
	push(@alias::pushmypage,$::form{mypage});
	my $title=$::form{mypage};
	$::form{mypage}=$page;
	if($usethispagetitle eq 1) {
		&do_read($title);
	} else {
		&do_read;
	}
	&close_db;
	exit;
}
1;
__DATA__
sub plugin_alias_usage {
	return {
		name => 'alias',
		type => 'convert',
		version => '1.0',
		author => 'Nanami',
		syntax => '#alias(page, flag)',
		description => 'It jumps to specified another Wiki page, without displaying a page.',
		description_ja => 'ページを表示せずに、指定した別のWikiページへジャンプする。',
		example => '#alias(pagename, pageflag)',
	};
}
1;
__END__
