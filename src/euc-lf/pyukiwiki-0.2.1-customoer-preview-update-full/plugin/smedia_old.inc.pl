######################################################################
# smedia_old.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:14:47
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
#
# ����������ǥ����إ�󥯤���ץ饰����
#
######################################################################
# 2012/03/20 0.2.0-p4 : �����ѹ�
######################################################################
sub plugin_smedia_init {
# �ǥե���ȤΥ���������ǥ���
$smedia::share="twitter,facebook,google,mixi,livedoor"
	if(!defined($smedia::share));
$smedia::bookmark="hatena,yahoo,googleb,bookmark"
	if(!defined($smedia::bookmark));
$smedia::subscribe="yahoorss,googlerss,livedoorrss"
	if(!defined($smedia::subscribe));
# if you not setting mixikey, not display
# this is using mobile mail auth.
# https://mixi.jp/guide_developer.pl
$smedia::mixikey=""
	if(!defined($smedia::mixikey));
%smedia::array;
$smedia::array{twitter_username}=""
	if($smedia::array{twitter_username} eq "");
$smedia::array{twitter_follow}=0
	if($smedia::array{twitter_follow} eq "");
$smedia::array{gree_type}=0
	if($smedia::array{gree_type} eq "");
$smedia::array{gree_height}=20
	if($smedia::array{gree_height} eq "");
}
######################################################################
use strict;
$::plugin_smedia_loaded=0;
sub plugin_smedia_convert {
	return &plugin_smedia_inline(@_);
}
sub plugin_smedia_inline {
	my $argv = shift;
	my @argv=split(/,/,$argv);
	&plugin_smedia_init;
	if($ENV{HTTP_USER_AGENT}=~/MSIE\s(\d+)\.(\d+)/) {
		return ' ' if($1 <= 6);
	}
	if($ENV{HTTP_USER_AGENT}=~/FireFox\/(\d+)\.(\d+)\.(\d+)/) {
		return ' ' if($1 <= 1);
	}
	return ' ' if($::htmlmode eq "xhtml11");
	return ' '
		if($::form{cmd}=~/edit|admin/);
	my $bar="";
	my $args="";
	foreach(@argv) {
		s/"//g;
		if($_ eq "menubar" || $_ eq "sidebar") {
			$bar="menubar";
			next;
		} else {
			$args.="$_,";
		}
	}
	$args=~s/\,$//g;
	my $title=$::IN_TITLE ? $::IN_TITLE : $bar eq "menubar" ? $::pushedpage : $::form{mypage};
	$title.=" - $::wiki_title" if($::wiki_title ne '');
	my $url=&make_cookedurl($::pushedpage ne '' ? $::pushedpage : $::form{mypage});
	&getbasehref;
	my $base=$::basehref;
	my $rss="$base?cmd=rss10@{[$::_exec_plugined{lang} > 1 ? '&amp;lang=$::lang' : '']}";
	$base=~s/\/$//;
	$url="$base$url";
	return &plugin_smedia_html($url,$rss, $title, $args, $bar);
}
sub plugin_smedia_html {
	my($url,$rssurl,$title, $argv, $form)=@_;
	my @argv=split(/,/,$argv);
	&plugin_smedia_init;
	return ' ' if($::plugin_smedia_loaded);
	$::plugin_smedia_loaded++;
	$::IN_JSHEADVALUE.=<<EOM;
var smedia_share="$smedia::share";smedia_bookmark="$smedia::bookmark";smedia_subscribe="$smedia::subscribe";smedia_mixikey="$smedia::mixikey";
EOM
	$::IN_JSHEADVALUE.=<<EOM;
var smediaarray=new Array();
EOM
	foreach(keys %smedia::array) {
		$::IN_JSHEADVALUE.=<<EOM;
smediaarray["$_"]="$smedia::array{$_}";
EOM
	}
	my $body=<<EOM;
<div id="smediabutton"></div>
EOM
	$::IN_JSHEAD.=<<EOM;
smedia_init("$url","$rssurl","$title","$argv","$form");
EOM
	return $body;
	my $bar=0;
	foreach(@argv) {
		my($l,$r)=split(/=/,$_);
		if($l=~/^twitter\-(.+)/) {
			my $v=$1;
			if($v=~/data-via|data-text|data-related|data-hashtags|data-lang|data-url/) {
				$smedia::twitter{$v}=$r;
			}
		} elsif($l=~/^facebook\-(.+)/) {
			my $v=$1;
			if($v=~/data-href/) {
				$smedia::facebook{$v}=$r;
			}
		} elsif($l=~/^hatena\-(.+)/) {
			my $v=$1;
			if($v=~/href/) {
				$smedia::hatena{"url"}=$r;
			} elsif($v=~/title/) {
				$smedia::hatena{"title"}=$r;
			}
		}
	}
	my $out;
	my $class=$::form{form} eq "menubar" ? "smediamenubar" : "smedia";
	$out=qq(<div class="$class"><ul class="$class">);
	foreach(split(/,/,$smedia::default)) {
		if($_ eq '') {
			$out.="</tr></table><table><tr>";
		} else {
			$_=~s/\+//g;
			$out.=qq(<li class="$class\_$_">);
			$out.=&plugin_smedia_htmlout($_);
			$out.=qq(</li>);
		}
	}
	$out.="</ul></div>\n";
	return $out;
}
1;
__END__
