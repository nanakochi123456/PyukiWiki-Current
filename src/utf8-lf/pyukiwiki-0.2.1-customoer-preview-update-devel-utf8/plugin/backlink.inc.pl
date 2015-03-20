######################################################################
# backlink.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:57:15
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

=head1 NAME

backlink.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 &backlink;

=head1 DESCRIPTION

To create a link back to the wiki of the upper hierarchy.

If there is no upper layer of the hierarchy of wiki, it does not make sense.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/backlink

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/backlink/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/backlink.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/backlink.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/backlink.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/backlink.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nano.daiba.cx/> etc...

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
