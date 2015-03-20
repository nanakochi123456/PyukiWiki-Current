######################################################################
# include.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:58:07
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1 add noinclude option
######################################################################

use strict;

$::includedpage;

sub plugin_include_inline {
	return &plugin_include_convert(@_);
}

sub plugin_include_convert {
	my ($arg)=@_;
	my(@opt)=split(/,/,$arg);
	my $notitle=0;
	my $noinclude=0;
	my $body;
	foreach(@opt) {
		$notitle=1 if(/notitle/);
		$noinclude=1 if(/noinclude/);
	}

	my $page = shift @opt;
	if($noinclude) {
		if($::includedpage eq "") {
			my $wiki;
			foreach(@opt) {
				next if(/noinclude/);
				$wiki.=$_;
			}
			$body = &text_to_html($wiki, toc=>1);
			return "$body";
		}
		return ' ';
	}

	if ($page eq '') { return ''; }
	my $body = '';
	if (&is_exist_page($page)) {
		if(&is_readable($page)) {
			$::includedpage=$::form{mypage};
			$::form{mypage}=$page;
			my $rawcontent = $::database{$page};
			$body = &text_to_html($rawcontent, toc=>1);
			$::form{mypage}=$::includedpage;
			$::includedpage="";
			my $cookedpage = &encode($page);
			my $link = "<a href=\"$::script?$cookedpage\">$page</a>";
			if ($::form{mypage} eq $::MenuBar) {
				$body = <<"EOD";
<span align="center"><h5 class="side_label">$link</h5></span>
<small>$body</small>
EOD
			} else {
				if($notitle eq 0) {
					$body = "<h1>$link</h1>\n$body\n";
				}
			}
		} else {
			return ' ';
		}
	}
	return $body;
}
1;
__END__

=head1 NAME

include.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #include(wikipage[,notitle])

=head1 DESCRIPTION

Include WikiPage

=head1 USAGE

=over 4

=item notitle

Disable display page title of included page

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/include

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/include/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/include.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/include.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/include.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/include.inc.pl?view=log>

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
