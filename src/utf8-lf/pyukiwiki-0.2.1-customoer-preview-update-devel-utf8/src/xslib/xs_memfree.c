/*
######################################################################
# xs_memfree.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:27:49
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
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
*/

#include "xslib.h"

void	xs_memfree(char *p) {
	free(p);
}
