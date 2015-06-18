######################################################################
# Counter.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:15:52
#
# "Nana::Counter" ver 0.1 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package	Nana::Counter;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION = '0.1';
# $counterobj=new Nana::Counter();
sub new {
	my($class, %hash)=@_;
	my $self = {
		version => $hash{version},
		dir => $hash{dir},
	};
	if($$self{version} eq 1) {
		&load_module("Nana::Counter1");
	} elsif($$self{version} eq 2) {
		&load_module("Nana::Counter2");
	}
	return bless $self, $class;
}
# %counter=$counterobj->read($page);
sub read {
	my($self, $page)=@_;
	if($$self{version}+0 eq 1) {
		return Nana::Counter1::counter($$self{dir}, $page, "r");
	} elsif($$self{version}+0 eq 2) {
		return Nana::Counter2::counter($$self{dir}, $page, "r");
	}
	undef;
}
# %counter=$counterobj->add($page);
sub add {
	my($self, $page)=@_;
	if($$self{version}+0 eq 1) {
		return Nana::Counter1::counter($$self{dir}, $page, "w");
	} elsif($$self{version}+0 eq 2) {
		return Nana::Counter2::counter($$self{dir}, $page, "w");
	}
	undef;
}
# %counter=$counterobj->delete($page);
sub delete {
	my($self, $page)=@_;
	if($$self{version}+0 eq 1) {
		return Nana::Counter1::delete($$self{dir}, $page);
	} elsif($$self{version}+0 eq 2) {
		return Nana::Counter2::delete($$self{dir}, $page);
	}
	undef;
}
sub getudate {
	return int((time+$::TZ*3600) / 86400);
}
sub encode {
	my $funcp = $::functions{"encode"};
	return &$funcp(@_);
}
sub dbmname {
	my $funcp = $::functions{"dbmname"};
	return &$funcp(@_);
}
sub load_module {
	my $funcp = $::functions{"load_module"};
	return &$funcp(@_);
}
1;
__END__
