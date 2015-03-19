######################################################################
# ServerInfo.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:35:19
#
# "Nana::ServerInfo" ver 0.1 $$
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
