######################################################################
# lang.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:01:26
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
# This is extented plugin.
# This file is UTF-8
# To use this plugin, rename to 'lang.inc.cgi'
######################################################################
# 国際化対応拡張プラグイン
# 以下の言語別wikiディレクトリを作成して下さい。
# attach.(lang)		example attach.en
# diff.(lang)		example diff.ja
# cache.(lang)		example cache.zh-cn
# counter.(lang)	example counter.en-us
# info.(lang)		example info.fr
# wiki.(lang)		example wiki.ja
# デフォルト言語は、従来のディレクトリのままで動作します。
######################################################################

%::langlist=(
	'af'=>'Afrikaans',
	'sq'=>'Albanian',
	'ar'=>'Arabic',
	'ar-sa'=>'Arabic(Saudi Arabia)',
	'ar-iq'=>'Arabic(Iraq)',
	'ar-eg'=>'Arabic(Egypt)',
	'ar-ly'=>'Arabic(Libya)',
	'ar-dz'=>'Arabic(Algeria)',
	'ar-ma'=>'Arabic(Morocco)',
	'ar-tn'=>'Arabic(Tunisia)',
	'ar-om'=>'Arabic(Oman)',
	'ar-ye'=>'Arabic(Yemen)',
	'ar-sy'=>'Arabic(Syria)',
	'ar-jo'=>'Arabic(Jordan)',
	'ar-lb'=>'Arabic(Lebanon)',
	'ar-kw'=>'Arabic(Kuwait)',
	'ar-ae'=>'Arabic(U.A.E.)',
	'ar-bh'=>'Arabic(Bahrain)',
	'ar-qa'=>'Arabic(Qatar)',
	'eu'=>'Basque',
	'bg'=>'Bulgarian',
	'be'=>'Belarusian',
	'ca'=>'Catalan',
#	'zh-cn'=>'Chinese(PRC)',
	'cn'=>'Chinese,中文',
	'zh'=>'Chinese,中文',
	'zh-cn'=>'Chinese,中文',
	'zh-tw'=>'Chinese(Taiwan),台灣語',
	'zh-hk'=>'Chinese(Hong Kong),香港语',
	'zh-sg'=>'Chinese(Singapore),新加坡语',
	'hr'=>'Croatian',
	'cs'=>'Czech',
	'da'=>'Danish',
#	'nl'=>'Dutch(Standard)',
	'nl'=>'Dutch',
	'nl-be'=>'Dutch(Belgian)',
	'en'=>'English',
	'en-us'=>'English(United States)',
	'en-gb'=>'English(British)',
	'en-au'=>'English(Australian)',
	'en-ca'=>'English(Canadian)',
	'en-nz'=>'English(New Zealand)',
	'en-ie'=>'English(Ireland)',
	'en-za'=>'English(South Africa)',
	'en-jm'=>'English(Jamaica)',
#	'en'=>'English(Caribbean)',
	'en-bz'=>'English(Belize)',
	'en-tt'=>'English(Trinidad)',
	'et'=>'Estonian',
	'fo'=>'Faeroese',
	'fa'=>'Farsi',
	'fi'=>'Finnish',
#	'fr'=>'French(Standard)',
	'fr'=>'French',
	'fr-be'=>'French(Belgian)',
	'fr-ca'=>'French(Canadian)',
	'fr-ch'=>'French(Swiss)',
	'fr-lu'=>'French(Luxembourg)',
#	'gd'=>'Gaelic(Scots)',
	'gd'=>'Gaelic',
	'gd-ie'=>'Gaelic(Irish)',
#	'de'=>'German(Standard)',
	'de'=>'German',
	'de-ch'=>'German(Swiss)',
	'de-at'=>'German(Austrian)',
	'de-lu'=>'German(Luxembourg)',
	'de-li'=>'German(Liechtenstein)',
	'el'=>'Greek',
	'he'=>'Hebrew',
	'hi'=>'Hindi',
	'hu'=>'Hungarian',
	'is'=>'Icelandic',
	'in'=>'Indonesian',
#	'it'=>'Italian(Standard)',
	'it'=>'Italian',
	'it-ch'=>'Italian(Swiss)',
	'ja'=>'Japanese,日本語',
	'ko'=>'Korean,한국어',
	'kr'=>'Korean,한국어',
#	'ko'=>'Korean(Johab),한국어',
	'lv'=>'Latvian',
	'lt'=>'Lithuanian',
	'mk'=>'Macedonian',
	'ms'=>'Malaysian',
	'mt'=>'Maltese',
	'no'=>'Norwegian',
	'pl'=>'Polish',
#	'pt'=>'Portuguese(Standard)',
	'pt'=>'Portuguese',
	'pt-br'=>'Portuguese(Brazilian)',
	'rm'=>'Rhaeto-Romanic',
	'ro'=>'Romanian',
	'ro-mo'=>'Romanian(Moldavia)',
	'ru'=>'Russian',
	'ru-mo'=>'Russian(Moldavia)',
#	'sz'=>'Sami(Lappish)',
	'sz'=>'Sami',
#	'sr'=>'Serbian(Cyrillic)',
#	'sr'=>'Serbian(Latin)',
	'sr'=>'Serbian',
	'sk'=>'Slovak',
	'sl'=>'Slovenian',
	'sb'=>'Sorbian',
#	'es'=>'Spanish(Spain - Traditional Sort)',
	'es'=>'Spanish',
	'es-mx'=>'Spanish(Mexican)',
#	'es'=>'Spanish(Spain - Modern Sort)',
	'es-gt'=>'Spanish(Guatemala)',
	'es-cr'=>'Spanish(Costa Rica)',
	'es-pa'=>'Spanish(Panama)',
	'es-do'=>'Spanish(Dominican Republic)',
	'es-ve'=>'Spanish(Venezuela)',
	'es-co'=>'Spanish(Colombia)',
	'es-pe'=>'Spanish(Peru)',
	'es-ar'=>'Spanish(Argentina)',
	'es-ec'=>'Spanish(Ecuador)',
	'es-cl'=>'Spanish(Chile)',
	'es-uy'=>'Spanish(Uruguay)',
	'es-py'=>'Spanish(Paraguay)',
	'es-bo'=>'Spanish(Bolivia)',
	'es-sv'=>'Spanish(El Salvador)',
	'es-hn'=>'Spanish(Honduras)',
	'es-ni'=>'Spanish(Nicaragua)',
	'es-pr'=>'Spanish(Puerto Rico)',
	'sx'=>'Sutu',
	'sv'=>'Swedish',
	'sv-fi'=>'Swedish(Finland)',
	'th'=>'Thai',
	'ts'=>'Tsonga',
	'tn'=>'Tswana',
	'tr'=>'Turkish',
	'uk'=>'Ukrainian',
	'ur'=>'Urdu',
	've'=>'Venda',
	'vi'=>'Vietnamese',
	'xh'=>'Xhosa',
	'ji'=>'Yiddish',
	'zu'=>'Zulu',
);

# now unuse...reserved											# comment
%::charsetlist=(
	'ja'=>'EUC-JP,iso-2022-jp,Shift-JIS',
	'ko'=>'euc-kr,iso-2022-kr',
	'kr'=>'euc-kr,iso-2022-kr',
	'cn'=>'gb2312,gb2312-80',
	'zh'=>'gb2312,gb2312-80',
	'zh-tw'=>'big5,x-euc-tw,x-cns11643-1,x-cns11643-2',
	'ar'=>'iso-8859-6',
	'be'=>'iso-8859-5',
	'bg'=>'iso-8859-5',
	'cs'=>'iso-8859-2',
	'el'=>'iso-8859-7',
	'hr'=>'iso-8859-2',
	'hu'=>'iso-8859-2',
	'hw'=>'iso-8859-8',
	'lt'=>'iso-8859-2',
	'lv'=>'iso-8859-2',
	'mk'=>'iso-8859-5',
	'pl'=>'iso-8859-2',
	'ro'=>'iso-8859-2',
	'ru'=>'iso-8859-5',
	'sh'=>'iso-8859-5',
	'sl'=>'iso-8859-5',
	'sq'=>'iso-8859-5',
	'sr'=>'iso-8859-5',
	'th'=>'TIS620',
	'sr'=>'iso-8859-9',
	'uk'=>'iso-8859-5',
	''=>'iso-8859-1',
);

my $bot_agent='[Bb]ot|Spider|inktomi|moget|Slurp|archiver|NG|Hatena';

%::lang_cookie;
$::lang_cookie="PWL_"
				. &dbmname($::basepath);

sub plugin_lang_init {
	my @langlist;
	return('init'=>0) if($::lang_list eq '');
	return('init'=>0) if($ENV{HTTP_USER_AGENT}=~/$bot_agent/);
	push(@langlist,$::lang);
	foreach(split(/ /,$::lang_list)) {
		if(-d "$::data_dir.$_" && $_ ne $::lang) {
			push(@langlist,$_);
		}
	}
	return('init'=>0) if($#langlist < 1);

	$::defaultlang=$::lang;

	%::lang_cookie=();
	%::lang_cookie=&getcookie($::lang_cookie,%::lang_cookie);

	if($::langlist{$::form{lang}} ne '') {
		$::lang=$::form{lang};
	} elsif($::lang_cookie{lang} ne '') {
		$::lang=$::lang_cookie{lang};
	} else {
		my $detectacq=0;
		my $http_accept_language=$ENV{HTTP_ACCEPT_LANGUAGE};
		$http_accept_language=~s/['"]//g;
		foreach(split(/,/,$http_accept_language)) {
			my($aclang,$acq)=split(/;q=/,$_);
			$acq="1.0" if($acq eq '');
			if($detectacq+0<$acq+0) {
				foreach(@langlist) {
					if($_ eq $aclang) {
						$detectacq=$acq;
						$::lang=$aclang;
					} else {
						$aclang=~s/\-.*//g;
						if($_ eq $aclang) {
							$detectacq=$acq;
							$::lang=$aclang;
						}
					}
				}
			}
		}
	}
	foreach(@langlist) {
		if($::navi{"lang" . $_ . "_url"} eq '') {
			push(@::addnavi,"lang_$_:help");
			$::navi{"lang_" . $_ . "_title"}=&getlangname($_);
			$::navi{"lang_" . $_ . "_url"}="$::script?cmd=lang&amp;lang=$_";
			$::navi{"lang_" . $_ . "_name"}=&getlangname($_)
				if($::lang ne $_);
			$::navi{"lang_" . $_ . "_type"}="plugin";
			$::navi{"lang_" . $_ . "_height"}=14;
			$::navi{"lang_" . $_ . "_width"}=16;
		}
	}
	# 0.2.0-p4 add security fix # comment
	return('init'=>0) if($::lang!~/^\w{1,64}$/);

	&init_lang;
	&init_dtd("");
	%::resource = &read_resource("$::res_dir/resource.$::lang.txt",%::resource);
	&dateinit;
	if($::defaultlang ne $::lang) {
		$::wiki_title=$::wiki_title{$::lang} if($::wiki_title{$::lang} ne '');
		&close_db;
		$::backup_dir.=".$::lang";
		$::data_dir.=".$::lang";
		$::diff_dir.=".$::lang";
		$::cache_dir.=".$::lang";
		$::cache_url.=".$::lang";
		$::upload_dir.=".$::lang";
		$::upload_url.=".$::lang";
		$::counter_dir.=".$::lang";
		$::info_dir.=".$::lang";
		if(-r "$::image_dir.$::lang") {
			$::image_dir.=".$::lang";
			$::image_url.=".$::lang";
		}
		&writablecheck;
		&open_db;
	}
#	my $req=&decode($ENV{QUERY_STRING});
#	if(&is_exist_page($req)) {
#		$::form{cmd}='read';
#		$::form{mypage}=$req;
#	}
	return('init'=>1, 'func'=>'init_lang', 'init_lang'=>\&init_lang);
}

sub getlangname {
	my ($v)=@_;
	my ($lang,$langutf)=split(/,/,$::langlist{$v});
	return $lang;
}

sub init_lang {
	$::defaultcode="utf8";
	$::kanjicode="utf8";
	$::charset="utf-8";
	# 中国語時の処理										# comment
	# 台湾語時の処理										# comment
	# 韓国語時の処理										# comment
	# その他												# comment
	# lang.inc.cgiが有効時、言語ごとの修正者情報を代入		# comment
	if($::_exec_plugined{lang} > 0) {
		$::wiki_title=$::wiki_title{$::lang} if($::wiki_title{$::lang} ne '');
		$::modifier=$::modifier{$::lang} if($::modifier{$::lang} ne '');
		$::modifierlink=$::modifierlink{$::lang} if($::modifierlink{$::lang} ne '');
		$::modifier_mail=$::modifier_mail{$::lang} if($::modifier_mail{$::lang} ne '');
		$::meta_keyword=$::meta_keyword{$::lang} if($::meta_keyword{$::lang} ne '');
	}
	# $::modifierlinkが存在しない時、基準URLを代入			# comment
	$::modifierlink=$::basehref if($::modifierlink eq '');
}

1;
__DATA__
# $charset: UTF-8$
sub plugin_lang_setup {
	return(
		ja=>'Wiki国際化プラグイン',
		en=>'International Plugin',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/lang/'
	);
__END__

=head1 NAME

lang.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

Plugin corresponding to Wiki internationalization

=head1 DESCRIPTION

It enables it to create wiki according to language.

Automatic detect of HTTP_ACCEPT_LANGUAGE, the language to which priority is given is displayed, and it enables to display the language setup by plugin lang.inc.pl.

=head1 USAGE

rename to lang.inc.cgi

Make that's directory.

 attach.(lang)  example attach.en
 backup.(lang)  example backup.en
 diff.(lang)    example diff.ja
 cache.(lang)   example cache.zh-cn
 counter.(lang) example counter.en-us
 info.(lang)    example info.fr
 wiki.(lang)    example wiki.ja

=head2 pyukiwiki.ini.cgi

=over 4

=item $::lang

Setting default language

ja en fr en-us etc...

=item $::charcode

Unmounting...reserved.

=item $::kanjicode

The kanji code which displays only in the case of Japanese is specified.

 euc sjis utf8

=$::lang_list

The language list to need is specified by space pause.

 $::lang_list="ja en";

=$::write_location=1;

This plugin use location move.

=back

=head1 BUG

It is specification, although the following initialization will be performed twice if this function is used.

 init_lang is called twice.
 Reading of a resource is performed twice (it overwrites).
 A database is closed, and a directory is re-set up and open in a database

=head1 OVERRIDE

none

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/lang

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/lang/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/lang.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/lang.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/lang.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/lang.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/lang.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nano.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2005-2015 by Nanami.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
