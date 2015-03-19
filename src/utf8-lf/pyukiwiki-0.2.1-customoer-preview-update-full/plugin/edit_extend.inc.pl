#######################################################################
# edit_extend.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:36:24
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
		$edit_extend::read_jquery=1;
	$tmp=&jscss_include("instag");
		$edit_extend::read_instagcss=1;
		$edit_extend::read_instagjs=1;
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
