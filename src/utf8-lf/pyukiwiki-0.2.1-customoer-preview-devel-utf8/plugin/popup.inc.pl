######################################################################
# popup.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:12:02
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

=head1 NAME

popup.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #popup(, NG Page or URL, OK Button, NG Button, width, height)
 wiki string
 wiki string
 ...
 #popup

=head1 DESCRIPTION

Display popup message with saving cookie control.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/popup

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/popup/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/popup.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/popup.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/popup.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/popup.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=head1 AUTHOR

=over 4

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2005-2015 by Nanami.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
