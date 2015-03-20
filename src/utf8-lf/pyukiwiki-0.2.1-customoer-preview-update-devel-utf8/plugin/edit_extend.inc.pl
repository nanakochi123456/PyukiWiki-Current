#######################################################################
# edit_extend.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:21:28
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

use strict;

$edit_extend::read_instagcss=0;
$edit_extend::read_instagjs=0;
$edit_extend::read_jquery=0;

sub plugin_edit_extend_edit_init {
	%::resource=&read_resource("$::res_dir/edit_extend.$::lang.txt", %::resource);
	my $tmp;
	$tmp=&jscss_include("jquery");
#	if($tmp ne "") {
		$edit_extend::read_jquery=1;
#	}
#	$::IN_HEAD.=$tmp;
	$tmp=&jscss_include("instag");
#	if($tmp ne "") {
		$edit_extend::read_instagcss=1;
		$edit_extend::read_instagjs=1;
#	}
#	$::IN_HEAD.=$tmp;
	return;
}

sub plugin_edit_extend_edit {
	my $body;
	return
		if($edit_extend::read_instagcss eq 0 || $edit_extend::read_instagjs eq 0);
	$body=<<EOM;
<span id="editextend"></span><br />
EOM
	$::IN_JSHEAD.=<<EOM;
insTagForm($edit_extend::read_jquery, $::usePukiWikiStyle, "$::image_url");
pick();
EOM
	return $body;
}
1;
__END__

=head1 NAME

edit_extend.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 none

=head1 DESCRIPTION

Extend Edit module

This is submodule of edit.inc.pl

=head1 SETTING

=head 2 pyukiwiki.ini.cgi

=over 4

=item $::extend_edit

0 - Non use

1 - PyukiWiki Compatible

2 - New PyukiWiki Design

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/edit_extend

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/edit_extend/>

=item PyukiWiki/Plugin/Standard/edit

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/edit/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/edit_extend.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/edit_extend.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/edit_extend.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/edit_extend.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/edit.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/edit.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/edit.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/edit.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

=cut
