######################################################################
# title.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:23:25
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
# v0.2.0-p2 add option
# v0.2.0 First Release
#
#*Usage
# #title(title tag string)
# #title(title tag string,add)
######################################################################

sub plugin_title_convert {
	my ($arg) = shift;
	return if(!&is_frozen($::form{mypage}));
	my($title,$flg)=split(/,/,$arg);
	if($flg ne '') {
		$::IN_TITLE=&htmlspecialchars($title) . "\t";
	} else {
		$::IN_TITLE=&htmlspecialchars($title);
	}
	return ' ';
}
1;
__END__

=head1 NAME

title.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #title(title tag string)

=head1 DESCRIPTION

Setting title tag

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/title

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/title/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/title.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/title.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/title.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/title.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

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
