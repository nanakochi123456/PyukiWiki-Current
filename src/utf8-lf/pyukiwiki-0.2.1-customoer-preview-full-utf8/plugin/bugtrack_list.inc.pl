######################################################################
# bugtrack_list.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 multicommentの出来がよくなったら、１から作り直しを
#        考えています
# v0.2.0 追記 全くといっていいぐらいいじられていません。
######################################################################
# 変更履歴:
#  2002.06.17: 作り始め
#
# Id: bugtrack.inc.php,v 1.14 2003/05/17 11:18:22 arino Exp
#
sub plugin_bugtrack_pageinfo
{
	my ($page, $no) = @_;
	my %hash;
	my $body = $::database{$page};
	my $flg=0;
	foreach my $line(split(/\n/, $body)) {
		if($line=~/^-/) {
			if($line=~/^-(.+?)\:\s(.*)/) {
				$hash{$1}=$2;
				$flg=1;
			}
		} elsif($flg) {
			return %hash;
		}
	}
}
sub plugin_bugtrack_list_convert
{
	my $body;
	my $base = $::form{mypage};
	my @category = split(/,/, shift);
	if (@category > 0) {
		my $_base = &unarmor_name(shift(@category));
	#	$_base = get_fullname($_base, $base);						# comment
		if ($::database{$_base}) {
			$base = $_base;
		}
	}
	my @data;
	my $pattern = "$base$::separator";
	my $pattern_len = length($pattern);
	my @lines;
	foreach(split(/,/,$::resource{bugtrack_line})) {
		push(@lines, $::resource{"bugtrack_$_"});
	}
	foreach my $page (keys %::database) {
		if(substr($pattern, 0, $pattern_len) eq substr($page, 0, $pattern_len)) {
			my %line = &plugin_bugtrack_pageinfo($page);
			my $bgcolor;
			foreach(split(/,/,$::resource{bugtrack_state_list})) {
				if($line{$::resource{bugtrack_state}}=~/$::resource{"bugtrack_state_$_"}/) {
					$bgcolor=$::resource{"bugtrack_statebgcolor_$_"}
						if($bgcolor eq "");
				}
			}
			$bgcolor=$::resource{bugtrack_statebgcolor_other}
				if($bgcolor eq "");
			my $line;
			foreach my $li(@lines) {
				foreach my $l(keys %line) {
					if($li eq $l) {
						if($li eq $::resource{bugtrack_pagename}) {
							$line.=qq(|BGCOLOR($bgcolor):[[$page]]);
						} else {
							$line.=qq(|BGCOLOR($bgcolor):$line{$l});
						}
					}
				}
			}
			push(@data,"$line|") if($line ne "")
		}
	}
	my $body;
	foreach my $li(@lines) {
		$body.="|CENTER:BGCOLOR($::resource{bugtrack_headbgcolor}):$li";
	}
	$body.="|h\n";
	foreach(@data) {
		$body.="$_\n";
	}
	return &text_to_html($body);
}
1;
__DATA__
sub plugin_bugtrack_usage {
	return {
		name => 'bugtrack',
		version => '1.0',
		type => 'command,convert',
		author => 'Nekyo',
		syntax => '#bugtrack',
		description => 'Bugtrack System',
		description_ja => 'バグトラックシステム',
		example => '#bugtrack',
	};
}
1;
__END__
