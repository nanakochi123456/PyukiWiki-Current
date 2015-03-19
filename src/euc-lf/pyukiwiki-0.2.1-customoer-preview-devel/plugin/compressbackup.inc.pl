######################################################################
# compressbackup.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:10
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

sub plugin_compressbackup_action {
	my @convertdirs=(
		"$::backup_dir",
	);

	&load_wiki_module("auth");
	%::auth=&authadminpassword(submit);
	return('msg'=>"\t$::resource{compressbackup_plugin_title}",'body'=>$auth{html})
		if($auth{authed} eq 0);

	if($::form{confirm} eq '') {
		$body=<<EOM;
<form action="$::script" method="POST">
$auth{html}
<input type="hidden" name="cmd" value="compressbackup" />
$::resource{compressbackup_pluin_convert}<br />
<input type="submit" name="confirm" value="$::resource{compressbackup_pluin_convert_yes}" />
</form>
EOM
		return('msg'=>"\t$::resource{compressbackup_plugin_title}"
			  ,'body'=>"$body");
	}

	# compress backup
	&open_backup;
	foreach my $page (sort keys %::database) {
		my $backuptext=$::backupbase{$page};
		if($backuptext ne '') {
			$::backupbase{$page}=$backuptext;
		}
	}
	&close_backup;
	return('msg'=>"\t$::resource{compressbackup_plugin_title}"
		  ,'body'=>"$::resource{compressbackup_pluin_converted}<hr />$body");
}

1;
__END__

=head1 NAME

compressbackup.inc.pl - PyukiWiki Administrator's Plugin

=head1 SYNOPSIS

 ?cmd=compressbackup

=head1 DESCRIPTION

Compress Backup Directory

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Admin/compressbackup

L<http://pyukiwiki.info/PyukiWiki/Plugin/Admin/compressbackup/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/compressbackup.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/compressbackup.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/compressbackup.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/compressbackup.inc.pl?view=log>

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
