/*
######################################################################
# xs_dbmname.c - This is PyukiWiki yet another Wiki clone
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
*/

#include "../xslib/xslib.h"

#define	hexc(c)	((((c) < 10) ? ((c) + '0') : ((c) + '7')))

char	*xs_dbmname(char *dst, char *src) {
	char	*save = dst;
	register	char	c;

	for(; c = *src++;) {
		*dst++ = hexc((c) / 16);
		*dst++ = hexc((c) % 16);
	}
	*dst='\0';
	return save;
}
