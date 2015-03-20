######################################################################
# backlink.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
sub plugin_backlink_inline {
	return plugin_backlink_convert(@_);
}
sub plugin_backlink_convert {
	my $mypage=$::form{mypage};
	my @pages=split(/$::separator/,$mypage);
	my $buf;
	my $backpage;
	foreach(@pages) {
		if($backpage eq "") {
			$backpage=$buf;
		} else {
			$backpage="$backpage$::separator$buf";
		}
		$buf=$_;
	}
	my $msg=$::resource{backlink_msg};
	$backpage=$::FrontPage if($backpage eq "");
	$msg=~s/\$1/$backpage/g;
	$body=qq(<a href="@{[&make_cookedurl(&encode($backpage))]}" title="$msg">$msg</a>);
	return $body;
}
1;
__DATA__
sub plugin_backlink_usage {
	return {
		name => 'backlink',
		version => '1.0',
		type => 'convert,inline',
		author => 'Nanami',
		syntax => '#backlink\n&backlink;',
		description => 'To create a link back to the wiki of the upper hierarchy.',
		description_ja => '上層の階層のwikiへ戻るリンクを作成する。',
		example => '#backlink',
	};
}
1;
__END__
