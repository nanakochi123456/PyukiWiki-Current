/*
######################################################################
# xs_version.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:50
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

char	*xs_version() {
	return XS_PYUKIWIKI_VERSION;
}

int		xs_versionnumber() {
	return XS_PYUKIWIKI_VERSIONNUMBER;
}

int		xs_buildnumber() {
	return XS_PYUKIWIKI_BUILDNUMBER;
}

char	*xs_build() {
	return XS_PYUKIWIKI_BUILD;
}

char	*xs_type() {
	return XS_PYUKIWIKI_TYPE;
}
