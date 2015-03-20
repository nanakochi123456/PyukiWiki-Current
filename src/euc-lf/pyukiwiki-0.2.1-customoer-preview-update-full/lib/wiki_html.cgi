######################################################################
# wiki_html.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:41:10
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
	# ��ʸ���Υơ��֥�											# comment
%::_facemark = (
	' :)'		=> 'smile',
	' (^^)'		=> 'smile',
	' :D'		=> 'bigsmile',
	' (^-^)'	=> 'bigsmile',
	' :p'		=> 'huh',
	' :d'		=> 'huh',
	' XD'		=> 'oh',
	' X('		=> 'oh',
	' ;)'		=> 'oh',
	' (;'		=> 'wink',
	' (^_-)'	=> 'wink',
	' ;('		=> 'sad',
	' :('		=> 'sad',
	' (--;)'	=> 'sad',
	' (^^;)'	=> 'worried',
	'&heart;'	=> 'heart',
# pukiwiki_style					# comment
	'&bigsmile;'=> 'bigsmile',
	'&huh;'		=> 'huh',
	'&oh;'		=> 'oh',
	'&sad;'		=> 'sad',
	'&smile;'	=> 'smile',
	'&wink;'	=> 'wink',
	'&worried;' => 'worried',
# �ʲ� PukiWiki Plus���			# comment
	'&big;'			=> 'extend_bigsmile',
	'&big_plus;'	=> 'extend_bigsmile',
	'&heart2;'		=> 'extend_heart',
	'&heartplus;'	=> 'extend_heart',
	'&oh2;'			=> 'extend_oh',
	'&ohplus;'		=> 'extend_oh',
	'&sad2;'		=> 'extend_sad',
	'&sadplus;'		=> 'extend_sad',
	'&smile2;'		=> 'extend_smile',
	'&smileplus;'	=> 'extend_smile',
	'&wink2;'		=> 'extend_wink',
	'&winkplus;'	=> 'extend_wink',
	'&worried2;'	=> 'extend_worried',
	'&worriedplus;'	=> 'extend_worried',
	'&ummr;'		=> 'umm',
	'&star;'		=> 'star',
	'&tear;'		=> 'tear',
);
	# ��ʸ��������ɽ��											# comment
$::_facemark=q{\ \(--\;\)|\ \(\;|\ \(\^-\^\)|\ \(\^\^\)|\ \(\^\^\;\)|\ \(\^\_-\)|\ \:\(|\ \:\)|\ \:D|\ \:d|\ \:p|\ \;\(|\ \;\)|\ X\(|\ XD|\&heart\;};
$::_facemark.=q{|\&big\;|\&big\_plus\;|\&bigsmile\;|\&heart2\;|\&heartplus\;|\&huh\;|\&oh2\;|\&oh\;|\&ohplus\;|\&sad2\;|\&sad\;|\&sadplus\;|\&smile2\;|\&smile\;|\&smileplus\;|\&star\;|\&tear\;|\&ummr\;|\&wink2\;|\&wink\;|\&winkplus\;|\&worried2\;|\&worried\;|\&worriedplus\;} if($::usePukiWikiStyle eq 1);
sub _init_dtd {
	my ($xmlns)=@_;
	$xmlns=" $xmlns" if($xmlns ne "");
	# DTD�ν����										# comment
	%::dtd = (
		"html4"=>qq(<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">\n<html lang="$::lang"$xmlns>\n<head>\n<meta http-equiv="Content-Language" content="$::lang" />\n<meta http-equiv="Content-Type" content="text/html; charset=$::charset" />\n<meta http-equiv="Content-Style-Type" content="text/css" />\n<meta http-equiv="Content-Script-Type" content="text/javascript" />),
		"xhtml11"=>qq(<?xml version="1.0" encoding="$::charset" ?>\n<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="$::lang"$xmlns>\n<head>),
		"xhtml10"=>qq(<?xml version="1.0" encoding="$::charset" ?>\n<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml" lang="$::lang" xml:lang="$::lang"$xmlns>\n<head>\n<meta http-equiv="Content-Language" content="$::lang" />\n<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=$::charset" />),
		"xhtml10t"=>qq(<?xml version="1.0" encoding="$::charset" ?>\n<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml" lang="$::lang" xml:lang="$::lang"$xmlns>\n<head>\n<meta http-equiv="Content-Language" content="$::lang" />\n<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=$::charset" />),
		"xhtmlbasic10"=>qq(<?xml version="1.0" encoding="$::charset" ?>\n<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML Basic 1.0//EN" "http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd">\n<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="$::lang"$xmlns>\n<head>\n<meta http-equiv="Content-Language" content="$::lang" />\n<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=$::charset" />),
		"html5_plugin"=>qq(<!doctype html>\n<html lang="$::lang"$xmlns>\n<head>\n<meta http-equiv="content-type" content="text/html; charset=$::charset" /><meta http-equiv="Content-Style-Type" content="text/css" />\n<meta http-equiv="Content-Script-Type" content="text/javascript" />),
	);
	$::dtd=$::dtd{$::htmlmode};
	$::dtd=$::dtd{html4} if($::dtd eq '') || &is_no_xhtml(0);
	$::dtd.=qq(\n<meta name="generator" content="PyukiWiki $::version" />\n);
	# XHTML�Ǥ��뤫�Υե饰������							# comment
	$::is_xhtml=$::dtd=~/xhtml/;
}
sub _is_no_xhtml {
	my ($mode)=shift;
	# HTTP�إå�����ǧ�����뤫							# comment
	if($mode eq 1) {
		if($ENV{HTTP_USER_AGENT}=~/Opera\/(\d+)\.(\d+)/) {
			return 0 if($1 > 8);
		}
		if($ENV{HTTP_USER_AGENT}=~/Trident/) {
			return 0;
		}
		if($ENV{HTTP_USER_AGENT}=~/MSIE (\d+).(\d+)/) {
			return 0 if($1 >= 9);
		}
		if($ENV{HTTP_USER_AGENT}=~/Fire[Ff]ox\/(\d+)\./) {
			return 0 if($1 >= 3);
		}
		if($ENV{HTTP_USER_AGENT}=~/Chrome\/(\d+)\./) {
			return 0 if($1 >= 10);
		}
		if($ENV{HTTP_USER_AGENT}=~/Android/) {
			return 0;
		}
		if($ENV{HTTP_USER_AGENT}=~/Version\/(\d+).+Safari/) {
			return 0 if($1 > 4);
		}
		# Netscape and �����֥饦��						# comment
		if($ENV{HTTP_USER_AGENT}=~/Mozilla\/(\d+)\./ || $ENV{HTTP_USER_AGENT}=~/Netscape/) {
			return 1;
		}
		# robots (�ʰ�)									# comment
		if($ENV{HTTP_USER_AGENT}=~/[Bb]ot|Slurp|Yeti|ScSpider|ask/) {
			return 1; # �����ơ�text/html�إå��������	# comment
		}
		return 1;
	}
	# XHTML�����Τ�ǧ�����뤫							# comment
	if($ENV{HTTP_USER_AGENT}=~/Opera\/(\d+)\.(\d+)/) {
		return 0 if($1 > 6);
	}
	if($ENV{HTTP_USER_AGENT}=~/Trident/) {
		return 0;
	}
	if($ENV{HTTP_USER_AGENT}=~/MSIE (\d+.\d+)/) {
		return 0 if($1 >= 4);
	}
	if($ENV{HTTP_USER_AGENT}=~/Fire[Ff]ox\/(\d+)\./) {
		return 0 if($1 >= 3);
	}
	if($ENV{HTTP_USER_AGENT}=~/Chrome\/(\d+)\./) {
		return 0 if($1 >= 1);
	}
	if($ENV{HTTP_USER_AGENT}=~/Android/) {
		return 0;
	}
	if($ENV{HTTP_USER_AGENT}=~/Version\/(\d+).+Safari/) {
		return 0 if($1 > 3);
	}
	# Netscape and �����֥饦��
	if($ENV{HTTP_USER_AGENT}=~/Mozilla\/(\d+)\./ || $ENV{HTTP_USER_AGENT}=~/Netscape/) {
		return 1;
	}
	# robots (�ʰ�)										# comment
	if($ENV{HTTP_USER_AGENT}=~/[Bb]ot|Slurp|Yeti|ScSpider|ask/) {
		return 0;
	}
	return 1;
}
sub _meta_robots {
	my($cmd,$pagename,$body)=@_;
	my $robots;
	my $keyword;
	if($cmd=~/edit|admin|diff|attach|backup|setting/
		|| $::form{mypage} eq '' && $cmd!~/list|sitemap|recent/
		|| $::form{mypage}=~/$::resource{help}|$::resource{rulepage}|$::RecentChanges|$::MenuBar|$::SideBar|$::TitleHeader|$::Header|$::Footer$::BodyHeader$::BodyFooter|$::SkinFooter|$::SandBox|$::InterWikiName|$::InterWikiSandBox|$::non_list/
		|| $::meta_keyword eq "" || lc $::meta_keyword eq "disable"
		|| &is_readable($::form{mypage}) eq 0) {
		$robots.=<<EOD;
<meta name="robots" content="NOINDEX,NOFOLLOW,NOARCHIVE" />
<meta name="googlebot" content="NOINDEX,NOFOLLOW,NOARCHIVE" />
EOD
	} else {
		$robots.=<<EOD;
<meta name="robots" content="INDEX,FOLLOW" />
<meta name="googlebot" content="INDEX,FOLLOW,ARCHIVE" />
<meta name="keywords" content="$::meta_keyword" />
EOD
	}
	return $robots;
}
sub _text_to_html {
	# 2005.10.31 pochi: ���ץ���������ǽ��				# comment
	my ($txt, %option) = @_;
	my (@txt) = split(/\r?\n/, $txt);
	my $verbatim;
	my $tocnum = 0;
	my (@saved, @result);
	my $prevline;
	my @col_style;
	unshift(@saved, "</p>");
	push(@result, "<p>");
	# add 0.2.0-p2
	return if($txt eq '');
	# 2006.1.30 pochi: ���ԥ⡼�ɤ�����						# comment
	$::lfmode=$::line_break;
	# 2005.10.31 pochi: ��ʬ�Խ����ǽ��					# comment
	my $editpart = "";
	if($::partedit > 0) {
		if ($option{mypage}) {
			my ($title, $edit, $button);
			if (&is_frozen($option{mypage})) {
				$title = "admineditthispart";
				$edit = "adminedit";
				$button = "admineditbutton";
			} else {
				$title = "editthispart";
				$edit = "edit";
				$button = "editbutton";
			}
			my $enc_mypage = &encode($option{mypage});
			$enc_mypage =~ s/%/%%/og;
			if($::partedit eq 2 || $edit eq 'edit') {
				$editpart = qq(<div class="partinfo"><a class="icnpart" id="icn_partedit" title="$::resource{$title}" href="$::script?cmd=$edit&amp;mypage=$enc_mypage&amp;mypart=%d">@{[$::toolbar eq 2 ? qq(<span>$::resource{$button}</span>) : $::resource{$button}]}</a></div>);
			}
		}
	}
	my $backline;	# ʣ�����б���							# comment
	my $backcmd;
	my $nest;
	my $lines=$#txt;
	foreach (@txt) {
		$lines--;
		next if($_ eq '#freeze');
		@col_style=() if(!/^(\,|\|)/);
		# add 0.2.0-p2
		if($::linesave ne 0) {
			if($_ eq $::eom_string) {
				$::linesave=0;
				$::eom_string="";
				$::linedata=~s/\n$//g;
				push(@result, &$::exec_inlinefunc($::linedata));
				$::linedata="";
				next;
			}
			$::linedata.="$_\n";
			next;
		}
		# backline
		if($backline ne '') {
			$_=$backline . $_;
			$backline="";
		}
		# verbatim.
		if ($verbatim->{func}) {
			if (/^\Q$verbatim->{done}\E$/) {
				undef $verbatim;
				push(@result, splice(@saved));
			} else {
				push(@result, $verbatim->{func}->($_));
			}
			next;
		}
		# non-verbatim follows.
		push(@result, shift(@saved)) if (@saved and $saved[0] eq '</pre>' and /^[^ \t]/);
		my $escapedscheme=$_;
		# v0.1.6 url or mail scheme escape to [BS] or [TAB]	# comment
		if($escapedscheme=~/($::isurl|mailto:$ismail)/) {
			my $url1=$1;
			my $url2=$url1;
			$url2=~s!:!\x08!g;
			$url2=~s!/!\x07!g;
			$escapedscheme=~s!\Q$url1!$url2!g;
		}
		# ʣ�����б�����									# comment
		if($::usePukiWikiStyle eq 1) {
			if(/^:(.*)[|:]+$/) {
				if($lines>0) {
					$backline=$_;
					next;
				}
			} elsif(/^(:|>{1,3}|-{1,3}|\+{1,3})(.+)~$/) {
				if($lines>0) {
					$backline="$1$2\x06";
					next;
				}
			}
		}
		# * ** *** **** *****								# comment
		if (/^(\*{1,5})(.+)/) {
			my $hn = "h" . (length($1) + 1);	# $hn = 'h2'-'h6'
			my $hedding = ($tocnum != 0)
				? qq(<div class="jumpmenu"><a href="@{[&htmlspecialchars($::form{cmd} ne 'read' ? "?$ENV{QUERY_STRING}" : &make_cookedurl($::pushedpage eq '' ? $::form{mypage} : $::pushedpage))]}#navigator">&uarr;</a></div>\n)
				: '';
			push(@result, splice(@saved),
				$hedding . qq(<$hn id="@{[&makeanchor($::form{mypage}, $tocnum, $2)]}">) . &inline($2) . qq(</$hn>)
			);
			# 2005.10.31 pochi: ��ʬ�Խ����ǽ��			# comment
			push(@result, sprintf($editpart, $tocnum + 2)) if($editpart);
			$tocnum++;
		# verbatim											# comment
		} elsif (/^{{{/) {	# OpenWiki like. Thanks wadldw.
			$verbatim = { func => \&inline, done => '}}}', class => 'verbatim-soft' };
			&back_push('pre', 1, \@saved, \@result, " class='$verbatim->{class}'");
		} elsif (/^(-{2,3})\($/) {
			if ($& eq '--(') {
				$verbatim = { func => \&inline, done => '--)', class => 'verbatim-soft' };
			} else {
				$verbatim = { func => \&escape, done => '---)', class => 'verbatim-hard' };
			}
			&back_push('pre', 1, \@saved, \@result, " class='$verbatim->{class}'");
		# hr												# comment
		} elsif (/^----/) {
			push(@result, splice(@saved), '<hr />');
		# - -- ---											# comment
		} elsif (/^(-{1,3})(.+)/) {
			my $class = "";
			my $level = length($1);
			if ($::form{mypage} ne $::MenuBar) {
				$class = " class=\"list" . length($1) . "\"";
			}
			&back_push('ul', length($1), \@saved, \@result, $class);
			push(@result, '<li>' . &inline($2) . '</li>');
		# + ++ +++											# comment
		} elsif (/^(\+{1,3})(.+)/) {
			my $class = "";
			if ($::form{mypage} ne $::MenuBar) {
				$class = " class=\"plist" . length($1) . "\"";
			}
			&back_push('ol', length($1), \@saved, \@result, $class);
			push(@result, '<li>' . &inline($2) . '</li>');
		# : ... : ... / : ... | ...						# comment
		} elsif (/^:/) {
			$escapedscheme=~/^(:{1,3})(.+)/;
			my $chunk=$2;
			my $class = "";
			if ($::form{mypage} ne $::MenuBar) {
				$class=qq( class="list) . length($1) . qq(");
			}
			# thanks making testdata tenk*
			$chunk=~s/\[\[([^:\]]+?):((?!\[)[^\]]+?)\]\]/[[$1\x08$2]]/g
				while($chunk=~/\[\[([^:\]]+?):((?!\[)[^\]]+?)\]\]/);
			if ($chunk=~/^([^\|]+):(.+)\|(.*)/) {
				&back_push('dl', 1, \@saved, \@result, $class);
				push(@result, '<dt>' . &inline($1) . '</dt>', '<dd>' . &inline("$2|$3") . '</dd>');
			} elsif ($chunk=~/^([^\|]+)\|(.*)/) {
				&back_push('dl', 1, \@saved, \@result, $class);
				push(@result, '<dt>' . &inline($1) . '</dt>', '<dd>' . &inline($2) . '</dd>');
			} elsif ($chunk=~/^([^:]+):(.+)/) {
				&back_push('dl', 1, \@saved, \@result, $class);
				push(@result, '<dt>' . &inline($1) . '</dt>', '<dd>' . &inline($2) . '</dd>');
			} else {
				&back_push('dl', 1, \@saved, \@result, $class);
				push(@result, '<dt>' . &inline($chunk) . '</dt>', '<dd></dd>');
			}
		# > >> >>> >>>> >>>>>							# comment
		} elsif (/^(>{1,5})(.+)/) {
			&back_push('blockquote', length($1), \@saved, \@result);
			push(@result, qq(<p class="quotation">))
				if($::usePukiWikiStyle eq 1);
			push(@result, &inline($2));
			push(@result, qq(</p>\n))
				if($::usePukiWikiStyle eq 1);
		# null											# comment
		} elsif (/^$/) {								# comment
			push(@result, splice(@saved));
			unshift(@saved, "</p>");
			push(@result, "<p>");
		# pre											# comment
		# 2005.11.16 pochi: �����Ѥ��ΰ�ι�Ƭ�������	# comment
		} elsif (/^\s(.*)$/o) {
			&back_push('pre', 1, \@saved, \@result);
			push(@result, &htmlspecialchars($1,1)); # Not &inline, but &escape # comment
		# table											# comment
		} elsif (/^([\,|\|])(.*?)[\x0D\x0A]*$/) {
			&back_push('table', 1, \@saved, \@result,
				' class="style_table" cellspacing="1" border="0"',
				'<div class="ie5">', '</div>');
#######										# comment
# This part is taken from Mr. Ohzaki's Perl Memo and Makio Tsukamoto's WalWiki.	# comment
			my $delm = "\\$1";
			my $tmp = ($1 eq ',') ? "$2$1" : "$2";
			my @value = map {/^"(.*)"$/ ? scalar($_ = $2, s/""/"/g, $_) : $_}
				($tmp =~ /("[^"]*(?:""[^"]*)*"|[^$delm]*)$delm/g);
			my @align = map {(s/^\s+//) ? ((s/\s+$//) ? ' align="center"' : ' align="right"') : ''} @value;
			my @colspan = map {$_ eq '==' ? 0 : 1} @value;
			my $pukicolspan=1;
			my $thflag='td';
			for (my $i = 0; $i < @value; $i++) {
				if ($colspan[$i]) {
					if($::usePukiWikiStyle eq 1) {
						# <th>
						if($value[$i]=~/^\~/) {
							$value[$i]=~s/^\~//g;
							$thflag='th';
						} elsif($value[$i] eq '~') {
							$value[$i]="";
							# reserved rowspan
						}
						# right colspan
						if($value[$i] eq '>') {
							$value[$i]='';
							$pukicolspan++;
							next;
						}
					}
					while ($i + $colspan[$i] < @value and  $value[$i + $colspan[$i]] eq '==') {
						$colspan[$i]++;
					}
					$colspan[$i] = ($colspan[$i] > 1) ? sprintf(' colspan="%d"', $colspan[$i]) : '';
					if($pukicolspan > 1 && $::usePukiWikiStyle eq 1) {
						$colspan[$i] = sprintf(' colspan="%d"', $pukicolspan);
						$pukicolspan=1;
					}
					if($::usePukiWikiStyle eq 1) {
						$value[$i]=~ s!(LEFT|CENTER|RIGHT)\:!\ftext-align:$1;\t!g;
						$value[$i]=~ s!BGCOLOR\((.*?)\)\:(.*)!\fbackground-color:$1;\t$2!g;
						$value[$i]=~ s!COLOR\((.*?)\)\:(.*)!\fcolor:$1;\t$2!g;
						$value[$i]=~ s!SIZE\((.*?)\)\:(.*)!\ffont-size:$1px;\t$2!g;
						if($value[$i]=~/\f/) {
							$value_style[$i]=$value[$i];
							$value_style[$i]=~s!\t\f!!g;
							$value_style[$i]=~s!\t(.*)$!!g;
							$value_style[$i]=~s!\f!!g;
							$value[$i]=~s/\f(.*?)\t//g;
						}
						if($tmp=~/(\,|\|)c$/) {
							$col_style[$i]=$value_style[$i];
						} else {
							$value[$i] = sprintf('<%s%s%s class="style_%s" style="%s%s">%s</%s>', $thflag,$align[$i], $colspan[$i], $thflag,$col_style[$i],$value_style[$i],&inline($value[$i]),$thflag);
							$value_style[$i]="";
						}
					} else {
						$value[$i] = sprintf('<td%s%s class="style_td">%s</td>', $align[$i], $colspan[$i], &inline($value[$i]));
					}
				} else {
					$value[$i] = '';
				}
			}
			if($::usePukiWikiStyle eq 0) {
				push(@result, join('', '<tr>', @value, '</tr>'));
			} elsif($tmp=~/(\,|\|)h$/) {
				push(@result, join('', '<thead><tr>',@value,'</tr></thead>'));
			} elsif($tmp=~/(\,|\|)f$/) {
				push(@result, join('', '<tfoot><tr>',@value,'</tr></tfoot>'));
			} elsif($tmp!~/(\,|\|)c$/) {
				push(@result, join('', '<tr>', @value, '</tr>'));
			}
		# ====											# comment
		} elsif (/^====/) {
			if ($::form{show} ne 'all') {
				push(@result, splice(@saved), "<a href=\"$::script?cmd=read&amp;mypage="
					. &encode($::form{mypage}) . "&show=all\">$::resource{continue_msg}</a>");
				last;
			}
		# 2006.1.30 pochi: ���ԥ⡼�ɤ�����				# comment
		} elsif (/^\&\*lfmode\((\d+)\);$/o) {
			$::lfmode = $1;
			$_="";
			next;
		# �֥�å��ץ饰����							# comment
		} elsif (/^$::embedded_name$/o) {
			s/^$::embedded_name$/&embedded_to_html($1)/gexo;
			&back_push('div', 1, \@saved, \@result);
			push(@result,$_);
		} else {
			# 2006.1.30 pochi: ���ԥ⡼�ɤ�����			# comment
			push(@result, &inline($_, ("lfmode" => $::lfmode)));
		}
	}
	push(@result, splice(@saved));
	# 2005.10.31 pochi: ��ʬ�Խ����ǽ��				# comment
	if ($editpart && $::partfirstblock eq 1) {
		unshift(@result, sprintf($editpart, 1));
	}
	my $body=join("\n",@result);
	# v0.2.1
	if($::replace{$::lang} ne '') {
		foreach my $rep(/\s/, $::replace{$::lang}) {
			my ($bef, $aft)=split(/\//, $rep);
			$body=~s/$bef/$aft/g;
		}
	}
	$body=~s/edit\&mypage/edit\&amp;mypage/g;
	# add 0.2.0-p2
	if($::use_Highlight eq 1) {
		$body=&highlight($body, $::form{word}) if($::form{word} ne '');
	}
	return $body if($::usePukiWikiStyle eq 0);
	my $tmp=$body;
	$tmp=~s/(<p>|<\/p>|\n)//g;
	return $body if($tmp ne '');
	return '';
}
sub _highlight {
	my ($text, $wd)=@_;
	my $spc="";
	if($::highlight_exec eq 0 && $::pushedpage eq '') {
		$::highlight_exec=1;
		my $msg=$::resource{msg_word};
		my $cwd=&highlight($wd, $wd);	# ������ɤ�Ƶ�
		$::bodyheaderbody="<div><strong>$msg</strong>&nbsp;$cwd</div>";
	}
	my $spc;
	if ($wd) {
		if($::lang eq "ja") {
			if($::defaultcode eq 'utf8') {
				$spc="\xe3\x80\x80";
			} else {
				$spc="\xa1\xa1";
			}
		}
	}
	if($spc ne "") {
		foreach(" ", $spc) {
			$wd=~s/$_/\t/g;
		}
	}
	$wd=~s/(\t+)/\t/g;
	my @wd=split(/\t/,$wd);
	my $searchcount=0;
	if(&load_module("Nana::Search")) {
		foreach(@wd) {
			next if($_ eq '');
			$_=~s/[\x21-\x2f\x3a-\x40\x5b-\x60\x7b-\x7f]//g;
			$text=Nana::Search::SearchRe(
				$text, $_
			, '<strong class="word' . $searchcount . '">'
			, '</strong>');
			$searchcount=($searchcount + 1) % 10;
		}
	} else {
		foreach(@wd) {
			next if($_ eq '');
			my $strong='<strong class="word' . $searchcount . '">';
			$text=~s/(?^:((?:\G|>)[^<]*?))($_)/$1$strong$2<\/strong>/g;
			$searchcount=($searchcount + 1) % 10;
		}
	}
	return $text;#nocompact;
}
sub _pageanchorname {
	my ($page)=@_;
	return 'm' if($page eq $::MenuBar && $::MenuBar ne '');
	return 'r' if($page eq $::RightBar && $::RightBar ne '');
	return 'h' if($page eq $::Header && $::Header ne '');
	return 'f' if($page eq $::Footer && $::Footer ne '');
	return 's' if($page eq $::SkinFooter && $::SkinFooter ne '');
	return 'i';
}
sub _makeanchor {
	my($page, $tocnum, $title)=@_;
	$title=&inlinetext($title);
	my $s="$page$title";
	return &pageanchorname($page) . &dbmname($s) . $tocnum;
}
sub _inlinetext {
	my($s)=@_;
	$s=&inline($s);
	$s =~ s/<[^>]+>//g;
	$s;
}
sub _back_push {
	my ($tag, $level, $savedref, $resultref, $attr, $before_open, $after_close,$after_open,$before_close) = @_;
	while (@$savedref > $level) {
		push(@$resultref, shift(@$savedref));
	}
	if ($savedref->[0] ne "$before_close</$tag>$after_close") {
		push(@$resultref, splice(@$savedref));
	}
	while (@$savedref < $level) {
		unshift(@$savedref, "$before_close</$tag>$after_close");
		push(@$resultref, "$before_open<$tag$attr>$after_open");
	}
}
$::_inline_attr="";
sub _inline {
	#2006.1.30 pochi: ���ץ���������ǽ��
	my ($line, %option) = @_;
	$line =~ tr|\x08|:|;				# escaped scheme v0.1.6	# comment
	$line =~ tr|\x07|/|;				# escaped scheme v0.1.6	# comment
	$line =~ s|^//.*||g;				# Comment				# comment
	$line =~ s|\s//\s\#.*$||g;
	$line = &htmlspecialchars($line);
	$line =~ s|'''(.+?)'''|<em>$1</em>|g;			# Italic		# comment
	$line =~ s|''(.+?)''|<strong>$1</strong>|g;		# Bold			# comment
	$line =~ s|%%%(.+?)%%%|<ins>$1</ins>|g;			# Insert Line	# comment
	$line =~ s|%%(.+?)%%|<del>$1</del>|g;			# Delete Line	# comment
	$line =~ s|\^\^(.+?)\^\^|<sup>$1</sup>|g;		# sup			# comment
	$line =~ s|__(.+?)__|<sub>$1</sub>|g;			# sub			# comment
	$line =~ s|(\d\d\d\d-\d\d-\d\d \(\w\w\w\) \d\d:\d\d:\d\d)|<span class="date">$1</span>|g;	# Date	# comment
	if($::usePukiWikiStyle eq 1) {
		if($line=~/~$/) {
			if($line=~/^(LEFT|CENTER|RIGHT|RED|BLUE|GREEN):/) {
				$::_inline_attr=$1;
				$line=~s/^$::_inline_attr://g;
			}
		} else {
			$::_inline_attr="";
		}
		if($::_inline_attr ne '') {
			$line="$::_inline_attr:$line";
		}
	}
	#2006.1.30 pochi: ���ԥ⡼�ɤ�����				# comment
	if ($option{"lfmode"}) {
		if ($line !~ /^$::embedded_name$/o) {
			if (!($line =~ s/\\$//o)) {
				$line .= "<br />";
			}
		}
	} else {
		$line =~ s|~$|<br />|g;
		$line =~ s|\x06|<br />|g;			# escaped scheme v0.1.6	# comment
	}
	$line =~ s!^(LEFT|CENTER|RIGHT):(.*)$!<div style="text-align:$1">$2</div>!g;
	$line =~ s!^(RED|BLUE|GREEN):(.*)$!<font color="$1">$2</font>!g;# Tnx hash. # comment
	if($::usePukiWikiStyle eq 1) {
		$line =~ s!BGCOLOR\((.*?)\)\s*\{\s*(.*)\s*\}!<span style="background-color:$1">$2</span>!g;
		$line =~ s!COLOR\((.*?)\)\s*\{\s*(.*)\}!<span style="color:$1">$2</span>!g;
		$line =~ s!SIZE\((.*?)\)\s*\{\s*(.*)\s*\}!<span style="font-size:$1px">$2</span>!g;
	}
	$line =~ s!&version;!$::version!g;
	$line =~ s!($::inline_regex)!&make_link($1)!geo;
	$line =~ s!($embedded_inline)!&embedded_inline($1)!geo
		if($::usePukiWikiStyle eq 1);	# 2�ͥ��Ȥޤǵ���			# comment
	$line =~ s|\(\((.*)\)\)|&note($1)|gex;
	$line =~ s|\(\((.*)\)\)||gex;
	$line =~ s|\[\#(.*)\]|<a class="anchor_super" id="$1" href="#$1" title="$1">$::_symbol_anchor</a>|g;
	# ��ʸ��													# comment
	if ($::usefacemark == 1) {
		$line=~s!($::_facemark)!<span class="icnface" id="icn_$::_facemark{$1}">&nbsp;&nbsp;</span>!go;
	}
	return $line;
}
sub _note {
	my ($msg) = @_;
	$msg=&highlight($msg, $::form{word}) if($::form{word} ne '');
	push(@::notes, $msg);
	# thanks to Ayase
	return "<a @{[$::is_xhtml ? 'id' : 'name']}=\"notetext_" . @::notes . "\" "
		. "href=\"" . &make_cookedurl(&encode($::form{mypage})) . "#notefoot_" . @::notes . "\" class=\"note_super\">*"
		. @::notes . "</a>";
}
1;
