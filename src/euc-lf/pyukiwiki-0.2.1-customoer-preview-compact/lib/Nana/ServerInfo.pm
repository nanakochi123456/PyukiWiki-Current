######################################################################
# ServerInfo.pm - $Id$
#
# "Nana::ServerInfo" ver 0.1 $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
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
