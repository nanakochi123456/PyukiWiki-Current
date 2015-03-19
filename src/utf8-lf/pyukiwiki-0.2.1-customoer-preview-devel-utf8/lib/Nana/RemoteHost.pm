######################################################################
# RemoteHost.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:50:59
#
# "Nana::RemoteHost" ver 0.1 $$
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

package	Nana::RemoteHost;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.1';

######################################################################

$Nana::RemoteHost::Execed=0;
sub get {
	return if($Nana::RemoteHost::Execed eq 1);

	$Nana::RemoteHost::Execed=1;

	# from http://www.alib.jp/perl/resolv.html#nocompact	# comment
	# and  http://www2u.biglobe.ne.jp/MAS/perl/waza/dns.html#nocompact	# comment

	if($ENV{REMOTE_HOST} eq '' || $ENV{REMOTE_ADDR} eq $ENV{REMOTE_HOST}) {#nocompact
		my $addr=$ENV{REMOTE_ADDR};#nocompact
		my $ipv4addr;#nocompact
		my $ipv6addr;#nocompact
		if($addr=~/^(?:::(?:f{4}:)?)?((?:0*(?:2[0-4]\d|25[0-5]|[01]?\d\d|\d)\.){3}0*(?:2[0-4]\d|25[0-5]|[01]?\d\d|\d)|(?:\d+))$/) {#nocompact
			$ipv4addr=$1;#nocompact
			$ENV{REMOTE_ADDR}="$ipv4addr";#nocompact
		} elsif($addr=~/:/) {#nocompact
			$ipv6addr=$addr;#nocompact
			$ENV{REMOTE_ADDR}="$ipv6addr";#nocompact
		} else {#nocompact
			$ipv4addr=$addr;#nocompact
			$ENV{REMOTE_ADDR}="$ipv4addr";#nocompact
		}#nocompact
		if($ipv4addr ne '') {#nocompact
			my $host#nocompact
			 = gethostbyaddr(pack("C4", split(/\./, $ENV{REMOTE_ADDR})), 2);#nocompact
			if($host eq '') {#nocompact
				$host=$ENV{REMOTE_ADDR};#nocompact
			}#nocompact
			$ENV{REMOTE_HOST}=$host;#nocompact
		} elsif($ipv6addr ne '') {#nocompact
			my $funcp = $::functions{"load_module"};
			if(&$funcp("Net::DNS")) {#nocompact
				# IPV6アドレスを展開する。#nocompact	# comment
				my @address;#nocompact
				if ($ipv6addr =~ /::/) {#nocompact
			        my ($adr_a, $adr_b) = split /::/, $ipv6addr;#nocompact
			        my @adr_a = split /:/, $adr_a;#nocompact
			        my @adr_b = split /:/, $adr_b;#nocompact
   					for (scalar @adr_a .. 7 - scalar @adr_b) {#nocompact
						push @adr_a, 0#nocompact
					}#nocompact
					@address = (@adr_a, @adr_b);#nocompact
				} else {#nocompact
					@address = split /:/, $ipv6addr;#nocompact
				}#nocompact
				$ipv6addr =  (join ":", @address);#nocompact
#nocompact
				# IPV6アドレスを解決する#nocompact	# comment
				my $resolver = new Net::DNS::Resolver;#nocompact
			    my $ans = $resolver->query($ipv6addr, 'PTR', 'IN');#nocompact
				if($ans) {#nocompact
			        foreach my $rr ($ans->answer) {#nocompact
			                next if $rr->type ne "PTR";#nocompact
			                $ENV{REMOTE_HOST}=$rr->ptrdname;#nocompact
			        }#nocompact
				} else {#nocompact
					$ENV{REMOTE_HOST}="$ipv6addr";#nocompact
				}#nocompact
			} else {#nocompact
				$ENV{REMOTE_HOST}="$ipv6addr";#nocompact
			}#nocompact
		}#nocompact
	}#nocompact
	if($ENV{REMOTE_HOST} eq '') {#compact
		my $host#compact
		 = gethostbyaddr(pack("C4", split(/\./, $ENV{REMOTE_ADDR})), 2);#compact
		if($host eq '') {#compact
			$host=$ENV{REMOTE_ADDR};#compact
		}#compact
		$ENV{REMOTE_HOST}=$host;#compact
	}#compact
	# プロクシのIPアドレスを抜く #nocompact #comment
	my $proxy;#nocompact
	if($ENV{REMOTE_HOST_ORG} eq '') {#nocompact
		$ENV{REMOTE_HOST_ORG}=$ENV{REMOTE_HOST};#nocompact
	} else {#nocompact
		$ENV{REMOTE_HOST}=$ENV{REMOTE_HOST_ORG};#nocompact
	}#nocompact
	if($ENV{HTTP_CLIENT_IP}=~/($::ipv4address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	} elsif($ENV{HTTP_CLIENT_IP}=~/($::ipv6address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	} elsif($ENV{HTTP_FORWARDED}=~/($::ipv4address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	} elsif($ENV{HTTP_FORWARDED}=~/($::ipv6address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	} elsif($ENV{HTTP_X_FORWARDED_FOR}=~/($::ipv4address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	} elsif($ENV{HTTP_X_FORWARDED_FOR}=~/($::ipv6address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	} elsif($ENV{HTTP_VIA}=~/($::ipv4address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	} elsif($ENV{HTTP_VIA}=~/($::ipv6address_regex)/) {#nocompact
		$proxy=$1;#nocompact
	}#nocompact
	if($proxy ne '') {#nocompact
		$ENV{REMOTE_HOST}.= " ($proxy)";#nocompact
	}#nocompact
}
1;
__END__

=head1 NAME

Nana::RemoteHost - Get remoteHost module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/RemoteHost.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/RemoteHost.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/RemoteHost.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/RemoteHost.pm?view=log>

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
