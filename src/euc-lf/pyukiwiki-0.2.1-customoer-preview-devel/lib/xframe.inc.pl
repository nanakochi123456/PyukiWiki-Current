######################################################################
# xframe.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:53:30
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'xframe.inc.cgi'
######################################################################
#
# �ե졼�಼��ɽ������ʤ��褦�ˤ���ץ饰����
# http://www.jpcert.or.jp/ed/2009/ed090001.pdf
#
######################################################################
#
# DENY:¾��Web�ڡ�����frame��ޤ���iframe��Ǥ�ɽ������ݤ��롣
# SAMEORIGIN:Top-level-browsing-context�����פ������Τߡ�¾��Web�ڡ���
#            ���frame����iframe��Ǥ�ɽ������Ĥ��롣

$XFRAME::MODE="DENY"
#$XFRAME::MODE="SAMEORIGIN"
	if(!defined($XFRAME::MODE));


# Initlize

sub plugin_xframe_init {
	my $agent=$ENV{HTTP_USER_AGENT};
	my $header;
	$header=<<EOM;
X-FRAME-OPTIONS: $XFRAME::MODE
EOM
	return ('http_header'=>$header, 'init'=>1, 'func'=>'');
}

1;
__DATA__
sub plugin_xframe_setup {
	return(
		ja=>'�ե졼�಼��ɽ������ʤ��褦�ˤ���ץ饰����',
		en=>'Disable view page on apper on the bottom frame',
		override=>'none',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/xframe/'
	);
}
__END__
=head1 NAME

xframe.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

Disable view page on apper on the bottom frame

=head1 USAGE

rename to xframe.inc.cgi

=head1 SETTING

Write to info/setting.ini.cgi

$XFRAME::MODE="DENY" or $XFRAME::MODE="SAMEORIGIN"

=head1 OVERRIDE

none

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/xframe

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/xframe/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/xframe.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/xframe.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/xframe.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/xframe.inc.pl?view=log>

=item Refernce

L<http://www.jpcert.or.jp/ed/2009/ed090001.pdf>

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
