######################################################################
# autometarobot.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'autometarobot.inc.cgi'
######################################################################
#
# �ڡ��������ܥåȷ��������󥸥�ؤΥ�����ɤ�ư��������
#
# �������
# ������������ɤ����ޤ�ˤ⹥�ߤǤʤ��ΤǤ���С�
# ��Ŭ����wiki���Τζ�Ĵʸ���������ꤷ�Ƥߤ��ꡢ������Ƥߤ���
# �����ƤߤƲ�������
#
######################################################################
$::auto_meta_maxkeyword=100								# ��ư������ɤ����ñ���
	if(!defined($::auto_meta_maxkeyword));				# 0�ʤ���Ф��ʤ�
$::auto_meta_minlength=5								# ��ư������ɤκǾ�ʸ����
	if(!defined($::auto_meta_minlength));
#############################
# Initlize												# comment
sub plugin_autometarobot_init {
	return ('init'=>1, 'func'=>'meta_robots', 'meta_robots'=>\&meta_robots);
}
# hack wiki.cgi of meta_robots
sub meta_robots {
	my($cmd,$pagename,$body)=@_;
	my $robots;
	my $keyword;
	if($cmd=~/edit|admin|diff|attach|backup|setting/
		|| $::form{mypage} eq '' && $cmd!~/list|sitemap|recent/
		|| $::form{mypage}=~/$::resource{help}|$::resource{rulepage}|$::RecentChanges|$::MenuBar|$::SideBar|$::TitleHeader|$::Header|$::Footer|$::BodyHeader|$::BodyFooter|$::SkinFooter|$::SandBox|$::InterWikiName|$::InterWikiSandBox|$::non_list/
		|| $::meta_keyword eq "" || lc $::meta_keyword eq "disable"
		|| &is_readable($::form{mypage}) eq 0) {
		$robots.=<<EOD;
<meta name="robots" content="NOINDEX,NOFOLLOW,NOARCHIVE" />
<meta name="googlebot" content="NOINDEX,NOFOLLOW,NOARCHIVE" />
EOD
	} else {
		$robots.=<<EOD;
<meta name="robots" content="INDEX,FOLLOW" />
<meta name="googlebot" content="INDEX,FOLLOW,ARCHIVE" />
EOD
		$keyword=$::meta_keyword;
		if($::auto_meta_maxkeyword>0) {
			# �ʲ�������ɼ�ư����						# comment
			my @keyword;
			$keyword="$::wiki_title,$::meta_keyword," . &htmlspecialchars($pagename) . ",";
			# <h?>��</h?>����Ĵ��WikiName						# comment
			foreach($body=~/(<h\d>(.+?)<\/h\d>|<strong>(.+?)<\/strong>|$::wiki_name)/g) {
				s/[\x0d\x0a]//g;
				s/<.*?>//g;
				$keyword.="$_,";
			}
			# img alt="��", a title="��"						# comment
			foreach($body=~/<(?:a|img)(?:.+?)(?:alt|title)="(.+?)"(?:.+)>/g) {
				next if(/^$::non_list|$::isurl/);
				s/[\x0d\x0a]//g;
				s/<.*?>//g;
				next if(/$::resource{editthispage}|$::resource{admineditthispage}/);
				$keyword.="$_,";
			}
			$keyword=~s/$::_symbol_anchor//g;
			# UTF-8�Ǥ�EUC�˥���С��Ȥ��롣						# comment
			$keyword=~s/([\x0-\x2f|\x3a-\x40|\x5b-\x60|\x7b-\x7f]|(?:\xA1\xA1))/,/g;
			my $ascii = '[\x00-\x7F]'; # 1�Х��� EUC-JPʸ��
			my $twoBytes = '(?:[\x8E\xA1-\xFE][\xA1-\xFE])'; # 2�Х��� EUC-JPʸ��	# comment
			my $threeBytes = '(?:\x8F[\xA1-\xFE][\xA1-\xFE])'; # 3�Х��� EUC-JPʸ��	# comment
			$keyword=~s/($ascii)($twoBytes|threeBytes)/$1,$2/g;
			$keyword=~s/($twoBytes|threeBytes)($ascii)/$1,$2/g;
			my @keyword;
			foreach(split(/,/,$keyword)) {
				push(@keyword,$_)
					unless(length($_) < $::auto_meta_minlength);
			}
			$keyword="";
			my $i=0;
			foreach(@keyword) {
				unless($keyword=~/\,$_/) {
					$keyword.="$_,";
					last if(++$i >= $::auto_meta_maxkeyword);
				}
			}
			$keyword=~s/,$//g;
			# UTF-8�Ǥ�EUC����UTF-8���᤹						# comment
		}
		$robots.=<<EOD;
<meta name="keywords" content="$keyword" />
EOD
	}
	return $robots;
}
1;
__DATA__
sub plugin_autometarobot_setup {
	return(
		ja=>'�������󥸥������ư�����������',
		en=>'Auto generation keyword for robot of search engine',
		require=>'',
		override=>'meta_robots',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/autometarobot/'
	);
}
__END__
