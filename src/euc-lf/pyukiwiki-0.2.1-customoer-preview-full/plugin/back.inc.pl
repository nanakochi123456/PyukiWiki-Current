######################################################################
# back.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
$back::allowpagelink=0
	if(!defined($back::allowpagelink));
$back::allowjavascript=1
	if(!defined($back::allowjavascript));
$back::blacket=1
	if(!defined($back::blacket));
######################################################################
use strict;
$::back::count;
sub plugin_back_convert {
	my($str,$align,$hr,$link)=split(/,/,shift);
	my $body;
	$str=$::resource{backbutton} if($str eq '');
	$align="center" if($align eq '');
	if($hr+0 eq 0) {
		$hr="";
	} else {
		$hr=qq(<hr class="full_hr" />\n);
	}
	if($back::allowpagelink eq 0) {
		$link="";
	} elsif($link!~/$::isurl/) {
		$link = &make_cookedurl(&encode($link));
	}
	if($link eq "") {
		if($back::allowjavascript eq 1) {
			$::back::count+=0;
			$::back::count++;
			$body=<<EOM;
<span id="back_$::back::count"></span>
<script type="text/javascript"><!--
//--></script>
<noscript>
$hr
<div align="$align">
@{[$back::blacket eq 1 ? '[' : '']}<a href="$ENV{HTTP_REFERER}" title="$str">$str</a>@{[$back::blacket eq 1 ? ']' : '']}
</div>
</noscript>
EOM
			$::IN_JSHEAD.=<<EOM;
if(history.length!=0){sinss("back_$::back::count",'$hr<div align="$align">@{[$back::blacket eq 1 ? '[' : '']}<a href="javascript:history.go(-1)" title="$str">$str</a>@{[$back::blacket eq 1 ? ']' : '']}</div>';}
EOM
		} elsif($ENV{HTTP_REFERER} ne '') {
			$body=<<EOM;
$hr
<div align="$align">
@{[$back::blacket eq 1 ? '[' : '']}<a href="$ENV{HTTP_REFERER}" title="$str">$str</a>@{[$back::blacket eq 1 ? ']' : '']}
</div>
EOM
		} else {
			$body=" ";
		}
	} else {
		$body=<<EOM;
$hr
<div align="$align">
<a href="$link" title="$str">$str</a>
</div>
EOM
	}
	return $body;
}
1;
__DATA__
sub plugin_back_usage {
	return {
		name => 'back',
		version => '2.0',
		type => 'convert',
		author => 'Nanami',
		syntax => '#back(Display String [,left|center|right] [,0|1],[Back to link])',
		description => 'The link to a return place is installed in the specified position.',
		description_ja => '指定した位置に戻り先へのリンクを設置します。',
		example => '#back\n?#back(BACK,left)',
	};
}
1;
__END__
