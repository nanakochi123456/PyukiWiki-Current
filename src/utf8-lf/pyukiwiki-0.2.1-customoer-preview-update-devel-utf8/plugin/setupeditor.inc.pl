######################################################################
# setupeditor.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:23:03
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
use strict;

$setupeditor::error="";

sub plugin_setupeditor_action {
	my $body;
	my $upperlist;
	my %pageinfo;
	&load_wiki_module("auth");
	my %auth=&authadminpassword("submit");
	return('msg'=>"\t$::resource{setupeditor_plugin_title}",'body'=>$auth{html})
		if($auth{authed} eq 0);

	my $setup;
	my $org;
	my $backup;
	my %setuppath;
	my %backuppath;
	my %orgpath;
	my %setupfile;
	$setuppath{setup}=$::setup_file;
	$setupfile{setup}=$setuppath{setup};
	$setupfile{setup}=~s/.*\///g;
	$backuppath{setup}=$::setup_file;
	$backuppath{setup}=~s/\.cgi/\.bak\.cgi/g;
	$orgpath{setup}=$::ini_file;

	$setuppath{ngwords}=$::ngwords_file;
	$setupfile{ngwords}=$setuppath{ngwords};
	$setupfile{ngwords}=~s/.*\///g;
	$backuppath{ngwords}=$::ngwords_file;
	$backuppath{ngwords}=~s/\.cgi/\.bak\.cgi/g;
	$orgpath{ngwords}=$::ngwords;

	my $status;
	my $adminmailbody;

	my $f=$::form{ff};
	$f="setup" if(!-r $orgpath{$f});

	if($::form{exec} ne '') {
		my $test=$::form{mymsg};
		$test=~s/\x0D\x0A|\x0D|\x0A/\x0A/g;
		if(!&syntaxcheck($test)) {
			unlink($backuppath{$f});
			rename($setuppath{$f},$backuppath{$f});
			if($::form{mymsg} eq '') {
				$status=qq(<span class="error">$::resource{setupeditor_plugin_deleted}</span><hr />);
				&send_mail_to_admin($f,$::mail_head{setupdel},"");
			} else {
				open(W,">$setuppath{$f}") || &print_error("$setuppath{$f} can't write");
				foreach(split(/\n/,$::form{mymsg})) {
					s/\x0D\x0A|\x0D|\x0A/\x0A/g;
					print W $_;
				}
				close(W);
				$status=qq(<span class="error">$::resource{setupeditor_plugin_edited}</span><hr />);

				$adminmailbody=$::form{mymsg};
				$adminmailbody=~s/\x0D\x0A|\x0D|\x0A/\x0A/g;
				&send_mail_to_admin($f,$::mail_head{setupedit},$adminmailbody);
			}
		} else {
			my $msg=$::resource{setupeditor_plugin_syntaxerror};
			$msg=~s/\$1/$setupeditor::error/g;
			$status=qq(<span class="error">$msg</span><hr />);
		}
	}

	if(open(R,"$setuppath{$f}")) {
		foreach(<R>) {
			s/\x0D\x0A|\x0D|\x0A/\x0A/g;
			$setup.=$_;
		}
		close(R);
	}
	if(open(R,"$backuppath{$f}")) {
		foreach(<R>) {
			s/\x0D\x0A|\x0D|\x0A/\x0A/g;
			$backup.=$_;
		}
		close(R);
	}
	if(open(R,"$orgpath{$f}")) {
		foreach(<R>) {
			s/\x0D\x0A|\x0D|\x0A/\x0A/g;
			$org.=$_;
		}
		close(R);
	} else {
		&print_error("$orgpath{$f} can't read");
	}
	$body.=<<EOM;
$status
<h2>$setupfile{$f}</h2>
[<a href="$::script?cmd=setupeditor&amp;ff=setup">$setupfile{setup}</a>]
[<a href="$::script?cmd=setupeditor&amp;ff=ngwords">$setupfile{ngwords}</a>]
<form action="$::script" method="post" name="edit">
<input type="hidden" name="ff" value="$f" />
<input type="hidden" name="cmd" value="setupeditor" />
$auth{html}
<h3>$::resource{setupeditor_plugin_edit}</h3>
<textarea cols="$::cols" rows="$::rows" name="mymsg">@{[&htmlspecialchars($setup)]}</textarea>
<br />
<input type="submit" name="exec" value="$::resource{setupeditor_plugin_submit}" />
</form>
<hr />
<h3>$::resource{setupeditor_plugin_backup}</h3>
<textarea cols="$::cols" rows="$::rows" name="backup">@{[&htmlspecialchars($backup)]}</textarea>
<hr />
<h3>$::resource{setupeditor_plugin_org}</h3>
<textarea cols="$::cols" rows="$::rows" name="original">@{[&htmlspecialchars($org)]}</textarea>
EOM
	return('msg'=>"\t$::resource{setupeditor_plugin_title}",'body'=>$body);
}

sub perlpath {
	my $perlpath;
	if(open(R,"$0")) {
		$perlpath=<R>;
		close(R);
		$perlpath=~s/#!//g;
		$perlpath=~s/-//g;
		$perlpath=~s/ //g;
		$perlpath=~s/[\r\n]//g;
		$perlpath;
	}
}

sub syntaxcheck {
	my ($s)=@_;
	my $perlpath=&perlpath;
	return 0 if($s eq "");
	if(open(PIPE, "|$perlpath -c")) {
		print PIPE $s;
		close(PIPE);
		if($? eq 0) {
			return 0;
		}
	}
	$setupeditor::error=$@;
	return 1;
}

1;
__END__

=head1 NAME

setupeditor.inc.pl - PyukiWiki Administrator's Plugin

=head1 SYNOPSIS

 ?cmd=setupeditor

=head1 DESCRIPTION

info/setup.ini.cgi Editor.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Admin/setupeditor

L<http://pyukiwiki.info/PyukiWiki/Plugin/Admin/setupeditor/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/setupeditor.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/setupeditor.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/setupeditor.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/setupeditor.inc.pl?view=log>

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
