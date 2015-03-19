/*
######################################################################
# xs_strlwr.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:59:00
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
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
*/

#include "xslib.h"

char	*xs_strlwr(char *s) {
	char	*str=s;
	char	c;

	for(; (c = *str); str++) {
		*str=xs_tolower(c);
	}
	return s;
}
