######################################################################
# Temp.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:51:01
#
# "Nana::Temp" ver 0.1 $$
# Author Nanami
# http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
package	Nana::Temp;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION @ISA @EXPORTER @EXPORT_OK);
$VERSION = '0.1';
@EXPORT_OK = qw(tempfile);

######################################################################

$Temp::Method=""
	if(!defined($Temp::Method));
$Temp::Loaded=0;
$Temp::DefaultTemplate="Pyuki-" . time . "-XXXXXXXXXXXXXXXXXXXXXXXX";

sub init {
	if(!$Temp::Loaded) {
		if($Temp::Method eq "") {
			foreach("File::Temp") {
				if(&load_module($_)) {
					$Temp::Method=$_;
				}
			}
		} else {
			foreach("File::Temp") {
				if($Temp::Method eq $_) {
					if(&load_module($_)) {
						$Temp::Method=$_;
					}
				}
			}
		}
	}
	$Temp::Loaded++;
}

sub tempfile {
	my (%hash)=@_;
	my $fh;
	my $fname;
	&init;
	if($Temp::Method eq "File::Temp") {
		if($hash{template} eq "") {
		($fh, $fname)=
			File::Temp::tempfile(
				$hash{template} eq ""
					? $Temp::DefaultTemplate
					: $hash{template},
				DIR => $hash{dir},
				SUFFIX => $hash{suffix});
		}
		return ($fh, $fname);
	} else {
		my $seed=$Temp::Loaded . $ENV{REMOTE_HOST} . $Temp::Loaded . $ENV{HTTP_USER_AGENT} . $Temp::Loaded . $ENV{HTTP_HOST} . $Temp::Loaded . $ENV{REQUEST_URL} . $Temp::Loaded . $ENV{QUERY_STRING} . $Temp::Loaded;
		my $sd;
		for(my $j = time; $j < time + 5; $j++) {
			for(my $l=time; $l < time + 30; $l++) {
				for(my $i=0; $i < length($seed); $i++) {
					$sd += chr(substr($seed, $i, 1)) + $j . length($sd) + $l;
				}
			}
			my $template=$hash{template};
			for(my $i=0; $template=~/X/; $i++) {
				$template=~s/X/@{[substr($sd, $i, 1)]}/;
			}
			my $tempfn="$hash{dir}/$sd$hash{suffix}";
			if(!-f $tempfn) {
				my $fh=&safe_open($tempfn, "w");
				return ($fh, $tempfn);
			}
		}
	}
}

sub load_module {
	my $funcp = $::functions{"load_module"};
	return &$funcp(@_);
}

1;
__END__

=head1 NAME

Nana::Temp - Temp filename generater

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/Temp.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/Temp.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/Temp.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/Temp.pm?view=log>

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
