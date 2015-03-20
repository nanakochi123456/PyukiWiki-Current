######################################################################
# ServerInfo.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:53:24
#
# "Nana::ServerInfo" ver 0.1 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

package	Nana::ServerInfo;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.1';

######################################################################

sub new {
	my($class,%hash)=@_;
# http://d.hatena.ne.jp/perlcodesample/20080430/1209569716	# comment
	my $os=$^O;
	my $info;
	my $cores=0;
	if(lc $os eq "linux") {
		open(PIPE, "/bin/cat /proc/cpuinfo |") || die "Can't open /proc/cpuinfo";
		foreach(<PIPE>) {
			$info.=$_;
		}
		close(PIPE);
	}
	if(lc $os eq "freebsd") {
		open(PIPE, "/bin/cat /var/run/dmesg.boot |") || die "Can't open /var/run/dmesg.boot";
		foreach(<PIPE>) {
			$info.=$_;
		}
		close(PIPE);
	}
	if(lc $os eq "linux") {
		my $lines=0;
		foreach(split/\n/,$info) {
			$lines++ if(/model name/);
		}
		$cores=$lines if($lines > 1);
	}
	if(lc $os eq "freebsd") {
		foreach my $buf(split/\n/,$info) {
			if($buf=~/ CPUs/) {
				$buf=~s/.*\: //g;
				$buf=~s/ CPUs//g;
				$cores=$buf if($buf+0 > 1);
			}
		}
	}
	my $self={
		os=>$os,
		core=>$cores + 0
	};
	return bless $self, $class;
}

sub os {
	my($self,$name)=@_;
	return $self->{os}
}

sub core {
	my($self,$name)=@_;
	return $self->{core};
}

1;
__END__

=head1 NAME

Nana::ServerInfo - Server spec analyzer module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/ServerInfo.pm?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/ServerInfo.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/ServerInfo.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/ServerInfo.pm?view=log>

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
