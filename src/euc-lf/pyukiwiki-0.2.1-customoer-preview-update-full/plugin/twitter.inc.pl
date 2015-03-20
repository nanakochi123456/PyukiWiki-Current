######################################################################
# twitter.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:41:28
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
# usage: #twitter(username or #hashtag[, header name)
######################################################################
# 2012/09/29 changes: support multi view
# 2012/04/09 changes: not using jquery and bug fix
# 2012/03/21 changes: support new jquery twitter client
######################################################################
# visit http://twitstat.us/
# thanks to #jishin_power project
# can't use Nana::HTTP's inline module, please install LWP::UserAgent
# (now twitter or IE9 bug)
######################################################################
$twitter::newclient=1			# 私家版 twitterクライアントを使用する
	if(!defined($twitter::newclient));
if(!defined($twitter::title)) {
	if($::lang eq "ja") {
		$twitter::title="\$1のツィート";
	} else {
		$twitter::title="Tweet of \$1";
	}
}
$twitter::max=7
	if(!defined($twitter::max));
$twitter::border_color="#434343"
	if(!defined($twitter::border_color));
$twitter::header_background="#434343"
	if(!defined($twitter::header_background));
$twitter::header_font_color="#ffffff"
	if(!defined($twitter::header_font_color));
$twitter::header_link_color="#ffffff"
	if(!defined($twitter::header_font_color));
$twitter::content_background_color="#e1e1e1"
	if(!defined($twitter::content_background_color));
$twitter::content_font_color="#333333"
	if(!defined($twitter::content_font_color));
$twitter::link_color="#307ace"
	if(!defined($twitter::link_color));
$twitter::width="1000"
	if(!defined($twitter::width));
######################################################################
$::plugin_twitter_count=0;
sub plugin_twitter_convert {
	my $arg=shift;
	my ($keywords,$title)=split(/,/,$arg);
	if($title eq '') {
		$title=$twitter::title;
		$title=~s/\$1/$keywords/g;
	}
	my $flag=$::use_popup if($flag eq '');
	my $popup_allow=$::setting_cookie{popup} ne '' ? $::setting_cookie{popup}
					: $flag+0 ? 1 : 0;
	if($::plugin_twitter_count ne 0 && $twitter::newclient eq 0) {
		return <<EOM;
<div class="error">Can't insert more twitter plugin of this page</div>
EOM
	}
	$::plugin_twitter_count++;
	if($twitter::newclient) {
		$::IN_HEAD.=<<EOM;
@{[&jscss_include("twitter:tw")]}
EOM
		my $track=$::_exec_plugined{logs} || $::_exec_plugined{linktrack}
			? 1 : 0;
		$::IN_JSHEAD.=<<EOM;
twitwindow("twitwindow$::plugin_twitter_count", "$keywords","$title", $twitter::max, "$twitter::border_color", "$twitter::header_background", "$twitter::header_font_color", "$twitter::header_link_color", "$twitter::content_background_color", "$twitter::content_font_color", "$twitter::link_color", $twitter::width ,$popup_allow, $track);
EOM
		return <<EOM;
<p id="twitwindow$::plugin_twitter_count"></p>
EOM
	}
	$::IN_HEAD.=<<EOM;
@{[&jscss_include("twitstat:twitstat")]}
EOM
		$::IN_JSHEAD.=<<EOM;
twitstat.badge.init({
	badge_container: "twitstat_badge_$::plugin_twitter_count",
	title: "$title",
	keywords: "$keywords",
	max: $twitter::max,
	border_color: "$twitter::border_color",
	header_background: "$twitter::header_background",
	header_font_color: "$twitter::header_font_color",
	content_background_color: "$twitter::content_background_color",
	content_font_color: "$twitter::content_font_color",
	link_color: "$twitter::link_color",
	width: $twitter::width,
	popup: $popup_allow
});
EOM
	return <<EOM;
<div id="twitter">
<div class="twitstatus_badge_container" id="twitstat_badge\_$::plugin_twitter_count"></div>
</div>
EOM
}
sub plugin_twitter_action {
	&load_module("Nana::HTTP");
	my $env;
	foreach(keys %::form) {
		if($_ eq "rpp" || $_ eq "callback" || $_ eq "q" || $_ eq "near" || $_ eq "within" || $_ eq "units" || $_ eq "since_id") {
			if($_ eq "q") {
				$env.="$_=@{[&encode($::form{$_})]}&";
			} else {
				$env.="$_=$::form{$_}&";
			}
		}
	}
	$env=~s/\&$//g;
	my $http=new Nana::HTTP('plugin'=>"twitter");
	my $searchurl="http://search.twitter.com/search.json";
	my $uri="$searchurl?$env";
	my ($result, $stream) = $http->get($uri);
	if($result eq 0) {
		print &http_header("Content-type: application/json");
		print $stream;
	} else {
		print &http_header("Content-type: text/plain");
		print "Cant get '$uri'\n";
	}
	exit;
}
1;
__END__
