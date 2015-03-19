######################################################################
# ck.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:09
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
# for linktrack.inc.cgi, logs.ini.cgi
######################################################################

use strict;
require "$::plugin_dir/counter.inc.pl";

sub plugin_ck_action {
	return if(!defined($linktrack::cgilink));

	my $lk=$::form{l};
	my $r=$::form{r};
	my $p=$::form{p};
	my $test=$lk;
	$test=~s/[0-9A-Z]?//g;
	if($test eq '') {
		my $url=&undbmname($lk);
		if($r eq "y") {
			print &http_header("Status: 204\n\n");
		} else {
			if($linktrack::refresh || $logs::refresh) {
				print &http_header("Content-type: text/html");
				print <<EOM;
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="$::lang">
<head>
<meta http-equiv="Content-Language" content="$::lang" />
<meta http-equiv="Content-Type" content="text/html; charset=$::charset" />
<meta http-equiv="Refresh" content="0;url=$url" />
</head>
<body>
&nbsp;
</body>
</html>
EOM
			} else {
				&location($url, 302);
			}
		}
		&plugin_counter_do("link\_$url","w");
		if($::_exec_plugined{logs}>1) {
			my $cmd="ck";
			my $page=&code_convert(\$::form{p}, $::defaultcode);
			my $link=&undbmname($::form{l});
			$page="$page<>$link";

			my $filename=&date("Y-m-d");
			&getremotehost;
			my $user=$::authadmin_cookie_user_name;
			my $logtxt=<<EOM;
$ENV{REMOTE_HOST} $ENV{REMOTE_ADDR}\t@{[&date($logs::date_format)]} @{[&date($logs::time_format)]}\t$user\t$ENV{REQUEST_METHOD}\t$cmd\t$::lang\t$page\t$ENV{HTTP_USER_AGENT}\t$ENV{HTTP_REFERER}
EOM
			&plugin_logs_add($filename, $logtxt);
		}
		exit;
	}
	print <<EOM;
Content-type: text/plain

Forbidden
EOM
exit;
}

1;
__END__

=head1 NAME

ck.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 ?cmd=ck&amp;lk=hex encoded url

=head1 DESCRIPTION

This plugin is explugin is count of tracking of linktrack.inc.cgi

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/ck

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/ck/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/ck.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/ck.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/ck.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/ck.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.sfjp.jp/>

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
