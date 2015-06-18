######################################################################
# wiki_init.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:20:54
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################

=head1 NAME

wiki_init.cgi - This is PyukiWiki, yet another Wiki clone.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Dev/Specification/wiki_init.cgi

L<http://pyukiwiki.info/PyukiWiki/Dev/Specification/wiki_init.cgi/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/wiki_init.cgi?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/wiki_init.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/wiki_init.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/wiki_init.cgi?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

=item Nanami

L<http://nano.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2004-2007 by Nekyo.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

=lang ja

=head1 FUNCTIONS

=head2 writablecheck

=over 4

=item ������

�ʤ�

=item ����

�ʤ�

=item �����С��饤��

�Բ�

=item ����

�񤭹��߲�ǽ�������å�����ؿ�

=back

=cut

sub _writablecheck {
	my $err;
	$err.=&writechk($::data_dir);
	$err.=&writechk($::diff_dir);
	$err.=&writechk($::cache_dir);
	$err.=&writechk($::counter_dir);
	$err.=&writechk($::backup_dir);
	$err.=&writechk($::upload_dir);
	&print_error($err) if($err ne '');
}

=lang ja

=head1 FUNCTIONS

=head2 writechk

=over 4

=item ������

�ǥ��쥯�ȥ�

=item ����

���顼��å�����

=item �����С��饤��

�Բ�

=item ����

�񤭹��߲�ǽ�������å�����ᥤ��δؿ�

=back

=cut

sub _writechk {
	my($dir)=shift;
	return "Directory is not found or not writable ($dir)<br />\n"
		if(!-w $dir);
	return '';
}


=lang ja

=head2 init_global

=over 4

=item ������

�ʤ�

=item ����

�ʤ�

=item �����С��饤��

�Բ�

=item ����

speedy_cgi�Ǽ¹Բ�ǽ�ˤ��뤿�����ν������

������������speedy_cgi�Ǥ�ư��ϥ��ݡ��Ȥ���Ƥ��ʤ���

=back

=cut

	# 2005.10.27 pochi: speedy_cgi�Ǽ¹Բ�ǽ��				# comment

sub _init_global {
	&close_db;
	%::form = ();
	%::database = ();
	%::infobase = ();
	%::diffbase = ();
	%::interwiki = ();
	%::_resource_loaded = ();
	$lastmod = "";
	%::_plugined = ();
	$::pageplugin=0;
	%::_exec_plugined=();
	%::_exec_plugined_func=();
	%::_exec_plugined_value=();
	%::_module_loaded=();
	# 0��255�Υơ��֥�����
	foreach my $i (0x00 .. 0xFF) {
		$::_urlescape{chr($i)} = sprintf('%%%02x', $i);
		$::_dbmname_encode{chr($i)} = sprintf('%02X', $i);
		$::_dbmname_decode{sprintf('%02X', $i)} = chr($i);
	}
	$::_urlescape{chr(32)} ='+';
}

=lang ja

=head2 init_lang

=over 4

=item ������

�ʤ�

=item ����

�ʤ�

=item �����С��饤��

��

=item ����

����ν�����򤹤롣

=back

=cut

sub _init_lang {

	if ($::lang eq 'ja') {
		$::defaultcode='euc';	# do not change
		if(lc $::charset eq 'utf-8') {
			$::kanjicode='utf8';
		} else {
			$::charset=(
				$::kanjicode eq 'euc' ? 'EUC-JP' :
				$::kanjicode eq 'utf8' ? 'UTF-8' :
				$::kanjicode eq 'sjis' ? 'Shift-JIS' :
				$::kanjicode eq 'jis' ? 'iso-2022-jp' : '')
		}
	# ������ν���								# comment
	} elsif ($::lang eq 'zh') {	# cn is not allow, use zh	# comment
		$::defaultcode='gb2312';
		$::charset = 'gb2312' if(lc $::charset ne 'utf-8');
	# ���Ѹ���ν���								# comment
	} elsif ($::lang eq 'zh-tw') {
		$::defaultcode='big5';
		$::charset = 'big5' if(lc $::charset ne 'utf-8');
	# �ڹ����ν���								# comment
	} elsif ($::lang eq 'ko' || $::lang eq 'kr') {
		$::defaultcode='euc-kr';
		$::charset = 'euc-kr' if(lc $::charset ne 'utf-8');
	# ����¾										# comment
	} else {
		$::defaultcode='iso-8859-1';
		$::charset = 'iso-8859-1' if(lc $::charset ne 'utf-8');
	}
	# $::modifierlink��¸�ߤ��ʤ��������URL������			# comment
	$::modifierlink=$::basehref if($::modifierlink eq '');}

=lang ja

=head2 init_form

=over 4

=item ������

�ʤ�

=item ����

�ʤ�

=item �����С��饤��

��

=item ����

�ե�������������롣

=back

=cut

sub _init_form {
	if ($qCGI->param()) {
		foreach my $var ($qCGI->param()) {
			$::form{$var} = $qCGI->param($var);
		}
	} else {
		$ENV{QUERY_STRING} = $::FrontPage;
	}

	# Thanks Mr.koizumi. v0.1.4							# comment
	my $query = $ENV{QUERY_STRING};
	if ($query =~ /&/) {
		my @querys = split(/&/, $query);
		foreach (@querys) {
			$_ = &decode($_);
			$::form{$1} = $2 if (/([^=]*)=(.*)$/);
		}
	} else {
		$query = &decode($query);
	}

	if (&is_exist_page($query)) {
		$::form{cmd} = 'read';
		$::form{mypage} = $query;
	}
	# mypreview_edit			-> do_edit, with preview.			# comment
	# mypreview_adminedit		-> do_adminedit, with preview.		# comment
	# mypreview_write			-> do_write, without preview.		# comment
	# mypreview_blogedit		-> do_edit, with preview.			# comment
	# mypreview_blogadminedit	-> do_adminedit, with preview.		# comment
	# mypreview_blogwrite		-> do_write, without preview.		# comment

	# mypreviewjs_edit			-> do_edit, with preview.			# comment
	# mypreviewjs_adminedit		-> do_adminedit, with preview.		# comment
	# mypreviewjs_write			-> do_write, without preview.		# comment
	# mypreviewjs_blogedit		-> do_edit, with preview.			# comment
	# mypreviewjs_blogadminedit	-> do_adminedit, with preview.		# comment
	# mypreviewjs_blogwrite		-> do_write, without preview.		# comment

	foreach (keys %::form) {
		if (/^mypreview_blog(.*)$/ || /^mypreviewjs_blog(.*)$/) {
			if($::form{$_} ne '') {
				$::form{cmd} = "blog";
				$::form{mode} = $1;
				$::form{mypreview} = 1;
			}
		} elsif (/^mypreview_(.*)$/ || /^mypreviewjs_(.*)$/) {
			if($::form{$_} ne '') {
				$::form{cmd} = $1;
				$::form{mypreview} = 1;
			}
		}
	}

	foreach("mymsg", "word", "myname", "mypage", "page"
		  , "refer", "under", "template") {
		$::form{$_} = &code_convert(\$::form{$_}, $::defaultcode,$::kanjicode)
			if($::form{$_});
	}
}

=lang ja

=head2 gzip_init

=over 4

=item ������

�ʤ�

=item ����

$::gzip_header

=item �����С��饤��

�Բ�

=item ����

gzip����ɸ��⥸�塼��

=back

=cut

$::gzip_exec;

sub _gzip_init {
	$::gzip_exec=1;
	# force init setting.inc.cgi
	&exec_explugin_sub("setting")  if($::useExPlugin > 0);

	if($::setting_cookie{gzip} ne '') {
		$::gzip_exec=0 if($::setting_cookie{gzip}+0 eq 0);
	}

	if($::gzip_exec eq 1) {
		&load_module("Nana::HTTPCompress");
		$::HTTP_HEADER.=Nana::HTTPCompress::init($::gzip_path);
	}
}

=lang ja

=head2 skin_init

=over 4

=item ������

�ʤ�

=item ����

$::skin_file,
$::skin{default_css},
$::skin{print_css},
$::skin{common_js},

=item �����С��饤��

�Բ�

=item ����

������ե������¸�ߤ�����å�����skin.cgi�ؤν���ͤ򥻥åȤ��롣

=back

=cut

sub _skin_init {
	$::skin_file="$::skin_dir/" . &skin_check("$::skin_name.skin%s.cgi",".$::lang","");
	$::skin{default_css}=&skin_check("$::skin_name.default%s.css",".$::lang","");
	$::skin{print_css}=&skin_check("$::skin_name.print%s.css",".$::lang","");
	$::skin{common_js}=&skin_check("common%s.js",".unicode.$::lang",".$::kanjicode.$::lang",".$::lang");

	$::IN_CSSFILES.=<<EOM;
<link rel="stylesheet" href="$::skin_url/$::skin{default_css}" type="text/css" media="screen" charset="$::charset" />
<link rel="stylesheet" href="$::skin_url/$::skin{print_css}" type="text/css" media="print" charset="$::charset" />
EOM
	my $common=$::skin{common_js};
	$common=~s/\.js$//g;
	&jscss_include($common);
	$::IN_JSFILES=~s/^,//g;
#	$::IN_JSFILES.='"' . "6,$::skin_url/$::skin{common_js}" . '"'
#		if($::IN_JSFILES eq "");
}

=lang ja

=head2 skin_check

=over 4

=item ������

&skin_check(filename of sprintf format, lists...);

=item ����

�ʤ�

=item �����С��饤��

��

=item ����

�������ɬ�פʥե����뤬¸�ߤ��뤫�����å����롣

=back

=cut

sub _skin_check {
	my($fmt)=shift;
	my(@arg)=@_;
	foreach(@arg) {
		my $f=sprintf($fmt,$_);
		next if($f eq '');
		return $f if(-r "$::skin_dir/$f");
	}
#	$::debug.="skin_check: $::skin_dir/$fmt not found\n";
	return '';
}

=lang ja

=head2 init_InterWikiName

=over 4

=item ������

�ʤ�

=item ����

%::interwiki, %::interwiki2

=item �����С��饤��

��

=item ����

InterWiki�ν�����򤹤롣

�񼰤ϰʲ��ΤȤ���

[[YukiWiki http://www.hyuki.com/yukiwiki/wiki.cgi?euc($1)]]

[http://www.hyuki.com/yukiwiki/wiki.cgi?$1 YukiWiki] euc

=back

=cut

sub _init_InterWikiName {
	my $content = $::database{$InterWikiName};
	while ($content =~ /$interwiki_definition/g) {
		my ($name, $url) = ($1, $2);
		#v0.1.6												# comment
		$name=~tr/A-Z/a-z/;
		$::interwiki{$name} = $url;
	}
	while ($content =~ /$interwiki_definition2/g) {
		#v0.1.6												# comment
		my ($url,$name,$code)=($1,$2,$3);
		$name=~tr/A-Z/a-z/;
		$::interwiki2{$name}{$code} = $url;
	}
}

=lang ja

=head2 init_inline_regex

=over 4

=item ������

�ʤ�

=item ����

�ʤ�

=item �����С��饤��

��

=item ����

����饤��ǥ�󥯤��뤿�������ɽ�����������롣

=back

=cut

sub _init_inline_regex {
	$::inline_regex =qq(($::bracket_name)|($::embedded_inline));
	$::inline_regex.=qq(|($::isurl))				# Direct URL	# comment
		if($::autourllink eq 1);
	$::inline_regex.=qq(|(mailto:$::ismail)|($::ismail))# Mail			# comment
		if($::automaillink eq 1);
	$::inline_regex.=qq(|($::wiki_name)) # LocalLinkLikeThis (WikiName) # comment
		if($::nowikiname ne 1);
}

=lang ja

=head2 init_follow

=over 4

=item ������

�ʤ�

=item ����

�ʤ�

=item �����С��饤��

��

=item ����

follow�������������롣

=back

=cut

sub _init_follow {
	if($::follow eq 2) {
		$::followtag_pub=qq( rel="follow");
	} elsif($::follow eq 0) {
		$::followtag_pub=qq( rel="nofollow");
	} else {
		$::followtag_pub=qq( rel="follow");
	}
}

=lang ja

=head2 init_recovery

=over 4

=item ������

�ʤ�

=item ����

�ʤ�

=item �����С��饤��

��

=item ����

��Ư�ꥫ�Х꡼

=back

=cut

sub init_recovery {
	return if($::auto_recovery eq 0);
	return if($::form{mypage} eq $::FrontPage);
	return if($::FrontPage ne "FrontPage");
	return if($::database{$::FrontPage} ne "");
	return if($::form{cmd} ne "");
	$::form{cmd} = "recovery";
	$::form{all} = 1;
}

1;
