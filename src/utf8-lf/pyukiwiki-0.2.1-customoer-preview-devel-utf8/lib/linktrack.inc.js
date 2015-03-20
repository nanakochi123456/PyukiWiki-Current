/*/////////////////////////////////////////////////////////////////////
# linktrack.inc.js - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:09:23
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
/////////////////////////////////////////////////////////////////////*/

// lk=this.href
// tg=b=_blank, r=right click

function Ck(lk,tg) {
	var	mypage, link,
		amp="&amp;", ck="?cmd=ck" + amp,
		valuep="p=", valuel="l=", u,
		d=document;

	mypage=hs('$::form{mypage}');
	link=hs(lk);

	var url=ck + p + mypage + amp + k + link;

	if(tg == 'r') {
		u=ck+ "r=y" + amp + valuep + mypage + amp + valuel + link;
		d.location=u;
		return true;
	} else if(tg != "") {
		ou(url, tg);
	} else {
		d.location=url;
	}
	return false;
}

function hs(str) {
	var ret="";
	for(var i=0; i < str.length; i++) {
		var chr=str.charCodeAt(i).toString(16).toUpperCase();
		ret=ret + chr;
	}
	return ret;
}
