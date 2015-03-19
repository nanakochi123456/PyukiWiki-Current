######################################################################
# lang.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:15
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
# 言語cookie設定用プラグイン
# ExPlugin lang.inc.cgi、$::write_location=1を有効にする必要があります
######################################################################

sub plugin_lang_action {
	my $body;
	return if($::lang_cookie eq '' || $::write_location eq 0);
# 0.1.9 fix
	return if($::useExPlugin eq 1 && $::_exec_plugined{lang} ne 2);

	my $page=$::form{refer} ne "" ? $::form{refer} : $::FrontPage;
	$::lang_cookie{lang}=$::form{lang};
	$::lang_cookie{lang}='' if($::langlist{$::form{lang}} eq '');
	&setcookie($::lang_cookie, 1, %::lang_cookie);
	&location("$::basehref?@{[&encode($page)]}", 302, $::HTTP_HEADER);
	close(STDOUT);
	exit;
}

1;
__END__

=head1 NAME

lang.inc.pl - PyukiWiki ExPlugin

=head1 SYNOPSIS

This is explugin/lang.inc.cgi 's sub plugin, look explugin document.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/lang

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/lang/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/lang.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/lang.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/lang.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/lang.inc.pl?view=log>

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
