######################################################################
# env.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:57:54
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

use strict;

######################################################################

sub plugin_env_convert {
	&plugin_env_inline(@_);
}

sub plugin_env_inline {
	my($env, $regex, $page)=split(/,/,shift);
	return ' ' if(!&is_frozen($::form{mypage}));

	if(lc $regex eq "view") {
		return $ENV{$env};
	}

	if($::ENV{$env}=~/$regex/i) {
		return &text_to_html($::database{$page});
	}
	return " ";
}

1;
__END__

=head1 NAME

env.inc.pl - PyukiWiki ExPlugin

=head1 SYNOPSIS

 &env(Environment, Regex, Display Wiki Format);

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/env

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/env/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/env.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/env.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/env.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/env.inc.pl?view=log>

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
