######################################################################
# canonical.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:45:42
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'canonical.inc.cgi'
######################################################################

# canonical (url)
$canonical::url=""
	if(!defined($canonical::url));

# Initlize

sub plugin_canonical_init {
	my ($base, $canonicalflg)=&getbase;

	my $hgeader;
	if($canonicalflg && $::form{mypage} && $::form{cmd} eq "read") {
		my $url="$base" . &make_cookedurl($::form{mypage});
		$url=~s/\/\//\//g;
		$::IN_HEAD.=<<EOM;
<link rel="canonical" href="$url" />
EOM
	}
	return ('init'=>1);
}

sub getbase {
	&getbasehref;
	if($canonical::url=~/$::isurl/) {
		if(substr($canonical::url, 0, length($canonical::url)) ne substr($::basehref, 0, length($canonical::url))) {
			if($::IN_HEAD!~/rel="canonical"/) {
				return ($canonical::url, 1);
			}
		}
	}
	return ($::basehref, 0);
}

1;
__DATA__
sub plugin_canonical_setup {
	return(
		ja=>'検索エンジンに対して重複URLのオリジナルを指定する',
		en=>'Identify the original of duplicate URL to search engines',
		override=>'none',
		require=>'',
		url'=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/canonical/'
	);
}
__END__
=head1 NAME

canonical.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

Identify the original of duplicate URL to search engines

=head1 USAGE

rename to canonical.inc.cgi

setting $::canonical::url to original url

=head1 OVERRIDE

none

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/canonical

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/canonical/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/canonical.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/canonical.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/canonical.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/canonical.inc.pl?view=log>

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
