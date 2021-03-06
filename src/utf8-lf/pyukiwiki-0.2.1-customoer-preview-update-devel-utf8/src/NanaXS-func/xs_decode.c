/*
######################################################################
# xs_decode.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:22:15
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

#include "../xslib/xslib.h"

#define	unhex(c)	( \
						( \
							(xs_isdigit(c)) \
							 ? ((c) - '0') \
							 : (xs_isxdigitb(c)) \
								? ((c) - '7') \
							 : (xs_isxdigita(c)) \
								? ((c) - 'W') \
								: -1 \
						) \
					)

char	*xs_decode(char *dst, char *src) {
	char	*save = dst;
	register	char	c, t;

	for(;t = *src++;) {
		if(t == '+') {
			*dst++ = ' ';
		} else if(t == '%') {
			t = *src++;
			c = unhex(t) * 0x10;
			if(c == -1) {
				return NULL;
			}
			t = *src++;
			c += unhex(t);
			if(c == -1) {
				return NULL;
			}
			*dst++ = c;
		} else {
			*dst++ = t;
		}
	}
	*dst='\0';
	return save;
}
