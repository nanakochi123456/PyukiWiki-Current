######################################################################
# aname.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:45:49
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################

sub plugin_aname_inline {
	return &plugin_aname_convert(@_);
}

sub plugin_aname_convert {
	return '' if (@_ < 1);	# no param
	my @args = split(/,/, shift);
	my $id = shift(@args);
	return false if (!($id =~ /^[A-Za-z][\w\-]*$/));

	my $body = '';
	if (@args) {
		$body = pop(@args);
		$body =~ s/<\/?a[^>]*>//;
	}
	my $class = 'anchor';
	my $url = '';
	my $attr_id = " id=\"$id\"";

	foreach (@args) {
		if (/super/) {
			$class = 'anchor_super';
		}
		if (/full/) {
#			$url = "$::script?".rawurlencode($vars['page']);
			$url = &make_cookedurl(&encode($page));0
		}
		if (/noid/) {
			$attr_id = '';
		}
	}
	return "<a class=\"$class\"$attr_id href=\"$url#$id\" title=\"$id\">$body</a>";
}

1;
__DATA__

sub plugin_aname_usage {
	return {
		name => 'aname',
		version => '1.0',
		type => 'inline,convert',
		author => 'Nekyo',
		syntax => '&aname(anchor name [,{[super], [full], [noid]}] ){ anchor string };\n#aname(anchor name [,{[super], [full], [noid]}, anchor string] )',
		description => 'An anchor link, set as the position.',
		description_ja => '指定した位置にアンカー(リンクの飛び先)を設定します。
',
		example => '#aname(aliasname,full,anchor)',
	};
}

1;
__END__

=head1 NAME

aname.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 &aname(anchor name [,{[super], [full], [noid]}] ){ anchor string };
 #aname(anchor name [,{[super], [full], [noid]}, anchor string] )',

=head1 DESCRIPTION

An anchor link, set as the position.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/aname

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/aname/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/aname.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/aname.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/aname.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/aname.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2004-2007 by Nekyo.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
