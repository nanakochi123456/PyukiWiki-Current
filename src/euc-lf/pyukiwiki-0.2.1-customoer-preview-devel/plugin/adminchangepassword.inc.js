/*/////////////////////////////////////////////////////////////////////
# adminchangepassword.inc.js - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:44:18
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

function ViewPassForm(id,mode){
	var	obj,
		block="block",
		none="none";

	if(d.all || d.getElementById){	//IE4, NN6 or later
		if(d.all){
			obj = d.all(id).style;
		}else if(d.getElementById){
			obj = d.getElementById(id).style;
		}
		if(mode == "view") {
			obj.display = block;
		} else if(mode == none) {
			obj.display = none;
		} else if(obj.display == block){
			obj.display = none;		//hidden
		}else if(obj.display == none){
			obj.display = block;		//view
		}
	}
}
