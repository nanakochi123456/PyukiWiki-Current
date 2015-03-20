######################################################################
# HTMLOpt.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:54:51
#
# "Nana::HTMLOpt" ver 0.1 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package	Nana::HTMLOpt;
use 5.005;
use strict;
use integer;
use vars qw($VERSION);
$VERSION = '0.1';

######################################################################

sub xhtml {
	my($body)=shift;

	$body=~s/\/\/\-\-\>\n?\<\/script\>\n?<script\s?type\=\"text\/javascript\"\>\<\!\-\-\n?//g;
	$body=~s/(<\!\-\-)/\n\/\/<\!\[CDATA\[/g;
	$body=~s/(\/\/\-\->)/\/\/\]\]>/g;
	$body=~s/<pre>\n/<pre>/g;
	$body=~s/<div>([\s\t\r\n]+)?<\/div>//g;
	$body=~s/<p>\n<\/p>(<p>\n<\/p>)?/<p>\n<\/p>/g;
	$body=~s/>\n(\n+)?</>\n</g;

	return $body;
}

sub html {
	my($body)=shift;

	$body=~s/\/\/\-\-\>\n?\<\/script\>\n?<script\s?type\=\"text\/javascript\"\>\<\!\-\-\n?//g;
	$body=~s/\ \/>/>/g;
	$body=~s/<div>([\s\t\r\n]+)?<\/div>//g;
	$body=~s/<p>\n<\/p>(<p>\n<\/p>)?/<p>\n<\/p>/g;
	$body=~s/>\n(\n+)?</>\n</g;

	return $body;
}
1;
__END__

=head1 NAME

Nana::HTMLOpt - HTML Optimizer module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/HTMLOpt.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/HTMLOpt.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/HTMLOpt.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/HTMLOpt.pm?view=log>

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
