######################################################################
# help.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
sub plugin_help_action {
	$::form{mypage}=$::resource{help};
	if(!&is_readable($::form{mypage})) {
		&print_error($::resource{auth_readfobidden});
	}
	# 2005.11.2 pochi: 部分編集を可能に				# comment
	&plugin_help_skinex($::form{mypage}, &text_to_html($::database{$::form{mypage}}, mypage=>$::form{mypage}), 2, @_);
	&close_db;
	exit;
}
sub plugin_help_skinex {
	my ($page, $body, $is_page, $pageplugin) = @_;
	my $bodyclass = "normal";
	my $editable = 0;
	my $admineditable = 0;
	$pageplugin+=0;
	$::pageplugin+=0;
	if (&is_frozen($::form{refer}) && &is_exist_page($::form{refer})) {
		$admineditable = 1;
		$bodyclass = "frozen";
	} elsif (&is_editable($::form{refer}) && &is_exist_page($::form{refer})) {
		$admineditable = 1;
		$editable = 1;
	}
	&makenavigator($page,$is_page,$editable,$admineditable);
	$::IN_HEAD.=&meta_robots($::form{cmd},$page,$body);
	my $output_mime = $::htmlmode eq "xhtml11"
		&& $ENV{'HTTP_ACCEPT'}=~ m!application/xhtml\+xml!
		&& &is_no_xhtml(1) eq 0
		? 'application/xhtml+xml' : 'text/html';
	$::HTTP_HEADER=&http_header("Content-type: $output_mime; charset=$::charset", $::HTTP_HEADER);
	require $::skin_file;
	my $body=&skin($page, $body, $is_page, $bodyclass, $editable, $admineditable, $::basehref);
	$body=&_db($body);
	if($::lang eq 'ja' && $::defaultcode ne $::kanjicode) {
		$body=&code_convert(\$body,   $::kanjicode);
	}
	&content_output($::HTTP_HEADER, $body);
}
1;
__END__
