######################################################################
# counter.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:24:06
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# #counter
# &counter(arg);
#  total - 合計
#  today - 今日
#  yesterday - 昨日
#  数字 - 昨日からの指定した数字分の日数合計 ($::CountView=2 only)
#  week - 今週の合計 ($::CountView=2 only)
#  lastweek - 先週の合計 ($::CountView=2 only)
######################################################################

use strict;
use Nana::Counter;

# mod_perlで実行可能に										# comment
$::functions{"plugin_counter_do"} = \&plugin_counter_do;

%::counter_loaded;

my %default = (
	'total'     => 0,
	'date'      => '',
	'today'     => 0,
	'yesterday' => 0,
	'ip'        => ''
);

sub plugin_counter_inline {
	my $arg = shift;
	my %counter = plugin_counter_get_count($::form{basepage} ne '' ? $::form{basepage} : $::form{mypage});
	return "@{[&plugin_counter_imagecount($::form{basepage} ne '' ? $::form{basepage} : $::form{mypage})]}" . &plugin_counter_selection($arg,%counter);
}

sub plugin_counter_getudate {
	return int((time+$::TZ*3600) / 86400);
}

sub plugin_counter_selection {
	my($arg,%counter)=@_;

	my $count=0;
	if ($arg =~/(today|yesterday)/i) {
		$count = $counter{$arg};
	} elsif($arg+0>0 && $::CounterVersion > 1) {
		for(my $i=1; $i<=$i; $i++) {
			$count+=$counter{&plugin_counter_getudate-$i};
		}
	} elsif($arg=~/week/ && $::CounterVersion > 1) {
		for(my $i=0; $i<=($arg=~/last/ ? 6 : (localtime(time))[6]); $i++) {
			$count+=$counter{&plugin_counter_getudate-$i-($arg=~/last/ ? (localtime(time))[6]+1 : 0)};
		}
	} else {
		$count = $counter{'total'}
	}
	return $count;
}

sub plugin_counter_convert {
	my %counter = plugin_counter_get_count($::form{basepage} ne '' ? $::form{basepage} : $::form{mypage});
	return <<EOD;
<div class="counter">
Counter: $counter{total},
today: $counter{today},
yesterday: $counter{yesterday}
</div>@{[&plugin_counter_imagecount($::form{basepage} ne '' ? $::form{basepage} : $::form{mypage})]}
EOD
}

sub plugin_counter_imagecount {
	my $page = shift;
	return " " if(!$::CounterImage);
	&load_module("Nana::MD5");
	return <<EOM;
<img src="$::script?cmd=counter&mypage=@{[&encode($page)]}&hash=@{[Nana::MD5::md5_hex($page . $ENV{REMOTE_ADDR} . time)]}" height=1 width=1 />
EOM
}

sub plugin_counter_action {
	my $page=$::form{mypage};
	&plugin_counter_do($page, "w");
	my $empty_gif=<<EOM;
47 49 46 38 39 61 01 00 01 00 80 01 00 FF FF FF
FF FF FF 21 F9 04 01 00 00 01 00 2C 00 00 00 00
01 00 01 00 00 02 02 4C 01 00 3B
EOM
	$empty_gif=~s/[\s\n]//g;
	print "Content-type: image/gif\n\n";
	binmode(STDOUT);
	print pack("H+", $empty_gif);
}

sub plugin_counter_get_count {
	my $page = shift;

	if (!&is_exist_page($page)) {
		return %default;
	}
	return &plugin_counter_do($page,$::CounterImage ? "w" : "r");
}

sub plugin_counter_getudate {
	return int((time+$::TZ*3600) / 86400);
}

sub plugin_counter_do {
	my($page,$rw)=@_;

	my $cobj=new Nana::Counter(dir=>$::counter_dir, version=>$::CounterVersion);
	if($rw eq "W" || $rw eq "w") {
		return $cobj->add($page);
	} else {
		return $cobj->read($page);
	}
}
1;
__END__

=head1 NAME

counter.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 #counter
 &counter(total);
 &counter(today);
 &counter(yesterday);

=head1 DESCRIPTION

Access counter

=head1 USAGE

=over 4

=item #counter

View all counter value

=item &counter(total);

Total of counter, page reference is displayed.

=item &counter(today);

Count of page reference display, a part for today.

=item &counter(yesterday);

Count of page reference display, a part for yesterday.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/counter

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/counter/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/counter.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/counter.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/counter.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/counter.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2004-2007 by Nekyo.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
