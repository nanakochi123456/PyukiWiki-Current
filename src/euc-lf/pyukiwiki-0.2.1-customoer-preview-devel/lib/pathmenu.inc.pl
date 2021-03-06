######################################################################
# pathmenu.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:20:51
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
# This is extented plugin.
# To use this plugin, rename to 'pathmenu.inc.cgi'
######################################################################

use strict;

$pathmenu::loaded=1;

sub plugin_pathmenu_init {
	if(&exist_plugin("topicpath") ne 0) {
		my $mypage=$::form{mypage};
		my @path_array = split($topicpath::SEPARATOR,$mypage);
		my $c=0;
		my @paths=();
		my $pathtop;
		foreach my $pagename(@path_array) {
			if($c eq 0) {
				$pathtop=$pagename;
			} else {
				$pathtop .= $topicpath::SEPARATOR . $pagename;
			}
			push(@paths, $pathtop);
			$c++;
		}

		foreach my $pagename(@paths) {
			$::MenuBar		=&chkbars($pagename, $::MenuBar);
			$::SideBar		=&chkbars($pagename, $::SideBar);
			$::TitleHeader	=&chkbars($pagename, $::TitleHeader);
			$::Header		=&chkbars($pagename, $::Header);
			$::Footer		=&chkbars($pagename, $::Footer);
			$::BodyHeader	=&chkbars($pagename, $::BodyHeader);
			$::BodyFooter	=&chkbars($pagename, $::BodyFooter);
			$::SkinFooter	=&chkbars($pagename, $::SkinFooter);
		}
		return('init'=>1);
	}
	return('init'=>0);
}

sub chkbars {
	my($pg,$menu)=@_;
	if($::database{"$pg$topicpath::SEPARATOR$menu"} ne '') {
		return "$pg$topicpath::SEPARATOR$menu";
	}
	return $menu;
}

1;
__DATA__
sub plugin_pathmenu_setup {
	return(
		ja=>'階層下にMenuBar等を作る',
		en=>'Create a hierarchy under MenuBar etc. system page.',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/pathmenu/'
	);
__END__

=head1 NAME

pathmenu.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

Create a hierarchy under MenuBar etc. system page.

=head1 DESCRIPTION

Create a hierarchy under MenuBar etc. system page.

 PyukiWiki/MenuBar
 PyukiWiki/Sample/:SideBar

=head1 USAGE

rename to pathmenu.inc.cgi

=head1 OVERRIDE

none

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/pathmenu

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/pathmenu/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/pathmenu.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/pathmenu.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/pathmenu.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/pathmenu.inc.pl?view=log>

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
