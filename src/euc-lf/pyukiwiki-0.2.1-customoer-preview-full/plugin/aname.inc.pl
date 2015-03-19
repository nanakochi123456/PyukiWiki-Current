######################################################################
# aname.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
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
