######################################################################
# ignoreoldbrowser.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:51:24
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
# This is extented plugin.
# To use this plugin, rename to 'ignoreoldbrowser.inc.cgi'
######################################################################

# Initlize											# comment

$ignoreoldbrowser::browser{msie}=6;
$ignoreoldbrowser::browser{firefox}=0;
$ignoreoldbrowser::browser{netscape}=-1;
$ignoreoldbrowser::browser{opera}=0;
$ignoreoldbrowser::browser{chrome}=0;
$ignoreoldbrowser::browser{safari}=3;

$ignoreoldbrowser::support{windows31}="";
$ignoreoldbrowser::support{windows9}="";
$ignoreoldbrowser::support{windowsnt3}="";
$ignoreoldbrowser::support{windowsnt4}="";

#$ignoreoldbrowser::support{windowsnt51}="";
$ignoreoldbrowser::support{windowsnt50}="firefox";
$ignoreoldbrowser::support{windowsnt51}="msie8,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt52}="msie8,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt60}="msie,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt61}="msie,firefox,chrome,opera";
$ignoreoldbrowser::support{windowsnt62}="msie,firefox,chrome,opera";

sub plugin_ignoreoldbrowser_init {
	my $title;
	my $ua=lc $ENV{HTTP_USER_AGENT};
	$ua=~s/[\s]//g;
	$os=$ua;
	$os=~s/[\.]//g;
	my $link;
	my $text="";

	foreach my $list(sort keys %ignoreoldbrowser::support) {
		if($os=~/$list/) {
			my $sup=$ignoreoldbrowser::support{$list};
			if($sup eq "") {
				$title=$::resource{ignoreoldbrowser_plugin_title_ignoreos};
				$text=$::resource{ignoreoldbrowser_plugin_ignoreos};
			} else {
				my $browser;
				my $ver;
				if($ua=~/opera\/(\d+)\.(\d+)/) {
					$browser="opera";
					$ver=$1;
				}
				if($ua=~/trident\/\d+.\d+; rv:(\d+).(\d+)/) {
					$browser="msie";
					$ver=$1;
				}
				if($ua=~/msie(\d+).(\d+)/) {
					$browser="msie";
					$ver=$1;
				}
				if($ua=~/firefox\/(\d+)\./) {
					$browser="firefox";
					$ver=$1;
				}
				if($ua=~/chrome\/(\d+)\./) {
					$browser="chrome";
					$ver=$1;
				}
				if($ua=~/version\/(\d+).+safari/) {
					$browser="safari";
					$ver=$1;
				}

				if($browser ne "") {
					if($ver <= $ignoreoldbrowser::browser{$browser}) {
					$title=$::resource{ignoreoldbrowser_plugin_title_notsupportbrowser};
					$text.=$::resource{ignoreoldbrowser_plugin_nosupportbrowser};
					foreach my $blist(split(/,/,$sup)) {
						$text.="[" . $::resource{"ignoreoldbrowser_plugin_" . $blist} . "]&nbsp;";
					}
				}
			}
		}
		if($title ne "") {
			$text=~s/\$wiki_title/$::wiki_title/g;
			my $html=$::resource{ignoreoldbrowser_plugin_html};
			$html=~s/\$title/$title/g;
			$html=~s/\$text/$text/g;

			print <<EOM;
Content-type: text/html

$html
EOM
			exit;
			}
		}
	}
	return ('init'=>0);
}

1;
__DATA__
sub plugin_ignoreoldbrowser_setup {
	return(
		ja=>'古いブラウザーでの表示を拒否する'.
		en=>'Ignore old browser',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/ignoreoldbrowser/'
	);
}
__END__

=head1 NAME

ignoreoldbrowser.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

If it is accessed through a browser is not compatible with the old PyukiWiki, forcing the screen plug-in that displays the browser update promotion.

=head1 DESCRIPTION

If it is accessed through a browser is not compatible with the old PyukiWiki, forcing the screen plug-in that displays the browser update promotion.

=head1 USAGE

rename to ignoreoldbrowser.inc.cgi

=head1 OVERRIDE

none

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/ignoreoldbrowser

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/ignoreoldbrowser/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/ignoreoldbrowser.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/ignoreoldbrowser.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/ignoreoldbrowser.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/ignoreoldbrowser.inc.pl?view=log>

=back

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
