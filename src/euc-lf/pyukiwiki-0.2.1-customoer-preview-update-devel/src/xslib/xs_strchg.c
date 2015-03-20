/*
######################################################################
# xs_strchg.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:46:31
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

