######################################################################
# agent.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:02:22
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
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

=head1 NAME

agent.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #agent(Regex of browser name or operating system name or robot name
        , match display page, unmatch display page)

=head1 DESCRIPTION

Display target page on useragent

=head1 USAGE

 #agent(msie,Internet Explorer Page,Sorry)
 #agent(msie32,Internet Explorer 32bit Page,Sorry) on pure 32bit OS of IE
 #agent(msiex86/9,Internet Explorer 32bit Page,Sorry) is 32bit browser on 64bit OS of IE
 #agent(msiex64/10.0,Internet Explorer 64bit Page,Sorry) on pure 64bit browser of IE
 #agent(firefox/3+,FireFox or later Page,Sorry)
 #agent(win,Windows Page,Sorry)
 #agent(mac,Mac Only!,Sorry)
 #agent(bot,Sorry bot)

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/agent

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/agent/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/agent.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/agent.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/agent.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/agent.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/AWS/browsers.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/AWS/browsers.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/AWS/browsers.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/AWS/browsers.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/AWS/domains.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/AWS/domains.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/AWS/domains.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/AWS/domains.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/AWS/operating_systems.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/AWS/operating_systems.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/AWS/operating_systems.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/AWS/operating_systems.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/AWS/robots.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/AWS/robots.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/AWS/robots.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/AWS/robots.pm?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nano.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2005-2015 by Nanami.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
