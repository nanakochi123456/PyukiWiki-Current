######################################################################
# wiki.cgi - $Id$
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
##############################									# comment
#use Nana::YukiWikiDB;
$::modifier_dbtype = 'Nana::YukiWikiDB'
	if(!defined($::modifier_dbtype));
%::db_extention;
##############################
use CGI qw(:standard);
#use CGI::Carp qw(fatalsToBrowser);
use Nana::Carp;
use Time::Local;
##############################									# comment
# 2005.10.27 pochi: 自動リンク機能を拡張 ('?' | 'this' | '')	# comment
$::editchar = '?';
##############################									# comment
$::subject_delimiter = ' - ';
$::use_exists = 1;	# If you can use 'exists' method for your DB.	# comment
##############################									# comment
$::package = 'PyukiWiki';
 #$::version = '0.2.1-beta6';
$::version = '0.2.1-customoer-preview';
$::versionnumber=0 * 10000 + 21 * 100 + 5;
# 2005.12.19 pochi: mod_perlで実行可能に					# comment
# グローバル関数の定義										# comment
# moved 0.2.1 to wiki_sub.cgi (auto generate)				# comment
%::values=();
# カウンタの拡張子										# comment
$::counter_ext = '.count';
my $lastmod;			# v0.0.9
%::database;			# database						# comment
%::infobase;			# infobase						# comment
%::diffbase;			# diffbase						# comment
%::backupbase;			# backupbase#nocompact			# comment
%::resource;			# resource						# comment
%::form;				# form							# comment
%::interwiki;			# interwiki						# comment
$::pageplugin=0;		# is page editing plugin flag	# comment
%::_plugined;			# 1:Pyuki/2:Yuki/0:None			# comment
%::_exec_plugined;		# 2:Inited/1:Loaded/0:None		# comment
%::_exec_plugined_func;	# override functions			# comment
%::_exec_plugined_value;# override values				# comment
%::_module_loaded;		# perl module					# comment
%::_resource_loaded;	# module						# comment
@::navi=();				# default navigator link array	# comment
@::addnavi=();			# adding navigator link array	# comment
%::navi=();				# navigator link				# comment
%::dtd;					# dtd define					# comment
%::_urlescape;			# for &encode					# comment
%::_dbmname_encode;		# for &dbmname					# comment
%::_dbmname_decode;		# for &undbmname				# comment
%::_date_ampm;			# for &date						# comment
%::_date_ampm_locale;
%::_date_weekday;
%::_date_weekdaylength;
%::_date_weekday_locale;
%::_date_weekdaylength_locale;
$::HTTP_HEADER;			# http header							# comment
$::IN_HEAD;				# adding <head>~</head> from plugin		# comment
$::IN_JSHEADVALUE;		# adding <head>~</head> JavaScript		# comment
$::IN_JSHEAD;			# adding <head>~</head> JavaScript		# comment
$::IN_CSSHEAD;			# adding <head>~</head> CSS				# comment
$::IN_CSSFILES;			# adding <head>~</head> CSS				# comment
$::IN_JSFILES;			# adding <head>~</head> JavaScript		# comment
$::IN_JSLOADER;			# adding <head>~</head> JavaScript		# comment
$::IN_BODY;				# adding <body> tag from plugin			# comment
$::IN_TITLE;			# adding <title> tag from plugin		# comment
$::IN_META_ROBOTS;		# robots control						# comment
$::is_xhtml;			# XHTML Flag							# comment
$gzip_header;			# gzip commpression header				# comment
$explugin_last;			# Ex Plugin Last Exec Module			# comment
@::loaded_explugin;		# Loaded Ex Plugin						# comment
# 2006.1.30 pochi: 改行モードを設置								# comment
$::lfmode;
$::escapeoff_exec;		# Disable ESC key for IE				# comment
$::linesave=0;			# save lines for plugin flag			# comment
$::linedata;			# save lines for plugin					# comment
$::eom_string;			# end of message for plugin				# comment
$::exec_inlinefunc;		# exec inline func						# comment
%::jscss_included;		# Load JavaScript and CSS				# comment
@::notes = ();
# iniファイル読み込み											# comment
#$::ini_file = 'pyukiwiki.ini.cgi' if($::ini_file eq '');		# comment
#require $::ini_file;											# comment
#require $::setup_file if (-r $::setup_file);					# comment
## スキンファイルの初期化										# comment
#&skin_init;													# comment
##############################									# comment
# WikiName														# comment
$::wiki_name = '\b([A-Z][a-z]+[A-Z][a-z]+)\b';
# [[BracketName]]												# comment
$::bracket_name ='\[\[((?!\[)[^\]]+?)\]\]';
# InterWiki定義													# comment
$::interwiki_definition = '\[((?!\[)\S+?)\ (\S+?)\](?!\])';
$::interwiki_definition2 = '\[((?!\[)\S+?)\ (\S+?)\](?!\])\ (utf8|euc|sjis|yw|asis|raw|moin)';
# InterWikiのリンク												# comment
$::interwiki_name1 = '([^:]+):([^:].*)';
$::interwiki_name2 = '([^:]+):([^:#].*?)(#.*)?';
# URLの正規表現													# comment
if($::useFileScheme eq 1) {
	$::isurl=qq(s?(?:(?:(?:https?|ftp|news)://)|(?:file:[/\][/\]))(?:[-\_.!~*'a-zA-Z0-9;/?:@&=+%#]+));
} else {
	$::isurl=qq(s?(?:https?|ftp|news)://[-_.!~*'a-zA-Z0-9;/?:@&=+%#]+);
}
# メールアドレスの正規表現										# comment
$::ismail=q{(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|"[^\\\\\x80-\xff\n\015"]*(?:\\\\[^\x80-\xff][^\\\\\x80-\xff\n\015"]*)*")(?:\.(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|"[^\\\\\x80-\xff\n\015"]*(?:\\\\[^\x80-\xff][^\\\\\x80-\xff\n\015"]*)*"))*@(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|\[(?:[^\\\\\x80-\xff\n\015\[\]]|\\\\[^\x80-\xff])*\])(?:\.(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|\[(?:[^\\\\\x80-\xff\n\015\[\]]|\\\\[^\x80-\xff])*\]))+};
$::ismail=q{(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|"[^\\\\\x80-\xff\n\015"]*(?:\\\\[^\x80-\xff][^\\\\\x80-\xff\n\015"]*)*")(?:\.(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|"[^\\\\\x80-\xff\n\015"]*(?:\\\\[^\x80-\xff][^\\\\\x80-\xff\n\015"]*)*"))*@(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|\[(?:[^\\\\\x80-\xff\n\015\[\]]|\\\\[^\x80-\xff])*\])(?:\.(?:[^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff]+(?![^(\040)<>@,;:".\\\\\[\]\000-\037\x80-\xff])|\[(?:[^\\\\\x80-\xff\n\015\[\]]|\\\\[^\x80-\xff])*\]))*} if($::IntraMailAddr>0);
# 画像拡張子の正規表現											# comment
$::image_extention=qq(([Gg][Ii][Ff]|[Pp][Nn][Gg]|[Jj][Pp](?:[Ee])?[Gg]));
##############################									# comment
# IPV4アドレスの正規表現										# comment
$::ipv4address_regex=qq(((25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})[.](25[0-5]|2[0-4][0-9]|[0-1]?[0-9]{1,2})));
# IPV6アドレスの正規表現										# comment
# ブロック型プラグイン											# comment
$::embed_plugin = '^\#([^\(]+)(\((.*)\))?';
$::embedded_name = '(\#.+?)';
# インライン型プラグイン										# comment
$::embedded_inline='&amp;(?:([^(;{]+)(?:[()\s?]*?)\s?\{\s?([^&}]*?)\s?\}|([^(;{]+)|([^(;{]+)\s?\(\s?([^)]*?)\s?\)|([^(;{]+)\s?\(\s?([^)]*?)\s?\)\s?\{\s?([^&}]*?)\s?\});';
##############################									# comment
# InfoBaseの項目名												# comment
$::info_ConflictChecker = 'ConflictChecker';
$::info_LastModified = 'LastModified';
$::info_CreateTime='CreateTime';
$::info_LastModifiedTime='LastModifiedTime';
$::info_UpdateTime='UpdateTime';
$::info_IsFrozen = 'IsFrozen';
$::info_AdminPassword = 'AdminPassword';
##############################									# comment
# 固定ページ名													# comment
%::fixedpage = (
	$::AdminPage => 'admin',
	$::ErrorPage => '',
	$::RecentChanges => 'recent',
	$::IndexPage => 'list',
	$::SearchPage => 'search',
	$::CreatePage => 'newpage',
);
	# 編集不可プラグイン										# comment
%::fixedplugin = (
	'newpage' => 1,
	'search' => 1,
	'list' => 1,
);
	# 内部コマンド												# comment
my %command_do = (
	read => \&do_read,
	write => \&do_write,
);
&main;
exit(0);
##############################									# comment
sub main {
	&load_wiki_module("sub", "func", "version");
	&writablecheck;
	&getbasehref;
	&init_lang;
	&init_dtd;
	&init_global;
	&skin_init;
	# fix titles
	$::meta_keyword=$::wiki_title if($::meta_keyword eq "PyukiWiki");
	$::modifier_rss_title=$::wiki_title if($::modifier_rss_title eq "PyukiWiki");
	$::modifier_rss_description=$::wiki_title if($::modifier_rss_description eq "Modified by anonymous");
	# CGI.pmの初期化										# comment
	$qCGI=new CGI;
	# 初期リソースの読み込み								# comment
	%::resource = &read_resource("$::res_dir/resource.$::lang.txt");
	# 曜日文字列の初期化									# comment
	&dateinit;
	# 変数初期化											# comment
	$::HTTP_HEADER = '';
	$::IN_HEAD = '';
	if($::P3P ne '') {
		$::HTTP_HEADER.=qq(P3P: CP="$::P3P"\n);
	}
	# &check_modifiers;										# comment
	&init_db;				# DBエンジンの初期化			# comment
	&open_db;				# DBを開く						# comment
	&init_form;				# フォームの初期化				# comment
	&init_InterWikiName;	# interwikiの初期化				# comment
	&init_inline_regex;		# インライン正規表現の初期化	# comment
	# Exプラグイン(*.inc.cgi)の起動							# comment
	&exec_explugin if($::useExPlugin > 0);
	# gzip圧縮初期化										# comment
	&gzip_init;
	# 自動リカバリー										# comment
	&init_recovery;
	# 内部コマンド(cmd=read, cmd=write)の起動				# comment
	my $ret=1;
	if ($command_do{$::form{cmd}}) {
		$ret=&{$command_do{$::form{cmd}}};
	}
	# アクションプラグイン(?cmd=)の起動						# comment
	if($ret eq 1) {
		if (&exec_plugin == 1) {
			$::form{mypage} = $::FrontPage if (!$::form{mypage});
			$::pageplugin=1;
			&do_read;
		}
	}
	# DBを閉じる											# comment
	&close_db;
}
	# not delete for d e b u g
sub _db {
	my($arg)=@_;
	return($arg);
}
sub print_error {
	my ($msg) = @_;
	&skinex("\t\t$ErrorPage", qq(<p><strong class="error">$msg</strong></p>), 0);
	close(STDOUT);
	exit(0);
}
sub message {
	my ($msg) = @_;
	return qq(<p><strong>$msg</strong></p>);
}
sub reregist_subs {
	my (@args)=@_;
	foreach my $arg(@args) {
		my $stat=eval {"exists &$arg;"};
		if($stat) {
	# http://d.hatena.ne.jp/perlcodesample/20081210/1228922629	# comment
			eval qq( sub $arg { return \&\_$arg(\@_); });
		}
	}
}
sub load_wiki_module {
	my (@args)=@_;
	foreach my $arg(@args) {
		my $f="$::sys_dir/wiki\_$arg.cgi";
		if(-r $f) {
			if(!$::loaded_wiki_module{$arg}++) {
				eval qq(require "$f";);
			}
		}
	}
}
1;
__END__
