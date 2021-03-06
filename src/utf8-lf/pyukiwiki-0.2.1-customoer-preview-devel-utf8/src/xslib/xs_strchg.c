/*
######################################################################
# xs_strchg.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:10:58
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

/* http://www.grapecity.com/tools/support/powernews/column/clang/049/page03.htm */

char	*xs_strchg(char *buf, const char *str1, const char *str2) {
	char *tmp;
	char *p;

	tmp=malloc(
		strlen(buf) + strlen(str1) + strlen(str2));

	while ((p = xs_strstr(buf, str1)) != NULL) {
		*p = '\0';
		p += strlen(str1);
		strcpy(tmp, p);
		strcat(buf, str2);
		strcat(buf, tmp);
	}
	free(tmp);
}

