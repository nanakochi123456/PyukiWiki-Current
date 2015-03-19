######################################################################
# HTMLOpt.pm - $Id$
#
# "Nana::HTMLOpt" ver 0.1 $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
