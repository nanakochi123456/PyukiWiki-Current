######################################################################
# logs.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'logs.inc.cgi'
######################################################################
# �ǥ��쥯�ȥ�
$logs::directory="$::data_home/logs"
	if(!defined($logs::directory));
# ������¸
$logs::compress=0
	if(!defined($logs::compress));
$logs::refresh=1
	if(!defined($linktrack::refresh));
$logs::date_format="Y-m-d D"
	if(!defined($logs::date_format));
$logs::time_format="H:i:s"
	if(!defined($logs::time_format));
######################################################################
use strict;
use Nana::YukiWikiDB;
use Nana::YukiWikiDB_GZIP;
%::logbase;
@logs::allowcmd=(
	"read",
	"write",
	"article:POST",
	"comment:POST",
	"pcomment:POST",
	"attach",
	"bugtrack:POST",
	"adminedit:POST",
	"edit:POST",
	"vote:POST",
	"search:POST",
);
# Initlize														# comment
sub plugin_logs_init {
	&exec_explugin_sub("lang");
	&exec_explugin_sub("authadmin_cookie");
	&exec_explugin_sub("urlhack");
	&plugin_logs_do($::form{cmd}, $::form{mypage});
	return('init'=>1);
}
sub plugin_logs_do {
	my($cmd, $page)=@_;
	my $flg=0;
	foreach(@logs::allowcmd) {
		my ($t,$m)=split(/:/,$_);
		$flg=1 if($cmd eq $t && $m eq "");
		$flg=1 if($cmd eq $t && $m eq "POST" && $ENV{REQUEST_METHOD} eq "POST");
	}
	return if($flg eq 0);
	if($cmd eq "attach") {
		$cmd="$cmd-$::form{pcmd}";
		$page="$page<>$::form{file}";
	} elsif($cmd eq "search") {
		$page="$::form{type}<>$::form{mymsg}";
	}
	return if($page eq '');
	my $filename=&date("Y-m-d");
	&getremotehost;
	my $user=$::authadmin_cookie_user_name;
	my $logtxt=<<EOM;
$ENV{REMOTE_HOST} $ENV{REMOTE_ADDR}\t@{[&date($logs::date_format)]} @{[&date($logs::time_format)]}\t$user\t$ENV{REQUEST_METHOD}\t$cmd\t$::lang\t$page\t$ENV{HTTP_USER_AGENT}\t$ENV{HTTP_REFERER}
EOM
	&plugin_logs_add($filename, $logtxt);
}
sub plugin_logs_add {
	my ($filename, $text)=@_;
	my $err;
	my $err=&writechk($logs::directory);
	if($err ne '') {
		&print_error($err);
		exit;
	}
	if($logs::compress eq 1) {
		&dbopen_gz($logs::directory,\%::logbase);
	} else {
		&dbopen($logs::directory,\%::logbase);
	}
	$::logbase{$filename}.=$text;
	&dbclose(\%::logbase);
}
1;
__DATA__
	return(
		ja=>'��������������',
		en=>'Take access log',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/logs/'
	);
__END__
