######################################################################
# servererror.inc.pl - This is PyukiWiki yet another Wiki clone
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
# サーバー上のエラーをキャッチするものです。
# .htaccessの設定で起動します。
######################################################################
sub plugin_servererror_action {
	my $redirect_status;
	my $code=$::form{code};
	$redirect_status=$ENV{REDIRECT_STATUS};
	if($code+0 >= 400 && $code+0 < 600) {
		$redirect_status=$code;
		$ENV{REDIRECT_STATUS}=$code;
	}
	if($redirect_status + 0 < 400) {
		$ENV{REDIRECT_STATUS}=500;
		$ENV{REDIRECT_URL}=$ENV{REQUEST_URI};
		$ENV{REDIRECT_REQUEST_METHOD}=$ENV{REQUEST_METHOD};
	}
	if($ENV{REDIRECT_URL}=~/servererror/) {
		$ENV{REDIRECT_URL}=$ENV{HTTP_REFERER};
	}
	if($::resource{"servererror_plugin_" . $ENV{REDIRECT_STATUS} . "_header"} eq '') {
		$redirect_status=999;
	} else {
		$redirect_status=$ENV{REDIRECT_STATUS};
	}
	my $rfcmsg;
	my $rfcurl;
	my $commonmsg;
	if($ENV{HTTP_REFERER} eq '') {
		$ENV{HTTP_REFERER}=$::script;
	}
	if($::resource{'servererror_plugin_' . $redirect_status . '_rfc'} ne '') {
		$rfcurl=$::resource{servererror_plugin_rfcurl};
		$rfcurl=~s/\$1/$::resource{'servererror_plugin_' . $redirect_status . '_rfc'}/gex;
		$rfcmsg=$::resource{servererror_plugin_rfcmsg};
		$rfcmsg=~s/\$1/$::resource{'servererror_plugin_' . $redirect_status . '_rfc'}/gex;
		$rfcmsg=~s/\$2/$rfcurl/g;
	}
	$commonmsg=&plugin_servererror_msg("commonmsg");
	if($::modifier_mail eq '') {
		$commonmsg=~s/\$1//g;
	} else {
		$ENV{modifier_mail}=$::modifier_mail;
		$commonmsg=~s/\$1/&plugin_servererror_msg("modifier_mail");/gex;
	}
	my $host = "$ENV{'HTTP_HOST'}";
	if (($ENV{'https'} =~ /on/i) || ($ENV{'SERVER_PORT'} eq '443')) {
		$host = 'https://' . $host;
	} else {
		$host = 'http://' . $host;
		$host .= ":$ENV{'SERVER_PORT'}" if ($ENV{'SERVER_PORT'} ne '80');
	}
	if($ENV{REDIRECT_ERROR_NOTES} ne '') {
		$ENV{REDIRECT_ERROR_NOTES}=~s/<[Bb][Rr](.*?)/>\n/g;
		$ENV{REDIRECT_ERROR_NOTES}=~s/\n/~\n>>>/g;
		$notes=">>$::resource{servererror_plugin_errormessage}~\n>>>"
			. $ENV{REDIRECT_ERROR_NOTES};
	}
	$body=<<EOM;
*$::resource{"servererror_plugin_" . $redirect_status . "_title"}
@{[&plugin_servererror_msg("$redirect_status" . "_msg")]} ~
~
$commonmsg ~
~
$notes~
@{[$rfcmsg ne '' ? ">>$rfcmsg" : '']}
----
&size(20){''Error $ENV{REDIRECT_STATUS}''};~
>'''[[$ENV{HTTP_HOST}>$::FrontPage]]'''~
>'''@{[&get_now]}'''~
>'''$ENV{SERVER_SOFTWARE} on Perl $]'''~
>'''$ENV{REDIRECT_REQUEST_METHOD} $host$ENV{REDIRECT_URL}'''~
>'''from $ENV{REMOTE_ADDR} $ENV{REMOTE_HOST}'''
EOM
	$body=&text_to_html($body,0);
	my $http_header.=qq(Status: $ENV{REDIRECT_STATUS} $::resource{"servererror_plugin_" . $redirect_status . "_header"}\n);
	return ('msg' => "\t$ENV{REDIRECT_STATUS} $::resource{'servererror_plugin_' . $redirect_status . '_header'}", 'body' => $body, 'http_header' => $http_header, 'notviewmenu' => 1);
}
sub plugin_servererror_msg {
	my ($msg)=@_;
	my $text;
	$text=$::resource{"servererror_plugin_$msg"};
	$text=~s/\//~\n/g;
	$text=~s/\$ENV\{(.*?)\}/$ENV{$1}/g;
	$text=~s/\$FRONTPAGE/$::FrontPage/ge;
	return "$text";
}
1;
__END__
