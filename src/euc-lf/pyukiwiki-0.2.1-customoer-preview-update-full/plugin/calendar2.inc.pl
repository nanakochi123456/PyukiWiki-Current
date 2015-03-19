######################################################################
# calendar2.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:14:33
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# ��Բ������̤ΰ١��������Ȥ�Ƥ��ޤ��󤬡��ص��ξ��
# v0.1.6�б��Ǥ����ۤ��뤳�ȤȤ��ޤ�����
# ���ʤ굡ǽ���夷�Ƥ��ƽŤ��ʤäƤ��ޤ��Τǡ��ڲ��ʤۤ�����Ѥ�����
# ���ϡ����ꥸ�ʥ��Ǥ�calender.inc.pl�����Ѳ�������
#
# �䤷���ˤ�ɤ���ΤȤϰʲ������ǰۤʤ�ޤ���
# �������ɥ١�������������˽񤭴�����
# ��exdate.inc.cgi��Ƴ������Ƥ���������٤Ƥν񼰤��Ȥ���褦�ˤʤäƤ���
#   (���������ʤ�Ť��Ǥ�)
# ��exdate.inc.cgi��Ƴ������Ƥ������������ư�׻�����ɽ������褦�ˤʤäƤ���
#   (ˡΧ�Ѥ��ʤ��¤���ѹ����פǤ�)
# ������Ū�ʱ黻��ˡ�򾯤��Ѥ���
# �������Խ����̤ν���ƥ����Ȥ�����Ǥ���褦�ˤ�����
#   ����ץ�ǡ�my $$calendar2::initwikiformat�����ꤷ�Ƥ���ޤ���
#   __DATE__ �ϡ����Υ������������դ��ִ�����ޤ�
# ���Ĥ��ǤǤ�����CSS��MenuBar�ȥڡ������Τ�ξ���򵭽Ҥ��Ƥ���ޤ��Τ�
#   ���줾��Υ��������碌�����פǤ���
#
# ������ˡ
#
# #calendar2(Diary,SGGYǯZn��Zj����DL��RY RK\nRS RG XG SZ MG)
# #calendar2(�ڡ���̾,���եե����ޥå�)
# �ڡ���̾:�١����Ȥʤ�ڡ�������ꤷ�ޤ�
# ���եե����ޥåȡ�ToolTip��ɽ����������դξܺپ������ꤷ�ޤ���
#                   \n �������ȡ����Ԥ��Ѵ�����ޤ���
#                   FireFox�Ǥϡ�JavaScript��̵���Ǥ��������
#                   ɽ������ޤ���
#
# p.s.exdate�ˤ�¿���Υ���å����ݻ���ǽ�����äƾ����Ǥ�ڤ��ʤ�褦��
# �ʤäƤ��ޤ���������Ǥ�ޤ��ޤ��Ť��Ǥ�����
######################################################################
# �����Խ����̤Ǥν����
# ����������ALT
#
if($::_exec_plugined{exdate} ne '') {
	# exdate��Ƴ������Ƥ���� ( ) �����Ѥ�����ʸ����
	$calendar2::initwikiformat=<<EOM;
*&date(SGGYǯZn��Zj����DL��RY RK RS RG XG SZ MG,__DATE__);
EOM
	$calendar2::altformat="DL RY RK RG";
} else {
	# exdate��Ƴ������Ƥ��ʤ���
	$calendar2::initwikiformat=<<EOM;
*&date(Y-n-j[lL],__DATE__);
EOM
	$calendar2::altformat="[lL]";
}
#
######################################################################
# MenuBar�������֤�����硢��������MenuBar������ư������� 1
$calendar2::menubaronly=1;
#
######################################################################
use strict;
use Time::Local;
sub plugin_calendar2_convert {
	my ($page, $arg_date, $date_format) = split(/,/, shift);
	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday, $isdst);
	my ($disp_wday,$today,$start,$end,$i,$label,$cookedpage,$d);
	my ($prefix,$splitter);
	my $empty = '';	#'&nbsp;';
	my $calendar = "";
	my ($_year,$_mon);
	($sec, $min, $hour, $mday, $mon, $year) = localtime();
	$_year=$year+1900;
	$_mon=$mon+1;
	my $crlf='&#13;&#10;';
	if($date_format eq '') {
		$date_format="Y-n-j(lL)";
	} else {
		$date_format=~s/\\n/\n/g;
	}
	if ($page eq '') {
		$prefix = $::form{mypage};
		$splitter = $::separator;
	} elsif ($page eq '*') {
		$prefix = '';
		$splitter = '';
	} else {
		$prefix = $page;
		$splitter = $::separator;
	}
	$page = &htmlspecialchars($prefix);
	if($calendar2::menubaronly+0 eq 1) {
		$arg_date=$::form{date} if($::form{date} ne '');
	}
	if ($arg_date =~ /^(\d{4})[^\d]?(\d{1,2})$/ ) {
		$year = $1 - 1900;
		$mon = ($2-1) % 12;
	}
	my $disp_year  = $year+1900;
	my $disp_month = $mon+1;
	my $pagelink=&makepagelink($page,$page,$::resource{editthispage});
	my $prev_year=$disp_month eq 1 ? $disp_year-1 : 	$disp_year;
	my $prev_month=$disp_month eq 1 ? 12 : $disp_month-1;
	my $next_year=$disp_month eq 12 ? $disp_year+1 : $disp_year;
	my $next_month=$disp_month eq 12 ? 1 : $disp_month+1;
	my $label="$disp_year.$disp_month";
	my $cookedpage=&encode($page eq '' ? $::FrontPage : $page);
	my @weekstr;
	# ����ʸ�����wiki.cgi�����������						# comment
	for(my $i=1; $i<=7; $i++) {
		my $tm=Time::Local::timelocal(0,0,0,$i,$disp_month-1,$disp_year-1900);
		$weekstr[&getwday($disp_year,$disp_month,$i)]
			= &date("lL",$tm);
	}
	my $query;
	if($calendar2::menubaronly+0 eq 1) {
		$query="cmd=read&amp;mypage=@{[&encode($::pushedpage eq '' ? $::form{mypage} : $::pushedpage)]}";
	} else {
		$query="cmd=calendar2&amp;mymsg=$cookedpage&amp;format=@{[&encode($date_format)]}";
	}
	$calendar =<<"END";
<table class="style_calendar" summary="calendar body">
<tr>
<td class="style_td_caltop" colspan="7">
  <a href="$::script?$query&amp;date=@{[sprintf("%04d%02d",$prev_year,$prev_month)]}">&lt;&lt;</a>
  <strong>$label</strong>
  <a href="$::script?$query&amp;date=@{[sprintf("%04d%02d",$next_year,$next_month)]}">&gt;&gt;</a><br />
  $pagelink</td>
</tr>
<tr>
<td class="style_td_week">$weekstr[0]</td>
<td class="style_td_week">$weekstr[1]</td>
<td class="style_td_week">$weekstr[2]</td>
<td class="style_td_week">$weekstr[3]</td>
<td class="style_td_week">$weekstr[4]</td>
<td class="style_td_week">$weekstr[5]</td>
<td class="style_td_week">$weekstr[6]</td>
</tr>
<tr>
END
	my $disp_wday=&getwday($disp_year,$disp_month,1);
	for($i=0; $i< $disp_wday; $i++ ) {
		$calendar.=qq(<td class="style_td_blank">$empty</td>);
	}
	# exdate ������С���������ߡ��ɤ߹��ߤ���					# comment
	if($::_exec_plugined{exdate} ne '') {
		&date("RS",Time::Local::timelocal(0,0,0,1,$disp_month-1,$disp_year-1900));
	}
	my $initwiki_format= &code_convert(\$calendar2::initwikiformat,$::kanjicode,$::defaultcode);
	for($i=1;$i<=&lastday($disp_year,$disp_month); $i++) {
		my $wday=&getwday($disp_year,$disp_month,$i);
		my $pagename = sprintf "%s%s%04d-%02d-%02d", $page, $splitter, $disp_year, $disp_month, $i;
		my $cookedname = &encode($pagename);
		my $style;
		$calendar.=qq(</tr>\n<tr>) if($wday eq 0 && $i ne 1);
		if($_year eq $disp_year && $_mon eq $disp_month && $i eq $mday) {
			$style='style_td_today';
		} elsif($::SYUKUJITSU{sprintf("%04d_%02d_%02d",$disp_year,$disp_month,$i)} ne '') {
			$style = 'style_td_sun';
		} elsif($wday eq 0) {
			$style = 'style_td_sun';
		} elsif($wday eq 6) {
			$style = 'style_td_sat';
		} else {
			$style = 'style_td_day';
		}
		my $alt=&date($calendar2::altformat,
			Time::Local::timelocal(0,0,0,$i,$disp_month-1,$disp_year-1900));
		$alt=~s/^\s//g while($alt=~/^\s/);
		$alt=~s/\s\s/ /g while($alt=~/\s\s/);
		$alt=~s/\s$//g while($alt=~/\s$/);
		$calendar .= qq(<td class="$style">@{[&makepagelink($pagename,"$alt","$alt",$i,$initwiki_format,"$disp_year/$disp_month/$i")]}</td>);
	}
	$disp_wday=&getwday($disp_year,$disp_month,&lastday($disp_year,$disp_month));
	if($disp_wday % 7 ne 6) {
		for($i= $disp_wday; $i<6; $i++) {
			$calendar .= "<td class=\"style_td_blank\">$empty</td>";
		}
	}
	$calendar.="</tr></table>\n";
	return $calendar;
}
sub makepagelink {
	my($page,$nonposted, $posted,$name,$wiki,$date)=@_;
	my $pagelink;
	my $cookedpage=&encode($page eq '' ? $::FrontPage : $page);
	my $cookedurl;
	if($calendar2::menubaronly+0 eq 1) {
		if($::form{date} ne '') {
			$cookedurl="$::script?cmd=read&amp;mypage=$cookedpage&amp;date=$::form{date}";
		} else {
			$cookedurl=&make_cookedurl($cookedpage);
		}
	} else {
		$cookedurl=&make_cookedurl($cookedpage);
	}
	if ($::database{$page}) {
		$pagelink = qq(<a title="$posted" href="$cookedurl">@{[$name eq '' ? $page : "<strong>$name</strong>"]}</a>);
	} elsif ($page eq '') {
		$pagelink = '';
	} else {
		if($wiki ne '') {
			$wiki=~s/__DATE__/$date/g;
			$wiki="&amp;plugined=1&amp;mymsg=@{[&encode($wiki)]}";
		}
		$pagelink = qq(<a title="$nonposted" class="editlink" href="$::script?cmd=adminedit&amp;mypage=$cookedpage&amp;date=$::form{date}$wiki">@{[$name eq '' ? $page : $name]}</a>);
	}
	return $pagelink;
}
sub plugin_calendar2_action {
	my $page = &escape($::form{mymsg});
	my $date = &escape($::form{date});
	my $format=&htmlspecialchars($::form{format});
	my $body = &plugin_calendar2_convert(qq($page,$date,$format));
	my $yy = sprintf("%04d.%02d",substr($date,0,4),substr($date,4,2));
	my $s_page = &htmlspecialchars($page);
	return ('msg'=>qq(calendar $s_page/$yy), 'body'=>$body);
}
1;
__END__