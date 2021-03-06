######################################################################
# search_fuzzy.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:16:36
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF Shift-JIS TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# あいまいサーチ用プラグイン、直接呼出しはできません。
# pyukiwiki.ini.cgi に
# $::use_FuzzySearch=1;
# を記述
######################################################################
# 0.2.0-p2 PukiWiki互換の引数にした。
#          バグ修正
######################################################################
use Nana::Search;
sub plugin_fuzzy_search {
	my $body = "";
	my $word=&escape(&code_convert(\$::form{word}, $::defaultcode));
	$word=&escape(&code_convert(\$::form{mymsg}, $::defaultcode))
		if($word eq '');
	if ($word) {
		my $spc;
		if ($word) {
			if($::lang eq "ja") {
				if($::defaultcode eq 'utf8') {
					$spc="\xe3\x80\x80";
				} else {
					$spc="\xa1\xa1";
				}
			}
		}
		if($spc ne "") {
			foreach(" ", $spc) {
				$wd=~s/$_/\t/g;
			}
		}
		$wd=~s/(\t+)/\t/g;
		my @words=split(/\t/,$word);
		my $total = 0;
		if ($::form{type} eq 'OR') {
			$total = 0;
			foreach my $wd (@words) {
				next if($wd eq '');
				foreach my $page (sort keys %::database) {
					next if(
						$page eq $::RecentChanges
						|| $page=~/$non_list/
						|| !&is_readable($page));
					if (Nana::Search::Search($::database{$page}, $wd) or Nana::Search::Search($page, $wd)) {
						$found{$page} = 1;
					}
					$total++;
				}
			}
		} else {	# AND 検索								# comment
			foreach my $page (sort keys %::database) {
				next if(
					$page eq $::RecentChanges
					|| $page=~/$non_list/
					|| !&is_readable($page));
				my $exist = 1;
				foreach my $wd (@words) {
					next if($wd eq '');
					if (!(Nana::Search::Search($::database{$page}, $wd) eq 1 or Nana::Search::Search($page, $wd) eq 1)) {
						$exist = 0;
					}
				}
				if ($exist) {
					$found{$page} = 1;
				}
				$total++;
			}
		}
		my $counter = 0;
		foreach my $page (sort keys %found) {
			$body .= qq|<ul>| if ($counter == 0);
			if($::use_Highlight eq 1) {
				$body .= qq(<li><a href ="$::script?cmd=read&amp;mypage=@{[&encode($page)]}&amp;word=@{[&encode($word)]}">@{[&htmlspecialchars($page)]}</a>@{[&htmlspecialchars(&get_subjectline($page))]}</li>);
			} else {
				$body .= qq(<li><a href ="$::script?@{[&htmlspecialchars(&encode($page))]}">@{[&htmlspecialchars($page)]}</a>@{[&htmlspecialchars(&get_subjectline($page))]}</li>);
			}
			$counter++;
		}
		$body .= ($counter == 0) ? $::resource{notfound} : qq|</ul>|;
	#	$body .= "$counter / $total <br />\n";
	}
	$body.=&plugin_search_form(2,$word);
	return ('msg'=>"\t$::resource{searchpage}", 'body'=>$body);
}
1;
__END__
