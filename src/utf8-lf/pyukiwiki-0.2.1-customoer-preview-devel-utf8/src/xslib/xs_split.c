/*
######################################################################
# xs_split.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:53:33
#
# 
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
*/

#include "xslib.h"

char	*xs_split(char *buf, char *split, char *src, int n) {
	char	*pt;
	int		i;

	strcpy(buf, src);

	pt = strtok(buf, split);
	if(pt == NULL) {
		return src;
	}
	if(n == 0) {
		return pt;
	}

	for(i = 1; (pt = strtok(NULL, split)) != NULL && i < n; i++);

	return pt;
}
