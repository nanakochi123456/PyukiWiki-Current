/*
######################################################################
# xs_strstr.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:21:57
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

#include "xslib.h"

char	*xs_strstr(const char *s, const char *find) {
	char c, sc;
	char chk;
	size_t len;
/*
	switch(strlen(find)) {
		case 1:
			chk=*find;
			for(; c = *s++;) {
				if(c == chk) {
					return ((char *)s);
				}
			}
			return NULL;


		case 2:
			chk=*find++;
			sc=*find;
			for(; c = *s++;) {
				if(c == chk) {
					if(*s == sc) {
						return ((char *)s);
					}
				}
			}
			return NULL;

	}
*/
	if ((c = *find++) != '\0') {
		len = strlen(find);
		do {
			do {
				if ((sc = *s++) == '\0')
					return (NULL);
			} while (sc != c);
		} while (strncmp(s, find, len) != 0);
		s--;
	}
	return ((char *)s);
}
