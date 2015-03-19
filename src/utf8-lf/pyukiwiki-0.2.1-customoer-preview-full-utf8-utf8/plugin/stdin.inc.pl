######################################################################
# stdin.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
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
require "$::plugin_dir/contents.inc.pl";
sub plugin_stdin_action {
	my $body;
	$::nowikiname = 1;
	# CGIでの実行を拒否する
	if($ENV{HTTP_USER_AGENT} ne '' || $ENV{HTTP_HOST} ne ''
	|| $ENV{REMOTE_ADDR} ne '') {
		return '';
	}
	&load_wiki_module(
		"init", "func", "db", "http", "html",
		"link", "sub", "plugin", "wiki");
	my $buf;
	my $contents_wiki;
	while(<STDIN>) {
		if(/^#contents/) {
			$contents_wiki=$_
		}
		$buf.=$_;
	}
	my $level;
	if($contents_wiki=~/^#contents\(.+?\,\d/) {
		$level=$1;
	} elsif($contents_wiki=~/^#contents\(\,1/) {
		$level=1;
	} else {
		$level=0;
	}
	my $contents=&plugin_contents_main("?",$level,split(/\n/, $buf));
	my $tmp=&text_to_html($buf);
	my $html;
$::wiki_name = '\b([A-Z][a-z]+[A-Z][a-z]+)\b';
$::bracket_name ='\[\[((?!\[)[^\]]+?)\]\]';
$::isurl=qq(s?(?:https?|ftp|news)://[-_.!~*'a-zA-Z0-9;/?:@&=+%#]+);
$::ismail=q{(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|"[^\\\\\x80-\xff\n\015"]*(?:\\\\[^\x80-\xff][^\\\\\x80-\xff\n\015"]*)*")(?:\.(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|"[^\\\\\x80-\xff\n\015"]*(?:\\\\[^\x80-\xff][^\\\\\x80-\xff\n\015"]*)*"))*@(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|\[(?:[^\\\\\x80-\xff\n\015\[\]]|\\\\[^\x80-\xff])*\])(?:\.(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|\[(?:[^\\\\\x80-\xff\n\015\[\]]|\\\\[^\x80-\xff])*\]))+};
	&_init_inline_regex;
	foreach(split(/\n/, $tmp)) {
		s!($::inline_regex)!&make_link($1)!geo;
		$html.="$_\n";
	}
	$html=~s/\#contents.*\n/$contents/g;
	$html=~s/cmd=stdin//g;
	$html=~s/(\&|\&amp;)br;/\<br \/\>/g;
	$html=~s/(\&|\&amp;)hr;/\<hr \/\>/g;
	$html=~s/(\&|\&amp;)nbsp;/&nbsp;/g;
	print "$html\n";
	exit;
}
1;
__END__
