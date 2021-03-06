/*
######################################################################
# xs_undbmname.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:21:56
#
# 
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
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
								? ((c) - 'V') \
							 : ((c) == '\n') \
								? (char)-3 \
							 : ((c) == '\0') \
								? (char)-2 \
								: (char)-1 \
						) \
					)

char	*xs_undbmname(char *dst, char *src) {
	char	*save = dst;
	register	char	c, t;

	for(;t = *src++;) {
		c = unhex(t);
		switch(c) {
			case	(char)-3:
				*dst++ = '\n';
				break;
			case	(char)-1:
				break;
			default:
				t = *src++;
				t = unhex(t);
				switch(t) {
					case	(char)-3:
						*dst++ = '\n';
						break;
					case	(char)-2:
						*dst='\0';
						return save;
					case	(char)-1:
						break;
					default:
						*dst++ = c * 0x10 + t;
				}
		}
	}
	*dst='\0';
	return save;
}
