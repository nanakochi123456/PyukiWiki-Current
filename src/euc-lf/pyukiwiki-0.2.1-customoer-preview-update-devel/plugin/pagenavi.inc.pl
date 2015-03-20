######################################################################
# pagenavi.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:46:01
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
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

=head1 NAME

pagenavi.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #pagenavi(string, string, string...)

=head1 DESCRIPTION

The near number of visiters referred to now is displayed.

=head1 USAGE

=over 4

=item Makes link from upper layer to this page

 PyukiWiki/Glossary>Yougo/About PyukiWiki>PyukiWiki

It's write, convert to ...

 [[PyukiWiki]]/[[Glossary>PyukiWiki/Yougo]]/[[About PyukiWiki>PyukiWiki/Yougo/PyukiWiki]]

=item Others

Others are described by the usual Wiki grammar. After combining all parameters, it is changed into HTML with a text_to_html function.

=item Example

 #pagenavi(*,PyukiWiki/PyukiWiki Download>Download,!)
 #pagenavi(-Reference:,TOP>FrontPage/Glossary>Yougo>PyukiWiki)

=item Convenient usage

As a template of newpage.inc.pl, edit.inc.pl,
it is setting $::new_refer of pyukiwiki.ini.cgi.
It is convenient if you set it as a variable.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/pagenavi

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/pagenavi/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/pagenavi.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/pagenavi.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/pagenavi.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/pagenavi.inc.pl?view=log>

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
