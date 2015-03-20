/*
######################################################################
# xslib.h - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:55:49
#
# 
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
*/

#ifndef	XSLIB_H
#define	XSLIB_H

#include "xsinclude.h"
#include "xsdef.h"
#include "xsversion.h"
#include "xsbuild.h"

#ifdef	XS
	#include "EXTERN.h"
	#include "perl.h"
	#include "XSUB.h"
	#include "../xsmake/ppport.h"
#endif

#define xs_isupper(c) \
		('A' <= (c) && (c) <= 'Z')
#define xs_islower(c) \
		('a' <= (c) && (c) <= 'z')
#define xs_isdigit(c) \
		('0' <= (c) && (c) <= '9')
#define	xs_isxdigita(c) \
		('a' <= (c) && (c) <= 'f')
#define	xs_isxdigitb(c) \
		('A' <= (c) && (c) <= 'F')
#define	xs_isxdigit(c) \
		(xs_isdigit(c) || xs_isxdigita(c) || xs_isxdigitb(c))
#define xs_isspace(c) \
		((c) == ' ' || '\t' <= (c) && (c) <= '\r')
#define xs_iscntrl(c) \
		((c) < ' ' || (c) == '\177')
#define xs_isalpha(c) \
		(xs_isupper(c) || xs_islower(c))
#define	xs_isalnum(c) \
		(xs_isalpha(c) || xs_isdigit(c))
#define	xs_toupper(c) \
		(xs_islower(c) ? (c) - 0x20 : (c))
#define	xs_tolower(c) \
		(xs_isupper(c) ? (c) + 0x20 : (c))

#define	STR_TMPLENGTH_10000	(sizeof(char) * 10000)
#define	STR_TMPLENGTH_1000	(sizeof(char) * 1000)
#define	STR_TMPLENGTH_100	(sizeof(char) * 100)

#endif
