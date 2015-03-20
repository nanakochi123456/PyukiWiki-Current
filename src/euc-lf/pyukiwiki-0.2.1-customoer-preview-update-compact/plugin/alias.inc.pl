######################################################################
# alias.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
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
		description_ja => '�ڡ�����ɽ�������ˡ����ꤷ���̤�Wiki�ڡ����إ����פ��롣',
		example => '#alias(pagename, pageflag)',
	};
}
1;
__END__
