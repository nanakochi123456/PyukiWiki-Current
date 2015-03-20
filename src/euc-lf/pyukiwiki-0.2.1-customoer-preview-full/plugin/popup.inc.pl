######################################################################
# popup.inc.pl - This is PyukiWiki yet another Wiki clone
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
# Usage:
#
# #popup(, NG Page or URL, OK Button, NG Button, width, height)
# string...
# #popup
#
# #popup(OK Page, NG Page or URL, OK Button, NG Button, width, height)
# string...
# #popup
######################################################################
use strict;
$popup::okbutton;
$popup::ngbutton;
$popup::okmove;
$popup::ngmove;
$popup::w;
$popup::h;
sub plugin_popup_convert {
	my($okmove, $ngmove, $okbutton, $ngbutton, $w, $h)=split(/,/,shift);
	if($html::nofreezeexec eq 0) {
		return ' ' if(!&is_frozen($::form{mypage}));
	}
	$popup::okmove=$okmove;
	$popup::ngmove=$ngmove;
	$popup::okbutton=$okbutton;
	$popup::ngbutton=$ngbutton;
	$popup::w=$w;
	$popup::h=$h;
	$::linedata="";
	$::linesave=1;
	$::eom_string="#popup";
	$::exec_inlinefunc=\&plugin_popup_display;
	return ' '
}
sub plugin_popup_display {
	my($text)=@_;
	my $html=<<EOM;
@{[&text_to_html($text)]}
<form>
@{[&plugin_popup_link($popup::okmove, $popup::okbutton)]}
@{[&plugin_popup_link($popup::ngmove, $popup::ngbutton)]}
</form>
EOM
	$html=~s/[\r\n]//g;
$::IN_JSHEAD.=<<EOM;
PopupOpen('$html', '$::basehost', $popup::w, $popup::h);
EOM
	return ' ';
}
sub plugin_popup_link {
	my($link, $button)=@_;
	my $url=$link eq "" ? "" : $link=~/$::isurl/ ? $link : "$::basehref" . &make_cookedurl($link);
	return <<EOM;
<input type="button" value="$button" onclick="PopupClose(\\'$url\\');" onkeypress="PopupClose(\\'$url\\');" />
EOM
}
1;
__DATA__
sub plugin_popup_usage {
	return {
		name => 'popup',
		version => '1.0',
		type => 'convert',
		author => 'Nanami',
		syntax => '#popup(, NG Page or URL, OK Button, NG Button, width, height) to eom of #popup',
		description => 'popup with saved browser cookie',
		description_ja => 'cookieに保存して初回だけポップアップをする',
		example => '#popup(, NG Page or URL, OK Button, NG Button, width, height)',
	};
}
1;
__END__
