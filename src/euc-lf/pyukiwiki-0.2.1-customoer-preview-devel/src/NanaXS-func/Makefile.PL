######################################################################
# Makefile.PL - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:49
#
# 
# Author Nanami
# http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# XSPKG : NanaXS::func 0.1

use 5.008100;

require "../xsmake/pyukiwikixs.pl";

&writemakefile(
	Module=>"NanaXS::func",
	File=>"func.pm",
	Author=>'\@\@AUTHOR_NANAMI\@\@',
	Libs=>['-L../xslib -lxslib'],
);
