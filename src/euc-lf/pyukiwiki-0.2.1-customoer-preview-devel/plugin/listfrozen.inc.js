/*/////////////////////////////////////////////////////////////////////
# listfrozen.inc.js - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:44:26
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
/////////////////////////////////////////////////////////////////////*/

function allcheckbox(v) {
	var	f=d.getElementById("sel"),
		len=f.elements.length;

	for(i=0;i<len;i++) {
		l=f.elements[i];
		if(l.type == "checkbox") {
			if(v == 1) {
				if(!l.checked) {
					l.click();
				}
			} else {
				if(l.checked) {
					l.click();
				}
			}
		}
	}
}
