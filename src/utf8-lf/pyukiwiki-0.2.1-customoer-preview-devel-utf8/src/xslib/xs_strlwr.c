/*
######################################################################
# xs_strlwr.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:10:59
#
# 
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
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
