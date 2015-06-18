/*
######################################################################
# xs_version.c - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:22:31
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
