######################################################################
# wiki_skin.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
use Nana::ImageSize;
sub _skinex {
	my ($pagename, $body, $is_page, $pageplugin) = @_;
	my $bodyclass = "normal";
	my $editable = 0;
	my $admineditable = 0;
	my ($page,$msg)=split(/\t/,$pagename);
	$pageplugin+=0;
	$::pageplugin+=0;
	if($::form{refer} eq '' && &is_frozen($page) || &is_exist_page($::form{refer}) && &is_frozen($::form{refer})) {
		$admineditable = 1;
		$bodyclass = "frozen";
	} elsif($::form{refer} eq '' && &is_editable($page) || &is_exist_page($::form{refer}) && &is_editable($::form{refer})) {
		$admineditable = 1;
		$editable = 1;
		if(!&is_exist_page($page) && $is_page) {
			$page=$pagename=$::FrontPage;
			if($::form{mypreview_cancel} ne '' || $::form{mypreview_blogcancel} ne '') {
				if(&is_exist_page($::form{refer}) && $::form{refer} ne '') {
					$page=$pagename=$::form{refer};
				}
			}
			$body=&text_to_html($::database{$pagename});
			$is_page=1;
			$admineditable=1;
			$editable=&is_frozen($pagename) ? 1 : 0;
		}
	}
	&makenavigator($::form{mypage} ne $page ? $::form{mypage} : $page,$is_page,$editable,$admineditable)
		if($::disable_navigator eq 0);
	# last_modifiedのHTML生成								# comment
	if ($::last_modified != 0) {	# v0.0.9
		$lastmod = &date($::lastmod_format, ($::database{"__update__" . $::form{mypage}}));
	}
	if($::IN_META_ROBOTS eq '') {
		$::IN_HEAD.=&meta_robots($::form{cmd},$pagename,$body);
	} else {
		$::IN_HEAD.=$::IN_META_ROBOTS;
	}
	my $output_mime = $::htmlmode eq "xhtml11"
		&& $ENV{'HTTP_ACCEPT'}=~ m!application/xhtml\+xml!
		&& &is_no_xhtml(1) eq 0
		? 'application/xhtml+xml' : 'text/html';
	$::HTTP_HEADER=&http_header("Content-type: $output_mime; charset=$::charset", $::HTTP_HEADER);
	&escapeoff($::use_escapeoff);
	if(!-r $::skin_file) {
		&print_error("Can't read $::skin_file");
	}
	require $::skin_file;
	foreach("rss10", "rss20", "atom") {
		$::IN_HEAD.=<<EOM if($::rss_lines>0 && $::IN_HEAD!~/rss\+xml/ && $::rssenable{$_} eq 1);
<link rel="alternate" type="application/rss+xml" title="RSS" href="?cmd=rss&amp;@{[$_ eq "rss10" ? "ver=1.0" : $_ eq "rss20" ? "ver=2.0" : $_ eq "atom" ? "ver=atom" : "ver="]}@{[$_exec_plugined{lang} > 1 ? "&amp;lang=$::lang" : ""]}" />
EOM
	}
	my $body=&skin($pagename, $body, $is_page, $bodyclass, $editable, $admineditable, $::basehref,$lastmod);
	$body=&_db($body);
	if($::lang eq 'ja' && $::defaultcode ne $::kanjicode) {
		$body=&code_convert(\$body, $::kanjicode);
	}
	&content_output($::HTTP_HEADER, $body);
}
sub _maketitle {
	my($page, $message)=@_;
	my $title;
	my $title_tag;
	my $escapedpage = &htmlspecialchars($page);
	if($::wiki_title ne '') {
		$title="$::wiki_title";
	}
	if($page eq '') {
		if($title eq '') {
			$title_tag="$message";
		} else {
			$title_tag="$message - $title";
		}
	} else {
		if($::IN_TITLE eq '') {
			if($title eq '') {
				$title_tag="$escapedpage";
			} else {
				$title_tag="$escapedpage - $title";
			}
		} else {
			if($::IN_TITLE=~/\t/) {
				$::IN_TITLE=~s/\t//;
				$title_tag="$escapedpage - $::IN_TITLE - $title";
			} else {
				$title_tag="$::IN_TITLE - $title";
			}
		}
	}
	return($title, $title_tag);
}
sub _convtime {
	my $buf;
	if($::enable_last) {
		$buf.="Powered by Perl $]";
		if($::enable_last_os) {
			my $os=ucfirst($^O);
			$os=~s/bsd/BSD/;
			$buf.= " and $os";
		}
		if($::enable_convtime) {
			$buf.=" HTML convert time to ";
			my $convtime;
			eval {
				$convtime=Time::HiRes::tv_interval(
						$::_conv_start_hires,
						[Time::HiRes::gettimeofday]);
			};
			if(!$convtime) {
				$buf.=sprintf("%.3f sec",
					(times)[0] - $::_conv_start);
			} else {
				$buf.=sprintf("%.3f sec.", $convtime);
			}
		}
		if($gzip::header ne '') {
			$buf.=" Compressed";
		}
		return $buf;
	}
}
sub skinsubpage {
	my @pages=@_;
	my %body;
	my $mypage=$::form{mypage};
	foreach my $page(@pages) {
		$::pushedpage=$::form{mypage};
		$::form{mypage}=$page;
		$body{$page}=$::body{$page}
					. &print_content($::database{$page}, $::pushedpage)
			if(&is_exist_page($page));
		$::form{mypage}=$::pushedpage;
	}
	$::pushedpage="";
	$::form{mypage}=$mypage;
	return %body;
}
sub _skinhead {
	my($page, $body)=@_;
	# add v0.2.1
	$::IN_HEAD=<<EOM;
$::IN_CSSFILES
$::IN_JSLOADER
$::IN_HEAD
EOM
	if($::IN_CSSHEAD) {
		$::IN_HEAD.=<<EOM;
<style type="text/css"><!--
$::IN_CSSHEAD
//--></style>
EOM
	}
	$::IN_HEAD.=<<EOM;
<script type="text/javascript"><!--
var pyukiwiki=$::versionnumber;
@{[$::IN_JSFILES ne "" ? "loadScript($::IN_JSFILES);\n" : ""]}
$::IN_JSHEADVALUE
function initfunction() {
$::IN_JSHEAD
}
//--></script>
EOM
	return $body;
}
sub _makenavigator {
	my($pagename,$is_page,$editable,$admineditable)=@_;
	my($page,$message,$errmessage)=split(/\t/,$pagename);
	my $cookedpage = &encode($page);
	# リンクの設定											# comment
	my $refer=&encode($::form{refer} eq '' ? $::form{mypage} : $::form{refer});
	my $mypage=&encode($::form{refer} eq '' ? $page : $::form{refer});
	&makenavigator_sub1("newpage","refer",$mypage);
	if($::form{refer} eq '' || &is_exist_page($::form{refer})) {
		&makenavigator_sub1("edit","mypage",$mypage)
			if($editable);
		if($admineditable) {
			&makenavigator_sub1("adminedit","mypage",$mypage);
			&makenavigator_sub1("diff","mypage",$mypage);
			if($::useBackUp eq 1) {
				&makenavigator_sub1("backup","mypage",$mypage);
			}
			&makenavigator_sub1("attach","mypage",$mypage) if($::file_uploads > 0);
			&makenavigator_sub1("rename","refer",$mypage);
		}
	}
	&makenavigator_sub1("sitemap","refer",$refer)
		if($::use_Sitemap eq 1 && -f "$::plugin_dir/sitemap.inc.pl");
	&makenavigator_sub1("list","refer",$refer);
	&makenavigator_sub1("search","refer",$refer);
	&makenavigator_sub1("recent","refer",$refer);
	&makenavigator_sub2("top",$::FrontPage);
	&makenavigator_sub2("reload",$::form{refer} eq '' ? $page : $::form{refer});
	if($::use_HelpPlugin eq 0) {
		&makenavigator_sub2("help",$::resource{help});
	} else {
		$::resource{helpbutton}=$::resource{help};
		&makenavigator_sub1("help","refer",$refer);
	}
	&makenavigator_sub3("rss10", "rss", "ver=1.0")
		if($::rssenable{rss10} eq 1);
	&makenavigator_sub3("rss20", "rss", "ver=2.0")
		if($::rssenable{rss20} eq 1);
	&makenavigator_sub3("atom", "rss", "ver=atom")
		if($::rssenable{atom} eq 1);
	&makenavigator_sub3("opml")
		if($::rssenable{opml} eq 1);
	# リンクの並び順を設定									# comment
	my @naviindex;
	my $backupnavi="backup" if($::useBackUp);
	if($::naviindex eq 0) {
		@naviindex=(
			"reload","","newpage","edit","adminedit","diff",$backupnavi,"attach","",
			"top","list","sitemap","search","recent","help",
			"rss10","rss20","atom","opml");
	} else {
		if($::useBackUp) {
			@naviindex=(
				"top","","edit","adminedit","diff",$backupnavi,"attach","reload","",
				"newpage","list","sitemap","search","recent","help",
				"rss10","rss20","atom","opml");
		} else {
			@naviindex=(
				"top","","edit","adminedit","diff",$backupnavi,"attach","reload","",
				"newpage","list","sitemap","search","recent","help",
				"rss10","rss20","atom","opml");
		}
	}
	# 追加リンクの設定										# comment
	foreach(@naviindex) {
		foreach my $addnavi(@::addnavi) {
			my($index,$before,$next)=split(/:/,$addnavi);
			push(@::navi,$index) if($_ eq $before && $before ne '');
		}
		push(@::navi,$_) if($::navi{"$_\_url"} ne '' || $::navi{"$_\_html"} ne ''|| $_ eq '');
		foreach my $addnavi(@::addnavi) {
			my($index,$before,$next)=split(/:/,$addnavi);
			push(@::navi,$index) if($_ eq $next && $next ne '');
		}
	}
	# ヘルプを使用しない場合								# comment
	my @navitemp;
	if($::no_HelpLink eq 1) {
		foreach (@::navi) {
			push(@navitemp,$_)
				if($_ ne "help");
		}
		@::navi=@navitemp;
	}
}
sub _makenavigator_sub1 {
	my($t,$r,$p)=@_;
	if($t ne '') {
		if($::navi{$t."_url"} eq '') {
			$::navi{$t."_title"}=$::resource{$t."thispage"};
			$::navi{$t."_title"}=$::resource{$t."button"}
				if($::navi{$t."_title"} eq '');
			$::navi{$t."_url"}="$::script?cmd=$t&amp;$r=$p";
			$::navi{$t."_name"}=$::resource{$t."button"}
				if($t!~/rename/);
			$::navi{$t."_type"}="edit";
		}
	}
}
sub _makenavigator_sub2 {
	my($t,$p)=@_;
	if(    $t eq "top"
		|| $t eq "help" && &is_exist_page($p)
		|| &is_exist_page($p) && (&is_exist_page($::form{refer}) || $::form{refer} eq '')) {
		if($::navi{$t."_url"} eq '') {
			$::navi{$t."_url"}=&make_cookedurl(&encode(@{[
				&is_exist_page($p) ? $p :
				&is_exist_page($::form{refer}) ? $::form{refer} :
				$::FrontPage]}));
			$::navi{$t."_name"}=$::resource{$t};
			$::navi{$t."_type"}="page";
		}
	}
}
sub _makenavigator_sub3 {
	my($t, $r, $arg)=@_;
	if(-f "$::plugin_dir/$t.inc.pl"
	 ||-f "$::plugin_dir/$r.inc.pl") {
		if($::navi{$t."_url"} eq '') {
			if($r eq "") {
				$::navi{"$t\_url"}="$::script?cmd=$t"
					. ($_exec_plugined{lang} > 1 ? "&amp;lang=$::lang" : "");
			} else {
				$::navi{"$t\_url"}="$::script?cmd=$r&amp;$arg"
					. ($_exec_plugined{lang} > 1 ? "&amp;lang=$::lang" : "");
			}
			$::navi{"$t\_title"}=$::resource{$t . "button"};
			if(-r "$::image_dir/$t.png") {
				($::navi{"$t\_width"}, $::navi{"$t\_height"})
					= Nana::ImageSize::imgsize("$::image_dir/$t.png");
				$::navi{$t."_type"}="rsslink";
			} else {
				$::navi{$t."_type"}="rsslinkspan";
			}
		}
	}
}
sub _navi_toolbar {
	my $body;
	foreach $name (@::navi) {
		if($name eq '') {
			$body.=" &nbsp; ";
		} else {
			if($::toolbar eq 2) {
				$body.=<<EOD;
<a title="@{[$::navi{"$name\_title"} eq '' ? $::navi{"$name\_name"} : $::navi{"$name\_title"}]}" href="$::navi{"$name\_url"}" class="icntool" id="icn_$name"><span>@{[$::navi{"$name\_title"} eq '' ? $::navi{"$name\_name"} : $::navi{"$name\_title"}]}</span></a>
EOD
			}
		}
	}
	$body;
}
sub _skin_footer {
	my ($skinfooterbody)=@_;
	my $htmlbody;
	my $footerbody;
	if($::lang eq 'ja') {
		$footerbody=<<EOD;
@{[$::wiki_title ne '' ? qq(''[[$::wiki_title>$basehref]]'' ) : '']}Modified by [[$::modifier>$::modifierlink]]~
\$skinfooterbody
~
''[[PyukiWiki $::version>http://pyukiwiki.info/]]''
Copyright&copy; 2004-2015 by Nekyo, [[PyukiWiki Developers Team>http://pyukiwiki.info/]]
License is [[GPL>http://sfjp.jp/projects/opensource/wiki/GPLv3_Info]], [[Artistic>http://www.opensource.jp/artistic/ja/Artistic-ja.html]]~
Based on "[[YukiWiki>http://www.hyuki.com/yukiwiki/]]" 2.1.0 by [[yuki>http://www.hyuki.com/]]
and [[PukiWiki>http://pukiwiki.sfjp.jp/]] by [[PukiWiki Developers Term>http://pukiwiki.sfjp.jp/]]~
EOD
	} else {
	# lang=en and/or other
		$footerbody=<<EOD;
@{[$::wiki_title ne '' ? qq(''[[$::wiki_title>$basehref]]'' ) : '']}Modified by [[$::modifier>$::modifierlink]]
\$skinfooterbody
~
''[[PyukiWiki $::version>http://pyukiwiki.info/]]''
Copyright&copy; 2004-2015 by Nekyo, [[PyukiWiki Developers Team>http://pyukiwiki.info/]]
License is [[GPL>http://www.gnu.org/licenses/gpl.html]], [[Artistic>A]]~
Based on "[[YukiWiki>http://www.hyuki.com/yukiwiki/]]" 2.1.0 by [[yuki>http://www.hyuki.com/]]
and [[PukiWiki>http://pukiwiki.sfjp.jp/]] by [[PukiWiki Developers Term>http://pukiwiki.sfjp.jp/]]~
EOD
	}
	$footerbody= &text_to_html($footerbody);
	$footerbody=~s/\$skinfooterbody/$skinfooterbody/;
	$footerbody=~s/(<p>|<\/p>)//g;
	$htmlbody.= $footerbody;
	$htmlbody;
}
1;
