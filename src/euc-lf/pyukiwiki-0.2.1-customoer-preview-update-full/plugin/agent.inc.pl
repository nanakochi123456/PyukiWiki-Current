######################################################################
# agent.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:41:11
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
#use strict;
$PLUGIN_AGENT::Load=0;
my @RobotsSearchIDOrder;
sub plugin_agent_init {
	if($PLUGIN_AGENT::Load eq 0) {
		require "$::explugin_dir/AWS/browsers.pm";
		require "$::explugin_dir/AWS/domains.pm";
		require "$::explugin_dir/AWS/operating_systems.pm";
		require "$::explugin_dir/AWS/robots.pm";
		require "$::explugin_dir/AWS/search_engines.pm";
		$LOGS::Load=1;
		push(@RobotsSearchIDOrder, @RobotsSearchIDOrder_list1);
		push(@RobotsSearchIDOrder, @RobotsSearchIDOrder_list2);
		push(@RobotsSearchIDOrder, @RobotsSearchIDOrder_listgen);
	}
	$PLUGIN_AGENT::Load=1;
}
sub plugin_agent_inline {
	return &plugin_agent_convert(shift);
}
sub plugin_agent_convert {
	my($checkname, $page,$nonpage)=split(/,/,shift);
	&plugin_agent_init;
	my $uabrowser;
	my $uabrowserver;
	my($checkbrowser, $checkver)=split(/\//,lc $checkname);
	my $browser=lc $ENV{HTTP_USER_AGENT};
	# ブラウザー判定
	foreach my $id(@BrowsersFamily) {
		if($browser=~/$BrowsersVersionHashIDLib{$id}/) {
			my $version=$2 eq '' ? $1 : $2;
			if($id eq "safari") {
				$version=$BrowsersSafariBuildToVersionHash{$version};
			}
			$uaid=$id;
			$uabrowser=lc $BrowsersHashIDLib{$id};
			$uabrowserver=lc $version;
			if($uaid=~/$checkbrowser/ || $uabrowser=~/$checkbrowser/) {
				if($checkver eq '') {
					return &plugin_agent_viewpage($page);
				}
				my($majerver, $minerver, $updatever)=split(/\./,$uabrowserver);
				if($checkver=~/\+/) {
					$checkver=~s/[+\.]//g;
					$checkver+=0;
					if($majerver >=$checkver) {
						return &plugin_agent_viewpage($page);
					}
				} else {
					if($majerver eq $checkver || "$majerver.$minerver" eq $checkver) {
						return &plugin_agent_viewpage($page);
					}
				}
			}
			$uaid="";
		}
	}
	# OS判定
	foreach my $regex(@OSSearchIDOrder) {
		if($browser=~/$regex/) {
			$uaos=lc &plugin_agent_htmlcut($OSHashLib{$OSHashID{$regex}});
			if($uaos=~/$checkbrowser/ || $OSHashID{$regex} eq $checkbrowser) {
				return &plugin_agent_viewpage($page);
			}
		}
	}
	# ロボット判定
	foreach(@RobotsSearchIDOrder) {
		if($browser =~ /$_/) {
			$uabrowser='robot';
			$uabrowserver=lc &plugin_agent_htmlcut($RobotsHashIDLib{$_});
			if($uabrowser=~/$checkbrowser/ || $uabrowserver=~/$checkbrowser/) {
				return &plugin_agent_viewpage($page);
			}
		}
	}
	return &plugin_agent_viewpage($nonpage);
}
sub plugin_agent_viewpage {
	my($page)=shift;
	if($page ne '') {
		return &text_to_html($::database{$page}) . " ";
	}
	return ' ';
}
sub plugin_agent_htmlcut {
	my($text)=shift;
	$text=~s/<([^<>]+)>//g;
	return $text;
}
1;
__DATA__
sub plugin_agent_usage {
	return {
		name => 'agent',
		version => '1.1',
		type => 'inline,convert',
		author => 'Nanami',
		syntax => '#agent(regex of browser name|os name|robot name, match display page(include), unmatch display page)',
		description => 'Display target page on useragent.',
		description_ja => 'ユーザーエイジェントに基づいて、表示するページを指定する。',
		example => '#alias(msiex64,IE64PAGE,NULLPAGE)',
	};
}
1;
__END__
