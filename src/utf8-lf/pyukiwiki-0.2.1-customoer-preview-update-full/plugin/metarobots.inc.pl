######################################################################
# metarobots.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:36:42
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 add description option
# v0.2.0-p2 Bugfix
# v0.2.0 First Release
#
#*Usage
# #metarobots(keywords,[keywords]...)
# #metarobots(description,str)
# #metarobots(disable)
######################################################################
sub plugin_metarobots_convert {
	my ($arg)=@_;
	return if(!&is_frozen($::form{mypage}));
	return ' ' if($arg eq '');
	my @meta_keyword;
	my $keyword;
	my $noarchiveflg=0;
	my $disableflg=0;
	my $descriptionflg=0;
	my $cmd=$::form{cmd};
	if($cmd=~/edit|admin|diff|attach|backup/
		|| $::form{mypage} eq '' && $cmd!~/list|sitemap|recent/
		|| $::form{mypage}=~/$::resource{help}|$::resource{rulepage}|$::RecentChanges|$::MenuBar|$::SideBar|$::TitleHeader|$::Header|$::Footer|$::BodyHeader|$::BodyFooter|$::SkinFooter|$::SandBox|$::InterWikiName|$::InterWikiSandBox|$::non_list/
		|| $::meta_keyword eq "" || lc $::meta_keyword eq "disable"
		|| &is_readable($::form{mypage}) eq 0) {
		$disableflg=1;
	}
	if(!$disableflg) {
		foreach my $word (split(/,/,"@{[&htmlspecialchars($arg)]}")) {
			if($word eq "description") {
				$descriptionflg=1;
				next;
			}
			if($word eq "noarchive") {
				$noarchiveflg=1;
				next;
			}
			if($word eq "disable" || $word eq "noindex") {
				$disableflg=1;
				next;
			}
			my $flg=0;
			if($arg ne "") {
				foreach my $tmp (@meta_keyword) {
					if($tmp eq $word) {
						$flg=1;
						last;
					}
				}
				push(@meta_keyword, $word)
					if($flg eq 0);
			}
		}
		if(!$descriptionflg) {
			foreach my $word (split(/,/,"$::meta_keyword")) {
				my $flg=0;
				foreach my $tmp (@meta_keyword) {
					if($tmp eq $word) {
						$flg=1;
						last;
					}
				}
				push(@meta_keyword, $word)
					if($flg eq 0);
			}
		}
		foreach(@meta_keyword) {
			$keyword.="$_,";
		}
		$keyword=~s/\,$//g;
	}
	if($disableflg eq 1) {
		$::IN_META_ROBOTS=<<EOM;
<meta name="robots" content="NOINDEX,NOFOLLOW,NOARCHIVE" />
<meta name="googlebot" content="NOINDEX,NOFOLLOW,NOARCHIVE" />
EOM
	} elsif($descriptionflg eq 1) {
		$::IN_META_ROBOTS.=<<EOM;
<meta name="description" content="$keyword" />
EOM
	} elsif($noarchiveflg eq 1) {
		$::IN_META_ROBOTS.=<<EOM;
<meta name="robots" content="INDEX,FOLLOW,NOARCHIVE" />
<meta name="googlebot" content="INDEX,FOLLOW,NOARCHIVE" />
<meta name="keywords" content="$keyword" />
EOM
	} else {
		$::IN_META_ROBOTS.=<<EOM;
<meta name="robots" content="INDEX,FOLLOW" />
<meta name="googlebot" content="INDEX,FOLLOW,ARCHIVE" />
<meta name="keywords" content="$keyword" />
EOM
	}
	return ' ';
}
1;
__END__
