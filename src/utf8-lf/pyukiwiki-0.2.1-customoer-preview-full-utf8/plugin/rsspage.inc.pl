######################################################################
# rsspage.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# descriptionの行数を指定
$rsspage::description_line=5
	if(!defined($rsspage::description_line));
######################################################################
use Nana::RSS;
use Nana::Cache;
use Time::Local;
sub plugin_rsspage_date {
	my($dt, $tm)=@_;
	$gmt=&gettz;
	my $date = $dt . "T" . $tm . sprintf("+%02d:00", $gmt);
	$date;
}
sub plugin_rsspage_inline {
	my $body;
	&getbasehref;
	foreach("RSS 1.0,1.0,rss10", "RSS 2.0,2.0,rss20", "ATOM,atom,atom") {
		my ($name, $ver, $fn)=split(/,/,$_);
		if(-r "$::image_dir/$fn.png") {
			my $lang=$_exec_plugined{lang} > 1 ? "&amp;lang=$::lang" : "";
			$body.=<<EOM;
<a href="$::basehref?cmd=rsspage&amp;mypage=@{[&encode($::form{mypage})]}&amp;ver=$ver@{[$_exec_plugined{lang} > 1 ? qq(&amp;lang=$::lang) : qq()]}" title="$name"><img src="$::image_url/$fn.png" alt="$name" /></a>
EOM
		}
	}
	return $body;
}
sub plugin_rsspage_convert {
	my ($mode) = split(/,/, shift);
	my $cache=new Nana::Cache (
		ext=>"showrss",
		files=>1000,
		dir=>$::cache_dir,
		size=>200000,
		use=>1,
		expire=>3600,
	);
	my $file=&dbmname($::form{mypage});
	if(lc $mode eq 'delete') {
		$cache->delete($file);
		return ' ';
	}
	my $buf=&plugin_rsspage_makerss($::form{mypage});
	$buf=~s/[\xd\xa]//g;
	$cache->write($file,&replace($buf));
	$::IN_HEAD.=<<EOM if($::rss_lines>0);
<link rel="alternate" type="application/rss+xml" title="RSS" href="?cmd=rsspage&amp;mypage=@{[&encode($::form{mypage})]}@{[$_exec_plugined{lang} > 1 ? "&amp;lang=$::lang" : ""]}" />
EOM
	return ' ';
}
sub replace {
	my ($xmlStream) = @_;
	$xmlStream =~ s/<\?(.*)\?>//g;
	$xmlStream =~ s/<rdf:RDF(.*?)>/<rdf:RDF>/g;
	$xmlStream =~ s/<rss(.*?)>/<rss>/g;
	$xmlStream =~ s/<channel(.*?)>/<channel>/g;
	$xmlStream =~ s/<item(.*?)>/<item>/g;
	$xmlStream =~ s/<content:encoded>(.*?)<\/content:encoded>//g;
	$xmlStream =~ s/\ *\/>/\/>/g;
	$xmlStream =~ s/<([^<>\ ]*)\ ([^<>]*)\/>/<$1>$2<\/$1>/g;
	$xmlStream =~ s/<([^<>\/]*)\/>/<$1><\/$1>/g;
	return $xmlStream;
}
sub plugin_rsspage_makerss {
	my($page)=@_;
	# 言語別の設定											# comment
	if($::_exec_plugined{lang} > 1) {
		$::modifier_rss_link=$::modifier_rss_link{$::lang} ne '' ? $::modifier_rss_link{$::lang}: $::modifier_rss_link ne '' ? $::modifier_rss_link : $::basehref;
	} else {
		$::modifier_rss_link=$::modifier_rss_link ne '' ? $::modifier_rss_link : $::basehref;
	}
	my $data=$::database{$page};
	# モードを取得											# comment
	my $option;
	foreach (split(/\n/, $data)) {
		if(/$::embed_plugin/) {
			if($1 eq 'rsspage' || $1 eq 'rss10page') {
				$option=$3;
				last;
			}
		}
	}
	if($option!~/[-*]/) {
		&print_error("rsspage:not setting selection target<br />Usage : #rsspage([-*] or delete);");
	}
	$option=~s/(.)/'\\x' . unpack('H2', $1)/eg;
	my $count = 0;
	my $lines=0;
	my $gmt;
	my $date;
	my $defaultlink=$::modifier_rss_link . '?' . &encode($page);
	my $link;
	my $escaped_title;
	my $version=$::form{ver};
	$version="1.0" if($version eq "");
	my $rss = new Nana::RSS(
		version => $version,
		encoding => $::charset,
	);
	$rss->channel(
		title => "$::modifier_rss_title - $page",
		link  => $link,
		description => &get_subjectline($page)
	);
	# 内容を取得												# comment
	foreach my $line(split(/\n/, $data)) {
		last if ($count > $::rss_lines + 1);
		if($line=~/^$option\s*(\d\d\d\d\-\d\d\-\d\d)\(.+\) (\d\d:\d\d:\d\d)\s*\[\[(.*)\]\]/) {
			if($lines) {
				&plugin_rsspage_additem($rss,$escaped_title,$link,$description,$date);
				$description='';
			}
			$date=&plugin_rsspage_date($1, $2);
			my $tmp=&make_link($3);
			$escaped_title=$tmp;
			$escaped_title=~s/<.*?>//g;
			$escaped_title=~s/~$//g;
			$link=$tmp;
			$link=~s/.*href="(.+?)".*/$1/g;
			$link=~s/^\///g;
			$link="$basehref$link" if($link!~/$::isurl/);
			$count++;
			$lines=1;
		} elsif($line=~/^$option\s*(\d\d\d\d\-\d\d\-\d\d)\(.+\) (\d\d:\d\d:\d\d)\s*(.*)/) {
			if($lines) {
				&plugin_rsspage_additem($rss,$escaped_title,$link,$description,$date);
				$description='';
			}
			$link=$defaultlink;
			$date=&plugin_rsspage_date($1, $2);
			$escaped_title=$3;
			$escaped_title=~s/~$//g;
			$count++;
			$lines=1;
		} elsif($line=~/^[ \*\-: |]/) {
			&plugin_rsspage_additem($rss,$escaped_title,$link,$description,$date)
				if($lines);
			$lines=0;
			$count++;
			$description='';
		} elsif($lines) {
			my $tmp=&text_to_html($line);
			$tmp=~s/[\xd\xa]//g;
			$tmp=~s/<.*?>//g;
			$tmp=&trim($tmp);
			next if($tmp eq '');
			$description.=$lines eq 1 ? $tmp : "\n$tmp";
			if($description ne '' && $lines++ >= $::rss_lines) {
				$lines=0;
				&plugin_rsspage_additem($rss,$escaped_title,$link,$description,$date);
				$count++;
				$description='';
			}
		}
	}
	my $body=$rss->as_string;
	return $body;
}
%::rsspage_dates;
sub plugin_rsspage_additem {
	my($rss,$escaped_title,$link,$description,$date)=@_;
	if($escaped_title eq '') {
		$escaped_title=$description;
		$escaped_title=~s/\n.*//g;
		$escaped_title=~s/<br \/>//g;
	}
	$escaped_title=&trim($escaped_title);
	$rss->add_item(
		title => $escaped_title,
		link  => $link,
		description => $description,
		dc_date => $date
	);
}
sub plugin_rsspage_action {
	if(!&is_exist_page($::form{mypage})) {
		&print_error("Page not found : " . $::form{mypage});
	}
	# print RSS information (as XML).						# comment
	my $body=&plugin_rsspage_makerss($::form{mypage});
	if($::lang eq 'ja' && $::defaultcode ne $::kanjicode) {
		$body=&code_convert(\$body,   $::kanjicode);
	}
	print &http_header(
		"Content-type: text/xml; charset=$::charset", $::HTTP_HEADER);
	&compress_output($body . &exec_explugin_last);
	&close_db;
	exit;
}
1;
__END__
