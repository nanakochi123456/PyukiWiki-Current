######################################################################
# iecompatiblehack.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:23:57
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
# This is extented plugin.
# To use this plugin, rename to 'iecompatiblehack.inc.cgi'
######################################################################
#
# IE�θߴ�ɽ���ܥ����ʤ����ץ饰����
#
######################################################################


# Initlize

sub plugin_iecompatiblehack_init {
	my $agent=$ENV{HTTP_USER_AGENT};
	my $header;
	if($ENV{HTTP_USER_AGENT}=~/MSIE (\d+).(\d+)/) {
		if($1 > 6) {
			$header=<<EOM;
X-UA-Compatible: IE=$1
EOM
		}
	}
	return ('http_header'=>$header, 'init'=>1, 'func'=>'');
}

1;
__DATA__
sub plugin_iecompatiblehack_setup {
	return(
		ja=>'IE�θߴ�ɽ���ܥ������Ū�ˤʤ����ץ饰����',
		en=>'For Internet Explorer, disable compatible button',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/iecompatiblehack/'
	);
}
__END__
=head1 NAME

iecompatiblehack.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

For Internet Explorer, disable compatible button

=head1 USAGE

rename to iecompatiblehack.inc.cgi

=head1 OVERRIDE

none

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/iecompatiblehack

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/iecompatiblehack/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/iecompatiblehack.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/iecompatiblehack.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/iecompatiblehack.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/iecompatiblehack.inc.pl?view=log>

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
