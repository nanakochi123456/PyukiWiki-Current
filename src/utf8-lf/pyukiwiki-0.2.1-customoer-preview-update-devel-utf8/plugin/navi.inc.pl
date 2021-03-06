######################################################################
# navi.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:16:39
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
# Based on PukiWiki 1.4.6 navi.inc.php,v 1.22 2005/04/02 06:33:39 henoheno
#
#*Usage
# #navi(パターン[,prefixのタイトル][,reverse])
######################################################################

$navi::head_link=1		# <head>〜</head>に<link>タグを出力
	if(!defined($navi::head_link));
######################################################################

sub plugin_navi_convert {
	my ($args) = @_;
	my @args = split(/,/, $args);

	my $prefix = '';
	my @args = split(/,/, shift);
	my $reverse = 0;
	my (@pages, $txt, @txt, $tocnum);
	my $body = '';
	my $prefixtitle;

	if (@args > 0) {
		$prefix = shift(@args);
		foreach my $arg (@args) {
			if (lc $arg eq "reverse") {
				$reverse = 1;
			} else {
				$prefixtitle=$arg;
			}
		}
	}
	if($prefix eq '') {
		$prefix = $::form{mypage};
		$prefix =~ s/\/.*?$//g;
	}
	foreach my $page (sort keys %::database) {
		push(@pages, $page) if ($page =~ /^$prefix\/|^$prefix$/ && &is_readable($page) && $page!~/$::non_list/);
	}
	@pages = reverse(@pages) if ($reverse);

	my ($pageprev,$pagenow,$pagenext,$pagepush);
	foreach my $page(@pages) {
		if($pagenow ne '') {
			$pagenext=$page;
			last;
		} elsif($page eq $::form{mypage}) {
			$pagenow=$page;
		}
		$pageprev=$pagepush;
		$pagepush=$page;
	}

	if($navi::head_link eq 1 && $::IN_HEAD!~/<link/) {
		$::IN_HEAD.=qq(<link rel="up" href="@{[&make_cookedurl(&encode($prefix))]}" title="$prefix" />\n);
		$::IN_HEAD.=qq(<link rel="prev" href="@{[&make_cookedurl(&encode($pageprev))]}" title="$pageprev" />\n)
			if($pageprev ne '');
		$::IN_HEAD.=qq(<link rel="next" href="@{[&make_cookedurl(&encode($pagenext))]}" title="$pagenext" />\n)
			if($pagenext ne '');
	}
	$body.=qq(<ul class="navi">\n);
	$body.=qq(<li class="navi_left">@{[&make_link_wikipage($pageprev,$::resource{prevbutton})]}</li>\n)
		if($pageprev ne '');
	$body.=qq(<li class="navi_right">@{[&make_link_wikipage($pagenext,$::resource{nextbutton})]}</li>)
		if($pagenext ne '');
	$body.=qq(<li class="navi_none">@{[&make_link_wikipage($prefix,$prefixtitle eq '' ? $prefix : $prefixtitle)]}</li>\n</ul>\n<hr class="full_hr" />);
}

1;
__END__

=head1 NAME

navi.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #navi([prefix] [,prefix_title] [,reverse])

=head1 DESCRIPTION

The navigation bar of the DocBook style is displayed.

When the page of a lower class exists in the page used as a table of contents, it describes to all the page (a head and end) of them.   A link called Prev, Home, and Next is displayed. It becomes convenient to refer to the page of a lower class in order by this.

=head1 USAGE

=over 4

=item prefix

The page which hits the upper class of the page around which looks at to a table-of-contents page in order, and it turns to it is specified.

For example   When a page called hoge, hoge/1, hoge/2, and hoge/3 exists, if #navi (hoge) is described to hoge/2, a link called Home which moves to hoge, a link called Prev which moves to hoge/1, and a link called Next which moves to hoge/3 will be displayed.

When it calls first on a page, the link of a header image is outputted. When called on a page after the 2nd times, the link of a footer image is outputted. When the present page is a table-of-contents page, the list of the target pages is displayed.

When it omits, the higher rank page of the page displayed now is set up.

=item prefix_title

Setup prefix of title

=item reverse

Reverse sort of navi list

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/navi

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/navi/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/navi.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/navi.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/navi.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/navi.inc.pl?view=log>

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
