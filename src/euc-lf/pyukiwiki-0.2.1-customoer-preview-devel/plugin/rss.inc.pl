######################################################################
# rss.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:21:19
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 2012/09/28 RSS2.0、ATOMのサポート
# v0.1.7 2006/05/19 RSSタイトルが化けるのを修正
# v0.1.6 2006/01/07 include Yuki::RSS, 半角スペースのページに対応
# v0.0.2 2005/03/11 Add dc:date
######################################################################

use Nana::RSS;

sub plugin_rss_date {
	my($dt, $tm)=@_;
	$gmt=&gettz;
	my $date = $dt . "T" . $tm . sprintf("+%02d:00", $gmt);
	$date;
}

sub plugin_rss_action {
$::rss_description_line=5;
	# 言語別の設定										# comment
	if($::_exec_plugined{lang} > 1) {
		$::modifier_rss_title=$::modifier_rss_title{$::lang} if($::modifier_rss_title{$::lang} ne '');
		$::modifier_rss_link=$::modifier_rss_link{$::lang} ne '' ? $::modifier_rss_link{$::lang}: $::modifier_rss_link ne '' ? $::modifier_rss_link : $::basehref;
		$::modifier_rss_description=$::modifier_rss_description{$::lang} if($::modifier_rss_description{$::lang} ne '');
	} else {
		$::modifier_rss_link=$::modifier_rss_link ne '' ? $::modifier_rss_link : $::basehref;
	}

	my $version=$::form{ver};
	$version="1.0" if($version eq "");

	my $rss = new Nana::RSS(
		version => $version,
		encoding => $::charset,
	);
	my $recentchanges = $::database{$::RecentChanges};
	my $count = 0;
	my $lastdate;
	foreach (split(/\n/, $recentchanges)) {
		last if ($count >= $::rss_lines);
		# v0.1.6
		/^\- (\d\d\d\d\-\d\d\-\d\d) \(...\) (\d\d:\d\d:\d\d) (.*?)\ \ \-/;    # data format.
		my $title = &unarmor_name($3);
		my $escaped_title = &escape($title);
		my $link = $modifier_rss_link . '?' . &encode($title);
		my $description;
		if($::rss_description_line <= 1) {
			$description = $escaped_title . &escape(&get_subjectline($title, $::rss_description_line));
		} else {
#			my $tmp=&get_subjectline($title,$::rss_description_line);
#			$tmp=~s/\n/<br \/>\n/g;
#			$description = qq(<![CDATA[) .$tmp . qq(]]>);
			$description=&get_subjectline($title,$::rss_description_line);
		}
		my $date=&plugin_rss_date($1,$2);
		$lastdate=$lastdate > $date ? $lastdate : $date;

		if(&is_readable($title) && $title!~/$::non_list/) {
			$rss->add_item(
				title => $escaped_title,
				link  => $link,
				description => $description,
				dc_date => $date
			);
			$count++;
		}
	}

	$rss->channel(
		title => $::modifier_rss_title
				. ($::_exec_plugined{lang} > 1 ? "(" . (split(/,/,$::langlist{$::lang}))[0] . ")" : ""),
		link  => $::modifier_rss_link,
		description => $::modifier_rss_description,
		language => $::lang,
		lastBuildDate => $lastdate,
		basehref => $::basehref,
		wikititle => $::wiki_title,
	);

	# print RSS information (as XML).						# comment
	my $body=$rss->as_string;
	if($::lang eq 'ja' && $::defaultcode ne $::kanjicode) {
		$body=&code_convert(\$body,   $::kanjicode);
	}
	print &http_header(
		"Content-type: text/xml; charset=$::charset", $::HTTP_HEADER);
	&compress_output($body . &exec_explugin_last);
	&close_db;
	exit;
}
1;
__END__

=head1 NAME

rss.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 ?cmd=rss&ver=1.0|2.0|atom[&lang=lang]

=head1 DESCRIPTION

Output RSS (RDF Site Summary) 1.0 / RSS2.0 / ATOM from RecentChanges

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/rss

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/rss/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/rss.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/rss.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/rss.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/rss.inc.pl?view=log>

=back

=head1 AUTHOR

=item Nanami

L<http://nano.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=head1 LICENSE

(C)2005-2015 by Nanami.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
