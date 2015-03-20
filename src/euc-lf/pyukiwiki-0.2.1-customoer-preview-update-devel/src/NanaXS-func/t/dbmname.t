######################################################################
# dbmname.t - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:55:47
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# XSPKG : NanaXS::func 0.1

use strict;
use warnings;
use Time::HiRes qw(gettimeofday tv_interval);

use Test::More tests => 3;
BEGIN {
	push @INC, "./blib";
	push @INC, "./blib/lib";
	push @INC, "./blib/arch";
	push @INC, "./blib/arch/auto";
};
diag("NanaXS::func load\n");
use_ok('NanaXS::func');

#########################


my $test=q( !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ]^_`abcdefghijklmnopqrstuvwxyz{|}~);


my $test1;
my $test2;

$test1=$test;
$test1 =~ s/(.)/uc unpack('H2', $1)/eg;
$test2=NanaXS::func::dbmname($test);

diag("NanaXS::func::dbmname(short)\n");
ok($test1 eq $test2, "dbmname (short)");

my $t0 = [gettimeofday];

diag("NanaXS::func::dbmname(prepare big data)\n");
my $testbig;
for(my $i=0; $i < 100; $i++) {
	$testbig.=$test;
}
$test=$testbig;
for(my $i=0; $i < 50; $i++) {
	$testbig.=$test;
}

my $t1 = [gettimeofday];
diag(tv_interval ($t0, $t1) . "sec\n");

diag("Nana::XS::func::dbmname(pure perl)");
$test=$testbig;
$test1=$testbig;

$test1 =~ s/(.)/uc unpack('H2', $1)/eg;

my $t2 = [gettimeofday];
diag(tv_interval ($t1, $t2) . "sec\n");

diag("NanaXS::func::dbmname(big)\n");
$test2=NanaXS::func::dbmname($test);
ok($test1 eq $test2, "dbmname (big)");

my $t3 = [gettimeofday];
diag(tv_interval ($t2, $t3) . "sec\n");

exit(0);
