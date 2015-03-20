/*
######################################################################
# xs_encode.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:46:30
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

#define	hexc(c)	((((c) < 10) ? ((c) + '0') : ((c) + 'W')))

char	*xs_encode(char *dst, char *src) {
	char	*save = dst;
	register	char	c;

	for(; c = *src++;) {
		if(c == 0x20) {
			*dst++ = '+';
		} else if(c <= 0x2f) {
			*dst++ = '%';
			*dst++ = hexc((c) / 16);
			*dst++ = hexc((c) % 16);
		} else if(c <= 0x39) {
			*dst++ = c;
		} else if(c <= 0x40) {
			*dst++ = '%';
			*dst++ = hexc((c) / 16);
			*dst++ = hexc((c) % 16);
		} else if(c <= 0x5a || c == 0x5f) {
			*dst++ = c;
		} else if(c <= 0x60) {
			*dst++ = '%';
			*dst++ = hexc((c) / 16);
			*dst++ = hexc((c) % 16);
		} else if(c <= 0x7a) {
			*dst++ = c;
		} else {
			*dst++ = '%';
			*dst++ = hexc((c) / 16);
			*dst++ = hexc((c) % 16);
		}
	}
	*dst='\0';
	return save;
}
