######################################################################
# alias.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:23:29
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
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
		description_ja => 'ページを表示せずに、指定した別のWikiページへジャンプする。',

		example => '#alias(pagename, pageflag)',
	};
}

1;
__END__

=head1 NAME

alias.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #alias(pagename [,pagenameflag])

=head1 DESCRIPTION

It jumps to specified another Wiki page, without displaying a page.

=back

=head1 USAGE

=over 4

=item pagename

Specify wiki page. When the loop is carried out, an alias is ended at the time and the page in this time is displayed.

=item pagenameflag

If it specified 0, the page name of the alias point will be displayed.

If it specified 1, the page name of alias origin will be displayed. However, as for the link of edit etc., the page name of the alias point is specified.

=item other

In order to change the page of alias origin, please change by the ?cmd=adminedit&mypage=pagename.

=back

=head1 SETTING

=head2 alias.inc.pl

=over 4

=item $alias::loopmax

The number of times of the maximum of an alias is specified. A default is 2.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/alias

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/alias/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/alias.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/alias.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/alias.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/alias.inc.pl?view=log>

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
