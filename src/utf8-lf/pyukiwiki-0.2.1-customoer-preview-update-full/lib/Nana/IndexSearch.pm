######################################################################
# IndexSearch.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:35:07
#
# "Nana::Kana" ver 0.1 $$
# Author Nanami
# http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
package Nana::Kana;
use strict;
use integer;
use Exporter;
use vars qw($VERSION);
$VERSION="0.1";
# http://chalow.net/2006-02-25-4.html			# comment
# http://chalow.net/2006-09-24-3.html			# comment
$Kana::EUCPRE = qr{(?<!\x8F)};
$Kana::EUCPOST = qr{(?=(?:[\xA1-\xFE][\xA1-\xFE])*(?:[\x00-\x7F\x8E\x8F]|\z))};
my %kana_table=(
	"\xa5\xa2"=>"\xa4\xa2|\xa5\xa2|\xa5\xa1|\xa4\xa2|\xa4\xa1",
	"\xa5\xa4"=>"\xa4\xa4|\xa5\xa4|\xa5\xa3|\xa4\xa4|\xa4\xa3|\xa5\xf0",
	"\xa5\xa6"=>"\xa4\xa6|\xa5\xa6|\xa5\xa5|\xa4\xa6|\xa4\xa5|\xa5\xf4",
	"\xa5\xa8"=>"\xa4\xa8|\xa5\xa8|\xa5\xa7|\xa4\xa8|\xa4\xa7|\xa5\xf1",
	"\xa5\xaa"=>"\xa4\xaa|\xa5\xaa|\xa5\xa9|\xa4\xaa|\xa4\xa9",
	"\xa5\xab"=>"\xa4\xab|\xa5\xab|\xa5\xac|\xa4\xab|\xa4\xac",
	"\xa5\xad"=>"\xa4\xad|\xa5\xad|\xa5\xae|\xa4\xad|\xa4\xae",
	"\xa5\xaf"=>"\xa4\xaf|\xa5\xaf|\xa5\xb0|\xa4\xaf|\xa4\xb0",
	"\xa5\xb1"=>"\xa4\xb1|\xa5\xb1|\xa5\xb2|\xa4\xb1|\xa4\xb2",
	"\xa5\xb3"=>"\xa4\xb3|\xa5\xb3|\xa5\xb4|\xa4\xb3|\xa4\xb4",
	"\xa5\xb5"=>"\xa4\xb5|\xa5\xb5|\xa5\xb6|\xa4\xb5|\xa4\xb6",
	"\xa5\xb7"=>"\xa4\xb7|\xa5\xb7|\xa5\xb8|\xa4\xb7|\xa4\xb8",
	"\xa5\xb9"=>"\xa4\xb9|\xa5\xb9|\xa5\xba|\xa4\xb9|\xa4\xba",
	"\xa5\xbb"=>"\xa4\xbb|\xa5\xbb|\xa5\xbc|\xa4\xbb|\xa4\xbc",
	"\xa5\xbd"=>"\xa4\xbd|\xa5\xbd|\xa5\xbe|\xa4\xbd|\xa4\xbe",
	"\xa5\xbf"=>"\xa4\xbf|\xa5\xbf|\xa5\xc0|\xa4\xbf|\xa4\xc0",
	"\xa5\xc1"=>"\xa4\xc1|\xa5\xc1|\xa5\xc2|\xa4\xc1|\xa4\xc2",
	"\xa5\xc4"=>"\xa4\xc4|\xa5\xc4|\xa5\xc5|\xa4\xc4|\xa4\xc5|\xa4\xc3",
	"\xa5\xc6"=>"\xa4\xc6|\xa5\xc6|\xa5\xc7|\xa4\xc6|\xa4\xc7",
	"\xa5\xc8"=>"\xa4\xc8|\xa5\xc8|\xa5\xc9|\xa4\xc8|\xa4\xc9",
	"\xa5\xca"=>"\xa4\xca|\xa5\xca|\xa4\xca",
	"\xa5\xcb"=>"\xa4\xcb|\xa5\xcb|\xa4\xcb",
	"\xa5\xcc"=>"\xa4\xcc|\xa5\xcc|\xa4\xcc",
	"\xa5\xcd"=>"\xa4\xcd|\xa5\xcd|\xa4\xcd",
	"\xa5\xce"=>"\xa4\xce|\xa5\xce|\xa4\xce",
	"\xa5\xcf"=>"\xa4\xcf|\xa5\xcf|\xa5\xd0|\xa5\xd1|\xa4\xcf|\xa4\xd0|\xa4\xd1",
	"\xa5\xd2"=>"\xa4\xd2|\xa5\xd2|\xa5\xd3|\xa5\xd4|\xa4\xd2|\xa4\xd3|\xa4\xd4",
	"\xa5\xd5"=>"\xa4\xd5|\xa5\xd5|\xa5\xd6|\xa5\xd7|\xa4\xd5|\xa4\xd6|\xa4\xd7",
	"\xa5\xd8"=>"\xa4\xd8|\xa5\xd8|\xa5\xd9|\xa5\xda|\xa4\xd8|\xa4\xd9|\xa4\xda",
	"\xa5\xdb"=>"\xa4\xdb|\xa5\xdb|\xa5\xdc|\xa5\xdd|\xa4\xdb|\xa4\xdc|\xa4\xdd",
	"\xa5\xde"=>"\xa4\xde|\xa5\xde|\xa4\xde",
	"\xa5\xdf"=>"\xa4\xdf|\xa5\xdf|\xa4\xdf",
	"\xa5\xe0"=>"\xa4\xe0|\xa5\xe0|\xa4\xe0",
	"\xa5\xe1"=>"\xa4\xe1|\xa5\xe1|\xa4\xe1",
	"\xa5\xe2"=>"\xa4\xe2|\xa5\xe2|\xa4\xe2",
	"\xa5\xe4"=>"\xa4\xe4|\xa5\xe4|\xa5\xe3|\xa4\xe4|\xa4\xe3",
	"\xa5\xe6"=>"\xa4\xe6|\xa5\xe6|\xa5\xe5|\xa4\xe6|\xa4\xe5",
	"\xa5\xe8"=>"\xa4\xe8|\xa5\xe8|\xa5\xe7|\xa4\xe8",
	"\xa5\xe9"=>"\xa4\xe9|\xa5\xe9|\xa4\xe9",
	"\xa5\xea"=>"\xa4\xea|\xa5\xea|\xa4\xea",
	"\xa5\xeb"=>"\xa4\xeb|\xa5\xeb|\xa4\xeb",
	"\xa5\xec"=>"\xa4\xec|\xa5\xec|\xa4\xec",
	"\xa5\xed"=>"\xa4\xed|\xa5\xed|\xa4\xed",
	"\xa5\xef"=>"\xa4\xef|\xa5\xef|\xa4\xef",
	"\xa5\xf2"=>"\xa4\xf2|\xa5\xf2|\xa4\xf2",
	"\xa5\xf3"=>"\xa4\xf3|\xa5\xf3|\xa4\xf3",
	"A"=>"\xa3\xc1|\xa3\xe1|A|a",
	"B"=>"\xa3\xc2|\xa3\xe2|B|b",
	"C"=>"\xa3\xc3|\xa3\xe3|C|c",
	"D"=>"\xa3\xc4|\xa3\xe4|D|d",
	"E"=>"\xa3\xc5|\xa3\xe5|E|e",
	"F"=>"\xa3\xc6|\xa3\xe6|F|f",
	"G"=>"\xa3\xc7|\xa3\xe7|G|g",
	"H"=>"\xa3\xc8|\xa3\xe8|H|h",
	"I"=>"\xa3\xc9|\xa3\xe9|I|i",
	"J"=>"\xa3\xca|\xa3\xea|J|j",
	"K"=>"\xa3\xcb|\xa3\xeb|K|k",
	"L"=>"\xa3\xcc|\xa3\xec|L|l",
	"M"=>"\xa3\xcd|\xa3\xed|M|m",
	"N"=>"\xa3\xce|\xa3\xee|N|n",
	"O"=>"\xa3\xcf|\xa3\xef|O|o",
	"P"=>"\xa3\xd0|\xa3\xf0|P|p",
	"Q"=>"\xa3\xd1|\xa3\xf1|Q|q",
	"R"=>"\xa3\xd2|\xa3\xf2|R|r",
	"S"=>"\xa3\xd3|\xa3\xf3|S|s",
	"T"=>"\xa3\xd4|\xa3\xf4|T|t",
	"U"=>"\xa3\xd5|\xa3\xf5|U|u",
	"V"=>"\xa3\xd6|\xa3\xf6|V|v",
	"W"=>"\xa3\xd7|\xa3\xf7|W|w",
	"X"=>"\xa3\xd8|\xa3\xf8|X|x",
	"Y"=>"\xa3\xd9|\xa3\xf9|Y|y",
	"Z"=>"\xa3\xda|\xa3\xfa|Z|z",
	"0"=>"0",
	"1"=>"1",
	"2"=>"2",
	"3"=>"3",
	"4"=>"4",
	"5"=>"5",
	"6"=>"6",
	"7"=>"7",
	"8"=>"8",
	"9"=>"9",
	"kigou"=>"\xb5\xad\xb9\xe6|\xcc\xbe\xbb\xec",
	"trzen"=>"\xa1\xaa\xa1\xc9\xa1\xf4\xa1\xf0\xa1\xf3\xa1\xf5\xa1\xc7\xa1\xca\xa1\xcb\xa1\xf6\xa1\xdc\xa1\xa4\xa1\xdd\xa1\xa5\xa1\xbf\xa3\xb0\xa3\xb1\xa3\xb2\xa3\xb3\xa3\xb4\xa3\xb5\xa3\xb6\xa3\xb7\xa3\xb8\xa3\xb9\xa1\xa7\xa1\xa8\xa1\xe3\xa1\xe1\xa1\xe4\xa1\xa9\xa1\xf7\xa3\xc1\xa3\xc2\xa3\xc3\xa3\xc4\xa3\xc5\xa3\xc6\xa3\xc7\xa3\xc8\xa3\xc9\xa3\xca\xa3\xcb\xa3\xcc\xa3\xcd\xa3\xce\xa3\xcf\xa3\xd0\xa3\xd1\xa3\xd2\xa3\xd3\xa3\xd4\xa3\xd5\xa3\xd6\xa3\xd7\xa3\xd8\xa3\xd9\xa3\xda\xa1\xce\xa1\xef\xa1\xcf\xa1\xb0\xa1\xb2\xa1\xc6\xa3\xe1\xa3\xe2\xa3\xe3\xa3\xe4\xa3\xe5\xa3\xe6\xa3\xe7\xa3\xe8\xa3\xe9\xa3\xea\xa3\xeb\xa3\xec\xa3\xed\xa3\xee\xa3\xef\xa3\xf0\xa3\xf1\xa3\xf2\xa3\xf3\xa3\xf4\xa3\xf5\xa3\xf6\xa3\xf7\xa3\xf8\xa3\xf9\xa3\xfa\xa1\xd0\xa1\xc3\xa1\xd1",
);
sub new {
	my($class,%hash)=@_;
	my $ret;
	my $method;
	my $obj;
	if(&load_module("MeCab")) {
		$method="MeCab";
		$obj=new MeCab::Tagger ("");
	} elsif(&load_module("Text::MeCab")) {
		$method="Text::MeCab";
		$obj=Text::MeCab->new();
	}
	my $code=lc $hash{code}=~/utf8/ || $hash{code}=~/utf-8/ ? "utf8"
		   : lc $hash{code}=~/euc/ ? "euc"
		   : lc $hash{code}=~/sjis/ ? "sjis"
		   : "euc";
	return bless {
		method=>$method,
		obj=>$obj,
		code=>$code
	}, $class;
}
sub parse {
	my ($self, $text)=@_;
	# $::defaultcode -> $self->{code}		# comment
	if($::defaultcode ne $self->{code}) {
		$text=&code_convert(\$text, $self->{code}, $::defaultcode);
	}
	if($self->{method} eq "MeCab") {
		return $self->{obj}->parseToNode($text);
	} elsif($self->{method} eq "Text::MeCab") {
		return $self->{obj}->parse($text);
	}
}
sub yomi1{
	my ($self, $text)=@_;
	my $buf;
	if($self->{method} eq "MeCab") {
	# $self->{code} -> euc			# comment
		my $array=$self->parse($text);
		while ($array = $array->{next}) {
			my $now=$array->{feature};
			$now=&code_convert(\$now, "euc", $self->{code});
			my ($r1, $r2, $r3, $r4, $r5, $r6, $word, $yomi1, $yomi2)
				=split(/,/,$now);
			my $w=$array->{surface};
			my $r;
			foreach(keys %kana_table) {
				$w=~s/$Kana::EUCPRE($kana_table{$_})$Kana::EUCPOST/$_/g;
				$r.="$_|";
			}
			$r=~s/\|$//g;
			my $chr;
			if($w=~/^([A-Z])*$/) {
				$chr=$w;
			} elsif($word ne "*") {
				$chr= $yomi1;
			} else {
				$chr= $yomi1;
			}
			if($chr eq "") {
				$chr=$w;
			}
			$buf.=$chr;
		}
	} else {
		# $self->{code} -> euc			# comment
		for ( my $array = $self->parse($text); $array; $array = $array->next ) {
			my $now=$array->feature;
			$now=&code_convert(\$now, "euc", $self->{code});
			my ($r1, $r2, $r3, $r4, $r5, $r6, $word, $yomi1, $yomi2)
				=split(/,/,$now);
			my $w=$array->surface;
			my $r;
			foreach(keys %kana_table) {
				$w=~s/$Kana::EUCPRE($kana_table{$_})$Kana::EUCPOST/$_/g;
				$r.="$_|";
			}
			$r=~s/\|$//g;
			my $chr;
			if($w=~/^([A-Z])*$/) {
				$chr=$w;
			} elsif($word ne "*") {
				$chr= $yomi1;
			} else {
				$chr= $yomi1;
			}
			if($chr eq "") {
				$chr=$w;
			}
			$buf.=$chr;
		}
	}
	#  euc -> $::defaultcode			# comment
	$buf=&code_convert(\$buf, $::defaultcode, "euc");
	$buf;
}
sub idx {
	my ($self, $text)=@_;
	# $::defaultcode -> euc				# comment
	$text=&code_convert(\$text, "euc", $::defaultcode);
	foreach(keys %kana_table) {
		$text=~s/$Kana::EUCPRE($kana_table{$_})$Kana::EUCPOST/$_/g;
	}
	foreach(keys %kana_table) {
		if(substr($text, 0, length($_)) eq $_) {
			if(/^[A-Z]$/) {
				return $_;
			}
			my $chr=(split(/\|/,$kana_table{$_}))[0];
			#   euc -> $::defaultcode	# comment
			my $txt=&code_convert(\$chr, $::defaultcode, "euc");
			return $txt;
		}
	}
	return "";
}
sub load_module {
	my $funcp = $::functions{"load_module"};
	return &$funcp(@_);
}
sub code_convert {
	my $funcp = $::functions{"code_convert"};
	return &$funcp(@_);
}
1;
__END__
