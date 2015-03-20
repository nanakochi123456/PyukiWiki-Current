######################################################################
# lookup.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
sub plugin_lookup_convert {
	my @args = split(/,/, shift);
	my $iwn = &htmlspecialchars(&trim($args[0]));
	my $btn = &htmlspecialchars(&trim($args[1]));
	$btn="LookUp" if($btn eq '');	# v0.1.6
	my $default = '';
	if (@args > 2) {
		$default = &htmlspecialchars(trim($args[2]));
	}
	my $s_page = &htmlspecialchars($::form{mypage});
	my $popup_allow=$::setting_cookie{popup} ne '' ? $::setting_cookie{popup}
					: $::use_popup ? 1 : 0;
	my $ret;
	if($::is_xhtml) {
		$ret=<<EOD;
 <div>
  <form action="$::script" method="post"@{[$popup_allow eq 1 ? qq( onsubmit="this.target='_blank'") : '']}>
EOD
	} else {
		$ret=<<EOD;
 <div>
  <form action="$::script" method="post"@{[$popup_allow eq 1 ? ' target="_blank"' : '']}>
EOD
	}
	$ret.=<<EOD;
  <input type="hidden" name="cmd" value="lookup" />
  <input type="hidden" name="inter" value="$iwn" />
  $iwn:
  <input type="text" name="page" size="30" value="$default" />
  <input type="submit" value="$btn" />
  </form>
 </div>
EOD
	return $ret;
}
sub plugin_lookup_action {
	my $text = &decode($::form{page});	# 入力テキスト		# comment
	$::form{inter}=~tr/A-Z/a-z/;
	my ($code, $uri) = %{$::interwiki2{$::form{inter}}};
	if ($uri) {	# pukiコンパチ								# comment
		if ($uri =~ /\$1/) {
			$uri =~ s/\$1/&interwiki_convert($code, $text)/e;
		} else {
			$uri .= &interwiki_convert($code, $text);
		}
	} else {	# yukiコンパチ								# comment
		$uri = $::interwiki{$::form{inter}};
		if ($uri) {
			$uri =~ s/\b(utf8|euc|sjis|ykwk|yw|asis)\(\$1\)/&interwiki_convert($1, $text)/e;
		}
	}
	if ($uri) {
		$uri=~s|&amp;|&|g;
		$uri=~s|&amp;|&|g;
		&location($uri, 302);
		exit;
	}
	return "";
}
1;
__END__
