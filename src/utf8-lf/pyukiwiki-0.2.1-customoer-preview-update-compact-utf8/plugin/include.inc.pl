######################################################################
# include.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
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
