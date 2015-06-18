######################################################################
# HTTPCompress.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:00:23
#
# "Nana::HTTPCompress" ver 0.2 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package	Nana::HTTPCompress;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.2';

use Nana::ServerInfo;

######################################################################
# multicore gzip tips: http://www.submit.ne.jp/1500			# comment

$gzip::path;
$gzip::header;

sub init {
	my($path)=@_;
	my $info=new Nana::ServerInfo;

	my $pigz_command='pigz';
	my $gzip_command='gzip';
	my $execpath="/usr/local/bin:/usr/bin:/bin:$ENV{PATH}";

	if($path eq 'nouse') {
		$path='';
	} elsif($path eq '') {
		my $forceflag="";
		my $fastflag="";
		foreach(split(/:/,$execpath)) {
			if(-x "$_/$gzip_command") {
				$path="$_/$gzip_command" ;
				if(open(PIPE,"$path --help 2>&1|")) {
					foreach(<PIPE>) {
						$forceflag="--force" if(/(\-\-force)/);
						$fastflag="--fast" if(/(\-\-fast)/);
					}
					close(PIPE);
				}
			}
		}
		foreach(split(/:/,$execpath)) {
			if(-x "$_/$pigz_command" && $info->core > 3) {
				$path="$_/$pigz_command" ;
				if(open(PIPE,"$path --help 2>&1|")) {
					foreach(<PIPE>) {
						$forceflag="--force" if(/(\-\-force)/);
						$fastflag="--fast" if(/(\-\-fast)/);
					}
					close(PIPE);
				}
			}
		}
		if($path ne '') {
			$gzip::path="$path $fastflag $forceflag";
			$::debug.="auto detect gzip path : \"$gzip::path\"\n";
		} elsif(&load_module("Compress::Zlib")) {
			$gzip::path="zlib";
			$::debug.="auto detect Compress::Zlib";
		}
	}

	if ($path ne '') {
		$gzip::path=$path;
		if(($ENV{'HTTP_ACCEPT_ENCODING'}=~/gzip/)) {
			if($ENV{'HTTP_ACCEPT_ENCODING'}=~/x-gzip/) {
				$gzip::header="Content-Encoding: x-gzip\n";
			} else {
				$gzip::header="Content-Encoding: gzip\n";
			}
			return $gzip::header;
		}
	}
}

sub output {
	my ($data)=shift;
	if ($gzip::header ne '') {
		if($gzip::path eq "zlib") {
			binmode(STDOUT);
			my $compress_data=Compress::Zlib::memGzip ($data);
			print $compress_data;
		} else {
			binmode(STDOUT);
			open(STDOUT,"| $gzip::path");
			print $data;
		}
	} else {
		print $data;
	}
	close(STDOUT);
}
1;
__END__

=head1 NAME

Nana::HTTPCompress - HTTP compress module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/HTTPCompress.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/HTTPCompress.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/HTTPCompress.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/HTTPCompress.pm?view=log>

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
