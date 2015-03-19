######################################################################
# ls2.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# v0.2.1
#        2012/08/06 ��ǽ�ɲ�
# v0.2.0-p3
#        2012/03/13 �Х�����
# v0.2.0 2012/02/15 �Ƴ��ؤ�ɽ�����ǽ�����MenuBar���ɽ���ǽ���
# v0.1.6 2006/01/07 *****�ޤ��б����롢����¾����
# v0.1   2005/04/01 encode �Х� Fix Tnx:Junichi����
# v0.0   2004/11/01 �ʰ��� title,reverse �б�������¾�����б�
# based on ls2.inc.php by arino
#
#*�ץ饰���� ls2
#�۲��Υڡ����θ��Ф�(*,**,***)�ΰ�����ɽ������
#
#*Usage
# #ls2(�ѥ�����[,�ѥ�᡼��])
#
#*�ѥ�᡼��
#-�ѥ�����(�ǽ�˻���) ��ά����Ȥ��⥫��ޤ�ɬ��
#-title:���Ф��ΰ�����ɽ������
#-include:���󥯥롼�ɤ��Ƥ���ڡ����θ��Ф���Ƶ�Ū����󤹤�
#-link:action�ץ饰�����ƤӽФ���󥯤�ɽ��
#-reverse:�ڡ������¤ӽ��ȿž�����߽�ˤ���
#-nothis:��ʬ���ȤΥڡ�����ɽ�����ʤ�
#-noprefix:�Ƴ��ؤ�ɽ�����ʤ�
#-nobr:�ꥹ��ɽ���򤷤ʤ�
#-format=xxxx:������򤹤�
#-compact:
######################################################################
use strict;
sub plugin_ls2_convert
{
	my $prefix = '';
	my @args = split(/,/, shift);
	my $title = 0;
	my $reverse = 0;
	my (@pages, $txt, @txt, $tocnum);
	my $body = '';
	my $noprefix = 0;
	my $nothis = 0;
	my $nobr = 0;
	my $nowarn = 0;
	my $format;
	if (@args > 0) {
		$prefix = shift(@args);
		foreach my $arg (@args) {
			if (lc $arg eq "title") {
				$title = 1;
			} elsif (lc $arg eq "reverse") {
				$reverse = 1;
			} elsif (lc $arg eq "noprefix") {
				$noprefix = 1;
			} elsif (lc $arg eq "nothis") {
				$nothis = 1;
			} elsif (lc $arg eq "nobr") {
				$nobr = 1;
			} elsif (lc $arg eq "nowarning") {
				$nowarn = 1;
			} else {
				my($l, $r)=split(/=/,$arg);
				if($l eq "format") {
					$format=&htmlspecialchars($r);
				}
			}
		}
	}
	$prefix = $::form{mypage} if ($prefix eq '');
	foreach my $page (sort keys %::database) {
		if ($page =~ /^$prefix/ && &is_readable($page) && $page!~/$::non_list/) {
			if($noprefix eq 1) {
				my $cutedpage=$page;
				$cutedpage=substr($cutedpage, length("$prefix$::separator"));
				push(@pages, "$page\t$cutedpage")
					if($nothis eq 0 || $nothis eq 1 && $page ne $prefix);
			} else {
				push(@pages, "$page\t$page")
					if($nothis eq 0 || $nothis eq 1 && $page ne $prefix);
			}
		}
	}
	@pages = reverse(@pages) if ($reverse);
	foreach (@pages) {
		my ($page, $cutedpage)=split(/\t/,$_);
		next if($cutedpage eq "");
		if($format ne "") {
			my $tmp1 = <<"EOD";
<a id ="list_1" href="@{[&make_cookedurl(&encode($page))]}" title="$page">$cutedpage</a>
EOD
			chomp $tmp1;
			my $tmp2=$format;
			$tmp2=~s/\$1/$tmp1/g;
			$body.=$tmp2;
		} else {
			if($nobr eq 1) {
				$body .= <<"EOD";
<a id ="list_1" href="@{[&make_cookedurl(&encode($page))]}" title="$page">$cutedpage</a>
EOD
			} else {
				$body .= <<"EOD";
<li><a id ="list_1" href="@{[&make_cookedurl(&encode($page))]}" title="$page">$cutedpage</a></li>
EOD
			}
		}
		if ($title) {
			$txt = $::database{$page};
			@txt = split(/\r?\n/, $txt);
			$tocnum = 0;
			my (@tocsaved, @tocresult);
			foreach (@txt) {
				chomp;
				if (/^(\*{1,5})(.+)/) {
					&back_push('ul', length($1), \@tocsaved, \@tocresult);
					push(@tocresult, qq( <li><a href="@{[&make_cookedurl(&encode($page))]}#@{[&makeanchor($page,$tocnum,$2)]}">@{[&escape($2)]}</a></li>\n));
					$tocnum++;
				}
			}
			push(@tocresult, splice(@tocsaved));
			$body .= join("\n", @tocresult);
		}
	}
	if ($body ne '') {
		if($nobr eq 1) {
			return << "EOD";
<div>$body</div>
EOD
		}
		return << "EOD";
<ul class="list1">$body</ul>
EOD
	}
	if($nowarn eq 1) {
		return " ";
	}
	return "<strong>'$prefix'</strong> $::resource{ls2_plugin_notpage}<br />\n";
}
1;
__END__
