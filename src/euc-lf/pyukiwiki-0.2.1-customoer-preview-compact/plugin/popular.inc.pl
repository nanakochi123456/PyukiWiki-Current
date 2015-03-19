######################################################################
# popular.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author YashiganiModoki
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# ��Բ������̤ΰ١��������Ȥ�Ƥ��ޤ��󤬡��ص��ξ��
# v0.1.6�б��Ǥ����ۤ��뤳�ȤȤ��ޤ�����
# ����¾��������ǽ���夷�Ƥ��ޤ���
# PyukiWiki Developer Term
######################################################################
# �Ȥ���
#
# #popular(10(���),FrontPage|MenuBar,[total/today/yesterday...],[notitle])
#
# �������ɽ��������
# �����оݥڡ������оݳ��Υڡ���������ɽ���ǵ��Ҥ���
# ��total/today/yesterday�������оݤ�������������������������������
#   $::CountView=2�Ǥ���С��ʲ�����ѤǤ��ޤ���
#   week - �����ι��
#   lastweek - �轵�ι��
# ��notitle��ʸ�������ꤹ��ȥ����ȥ뤬ɽ������ʤ��ʤ롣
# �ʤ���popurar����Ѥ���ȡ���ưŪ��popular.inc.pl�����󥯥롼��
# ����ޤ���
######################################################################
######################################################################
# ��Բ������̤ΰ١��������Ȥ�Ƥ��ޤ��󤬡��ص��ξ��
# v0.1.6�б��Ǥ����ۤ��뤳�ȤȤ��ޤ�����
# ����¾��������ǽ���夷�Ƥ��ޤ���
# PyukiWiki Developer Term
######################################################################
# �Ȥ���
#
# #popular(10(���),FrontPage|MenuBar,[total/today/yesterday...],[notitle])
#
# �������ɽ��������
# �����оݥڡ������оݳ��Υڡ���������ɽ���ǵ��Ҥ���
# ��total/today/yesterday�������оݤ�������������������������������
#   $::CountView=2�Ǥ���С��ʲ�����ѤǤ��ޤ���
#   week - �����ι��
#   lastweek - �轵�ι��
# ��notitle��ʸ�������ꤹ��ȥ����ȥ뤬ɽ������ʤ��ʤ롣
# �ʤ���popurar����Ѥ���ȡ���ưŪ��popular.inc.pl�����󥯥롼��
# ����ޤ���
######################################################################
# ����å����ݻ�����(20ʬ)
$popular::cache_expire=20*60
	if(!defined($popular::cache_expire));
######################################################################
use strict;
use Nana::Cache;
use Nana::MD5 qw(md5_hex);
sub plugin_popular_convert {
	my $argv = shift;
	my ($limit, $ignore_page, $flag, $notitle) = split(/,/, $argv);
	return qq(<div class="error">counter.inc.pl can't require</div>)
		if (&exist_plugin("counter") ne 1);
	if ($limit+0 < 1) {$limit = 10;}
	if ($ignore_page eq '') {$ignore_page = '^FrontPage$|MenuBar$';}
	if ($::non_list  ne '') {$ignore_page .= "|$::non_list";}
	$flag=lc $flag;
	$flag="total" if($flag eq '');
	my $exist_urlhack=-r "$::explugin_dir/urlhack.inc.cgi";
	my $cachefile=&md5_hex("$limit-$ignore_page-$flag-$::lang-$exist_urlhack");
	my $cache=new Nana::Cache (
		ext=>"popular",
		files=>100,
		dir=>$::cache_dir,
		size=>100000,
		use=>1,
		expire=>365 * 86400,
	);
	my $out=$cache->read($cachefile);
	my $cache2=new Nana::Cache (
		ext=>"popular",
		files=>100,
		dir=>$::cache_dir,
		size=>100000,
		use=>1,
		expire=>$popular::cache_expire,
	);
	$cache2->check(
		"$::plugin_dir/popular.inc.pl",
		"$::res_dir/popular.$::lang.txt",
		"$::explugin_dir/Nana/Cache.pm"
	);
	my $tmp=$cache2->read($cachefile);
	if($out eq '') {
		$out=&plugin_popular_make($cachefile, $ignore_page, $flag, $notitle, $limit);
		$cache->write($cachefile,$out);
		return $out;
	}
	my $pid;
	if($tmp eq '') {
		$pid=fork;
		unless(defined $pid) {
			$out=&plugin_popular_make($cachefile, $ignore_page, $flag, $notitle, $limit);
			$cache->write($cachefile,$out);
			return $out;
		} else {
			if($pid) {
				$cache->write($cachefile,$out);
				local $SIG{ALRM} = sub { die "time out" };
				eval {
					alerm(1);
					wait;
					alerm(0);
				};
				if ($@ =~ /time out/) {
					return $out;
				} else {
					return $out;
				}
			} else {
				close(STDOUT);
				$out=&plugin_popular_make($cachefile, $ignore_page, $flag, $notitle, $limit);
				$cache->write($cachefile,$out);
				exit;
			}
		}
	}
	return ' ' if($out eq '');
	return $out;
}
sub plugin_popular_make {
	my($cachefile, $ignore_page, $flag, $notitle, $limit)=@_;
	my $out;
	my @populars;
	my $count = 0;
	foreach my $page (sort keys %::database) {
		next if !&is_exist_page($page);
		next if $page =~ /^($::RecentChanges)$/;
		next if $page =~ /($ignore_page)/;
		next unless(&is_readable($page));
		my $cnt=&plugin_counter_selection($flag,&plugin_counter_do($page,"r"));
		push @populars, sprintf("%d\t%s",$cnt,$page)
			if($cnt > 0);
	}
	foreach my $key (sort { $b<=>$a } @populars) {
		last if ($count >= $limit);
		my ($cnt,$page)=split(/\t/,$key);
		$out .= "<li>" . &make_link(&armor_name($page)) . "<span class=\"popular\">($cnt)</span></li>\n";
		$count++;
	}
	if ($out) {
		$out =  '<ul class="popular_list">' . $out . '</ul>';
	}
	if($notitle ne 'notitle') {
		if ($::resource{"popular_plugin_$flag\_frame"}) {
			$out=sprintf $::resource{"popular_plugin_$flag\_frame"}, $count, $out;
		}
	}
	return $out;
}
1;
__END__