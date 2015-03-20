######################################################################
# pagenavi.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:55:38
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
# 0.2.1 bugfix
######################################################################
sub plugin_pagenavi_inline {
	return plugin_pagenavi_convert(@_);
}
sub plugin_pagenavi_convert {
	my ($args) = @_;
	my @args = split(/,/, $args);
	my $tmp;
	my $body;
	foreach(@args) {
		if(/$::separator/) {
			$tmp="";
			my @pages=split(/$::separator/,$_);
			foreach(@pages) {
				my($name,$alias)=split(/>/,$_);
				$alias=$name if($alias eq '');
				$tmp.=$alias;
				$body.=qq([[$name>$tmp]]/);
				$tmp.=$::separator;
			}
			$body=~s/\/$//g;
		} else {
			$body.=$_;
		}
	}
	$body=&text_to_html($body);
	return $body;
}
1;
__END__
