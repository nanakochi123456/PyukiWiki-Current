/*
######################################################################
# xs_memalloc.c - This is PyukiWiki yet another Wiki clone
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

void	*xs_memalloc(int size) {
	return malloc((size_t)size);
}
