/*
######################################################################
# xs_memfree.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:53:32
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

void	xs_memfree(char *p) {
	free(p);
}
