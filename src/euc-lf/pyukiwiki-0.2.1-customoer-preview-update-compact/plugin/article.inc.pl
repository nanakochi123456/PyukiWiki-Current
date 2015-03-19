######################################################################
# article.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
# �ƥ����ȥ��ꥢ�Υ�����
$article::cols = 70
	if(!defined($article::cols));
#
# �ƥ����ȥ��ꥢ�ιԿ�
$article::rows = 5
	if(!defined($article::rows));
#
# ̾���ƥ����ȥ��ꥢ�Υ�����
$article::name_cols = 24
	if(!defined($article::name_cols));
#
# ��̾�ƥ����ȥ��ꥢ�Υ�����
$article::subject_cols = 60
	if(!defined($article::subject_cols));
#
# ̾���������ե����ޥå�
$article::name_format = "\'\'[[\$1>$::resource{profile_page}/\$1]]\'\'"
	if(!defined($article::name_format));
#
# ��̾�������ե����ޥå�
$article::subject_format = '**$subject'
	if(!defined($article::subject_format));
#
# ���դ������ե����ޥå� (&new ��ǧ���Ǥ��뤳��)
$article::date_format= "Y-m-d(lL) H:i:s"
	if(!defined($article::date_format));
#
# ����������� 1:����� 0:��θ�
$article::ins = 0
	if(!defined($article::ins));
#
# ����߲��˰�ԥ����Ȥ� 1:����� 0:����ʤ�
$article::comment = 1
	if(!defined($article::comment));
#
# ���Ԥ�ưŪ�Ѵ� 1:���� 0:���ʤ�
$article::auto_br = 1
	if(!defined($article::auto_br));
#
# ̾���ʤ��ǽ������ʤ�
$article::noname = 1
	if(!defined($article::noname));
#
# ���֥������Ȥʤ��ǽ������ʤ�
$article::nosubject = 0
	if(!defined($article::nosubject));
#
# ���֥������Ȥʤ��Υ����ȥ�
$article::no_subject = "no subject"
	if(!defined($article::no_subject));
#
# �᡼��Υإå���
$article::mailheader = "$::mail_head{post}"
	if(!defined($article::mailheader));
#
# ���ߡ����ϥե�����
$article::dummyformclass = "email"
	if(!defined($article::dummyformclass));
$article::dummyformtitle = "E-Mail"
	if(!defined($article::dummyformtitle));
$article::dummyformname = "email"
	if(!defined($article::dummyformname));
######################################################################
$article::no = 0;
my $_no_name = "";
sub plugin_article_action {
	if($::form{$article::dummyformname} ne "") {
		&::spam_filter($::form{msg}, 3, $::chk_article_uri_count, $::chk_article_mail_count);
	}
	&::spam_filter($::form{msg}, 2, $::chk_article_uri_count, $::chk_article_mail_count);
	&::spam_filter($::form{myname}, 0, $::chk_article_uri_count, $::chk_article_mail_count);
	&::spam_filter($::form{subject}, 0, $::chk_article_uri_count, $::chk_article_mail_count);
	if (($::form{msg} =~ /^\s*$/)
	 || ($::form{myname} =~ /^\s*$/ && $article::noname eq 1)
	 || ($::form{subject} =~ /^\s*$/ && $article::nosubject eq 1)) {
		return('msg'=>"$::form{mypage}\t\t$::resource{article_plugin_err}",'body'=>&text_to_html($::database{$::form{mypage}}),'ispage'=>1);
	}
	my $name = $_no_name;
	if ($::form{myname} ne '') {
		$name = $article::name_format;
		$name =~ s/\$1/$::form{myname}/g;
	}
	my $subject = $article::subject_format;
	if ($::form{subject} ne '') {
		$subject =~ s/\$subject/$::form{subject}/g;
	} else {
		$subject =~ s/\$subject/$article::no_subject/g;
	}
	$::form{subject} = &code_convert(\$::form{myname}, $::defaultcode);
	$::form{msg} = &code_convert(\$::form{msg}, $::defaultcode);
	$::form{msg}=~s/\x0D\x0A|\x0D|\x0A/\n/g;
	$::form{msg}=~s/^(\s|\n)//g while($::form{msg}=~/^(\s|\n)/);
	$::form{msg}=~s/(\s|\n)$//g while($::form{msg}=~/(\s|\n)$/);
	$::form{msg}=~s/\n/\~\n/g if($article::auto_br);
	my $artic = "$subject\n>$name &new{@{[&date($article::date_format)]}};~\n~\n$::form{msg}\n";
	$artic .= "\n#comment\n" if ($article::comment);
	my $postdata = '';
	my @postdata_old = split(/\r?\n/, $::database{$::form{'mypage'}});
	my $_article_no = 0;
	foreach (@postdata_old) {
		$postdata .= $_ . "\n" if (!$article::ins);
		if (/^#article/ && (++$_article_no == $::form{article_no})) {
			$postdata .= "$artic\n";
		}
		$postdata .= $_ . "\n" if ($article::ins);
	}
	$::form{mymsg} = $postdata;
	$::form{mytouch} = 'on';
	&do_write("FrozenWrite", $article::mailheader);
	&close_db;
	exit;
}
sub plugin_article_convert {
	return ' '
		if($::writefrozenplugin eq 0 && &get_info($::form{mypage}, $::info_IsFrozen) eq 1);
	$article::no++;
	my $conflictchecker = &get_info($::form{mypage}, $::info_ConflictChecker);
	my $captcha_form;
	eval {
		$captcha_form=&plugin_captcha_form;
	};
	return <<"EOD";
<form action="$::script" method="post">
<div>
<input type="hidden" name="article_no" value="$article::no" />
<input type="hidden" name="cmd" value="article" />
<input type="hidden" name="mypage" value="$::form{'mypage'}" />
<input type="hidden" name="myConflictChecker" value="$conflictchecker" />
<input type="hidden" name="mytouch" value="on" />
<span class="article_myname">$::resource{article_plugin_name} <input type="text" name="myname" size="$article::name_cols" value="$::name_cookie{myname}" /></span><br />
<span class="article_subject">$::resource{article_plugin_subject} <input type="text" name="subject" size="$article::subject_cols" value=""/></span>
<span class="$article::dummyformclass"><br />$article::dummyformtitle <input type="text" name="$article::dummyformname" value="" size="$article::name_cols"" /><br /></span>
<span class="$article::dummyformclass">$::resource{article_plugin_dmymsg}</span>
<br />
</span>
  <textarea name="msg" rows="$article::rows" cols="$article::cols"></textarea><br />
  $captcha_form
  <input type="submit" value="$::resource{article_plugin_btn}" />
 </div>
</form>
EOD
}
1;
__DATA__
sub plugin_article_usage {
	return {
		name => 'article',
		version => '3.0',
		type => 'command',
		author => 'Nekyo',
		syntax => '#article',
		description => 'A like of BBS plugin.',
		description_ja => '���ꤷ�����֤˴ʰ׷Ǽ��Ĥ����ꤷ�ޤ�����ưŪ��comment�ץ饰�������Ѥ��ޤ���',
		example => '#article',
	};
}
1;
__END__