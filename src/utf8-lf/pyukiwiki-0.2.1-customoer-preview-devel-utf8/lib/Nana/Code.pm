######################################################################
# Code.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:00:10
#
# "Nana::Code" ver 0.2 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################

package	Nana::Code;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION @ISA @EXPORTER @EXPORT_OK);

@EXPORT_OK = qw(conv);

@ISA = 'Exporter';
$VERSION = '0.2';

$Code::Method="";

my %kana_table=(
#\@\@include="./build/list_hiragana_euc.txt"@@
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

$Code::zen=$kana_table{trzen};
$Code::han='!"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}';

sub init {
	return if($Code::Method ne "");
	if($::lang eq "ja") {
		die "Unsupport jcode.pl" if($::code_method{ja} eq "jcode.pl");
		foreach my $methods("Jcode") {
			if($Code::Method eq "") {
				if($::code_method{ja} eq  $methods) {
					if(&load_module($methods)) {
						$Code::Method="$methods";
					} else {
						die "$methods can't load";
					}
				} elsif($::code_methods{ja} eq "") {
					if(&load_module($methods)) {
						$Code::Method="$methods";
					}
				}
			}
		}
	}
}

sub conv {
	my ($contentref, $kanjicode, $icode) = @_;
	&init;
	if($::lang eq "ja") {
		$$contentref=~s/\xef\xbd\x9e/\xe3\x80\x9c/g;# 〜 # comment
		if($Code::Method eq "Jcode") {
			&Jcode::convert($contentref, $kanjicode, $icode);
		}
		$$contentref=~s/\xe3\x80\x9c/\xef\xbd\x9e/g;# 〜 # comment
	}
	return $$contentref;
}

sub h2z {
	my($s)=shift;
	my $buf;
	&init;
	if($Code::Method eq "Jcode") {
		$buf=Jcode->new($s)->h2z;
	}
	$buf;
}


sub tr {
	my($s, $src, $dst)=@_;
	my $buf;
	&init;
	if($Code::Method eq "Jcode") {
		$buf=Jcode->new($s)->tr($src, $dst);
	}
	$buf;
}

sub hanzen {
	my($s, $code)=@_;
	&init;
	if($code eq "euc") {
		return &tr($s, $Code::han, $Code::zen);
	} else {
		my $ss=&conv(\$s, "euc", $code);
		$ss=&tr($ss, $Code::han, $Code::zen);
		return &conv(\$s, $code, "euc");
	}
}

sub zenhan {
	my($s, $code)=@_;
	&init;
	if($code eq "euc") {
		return &tr($s, $Code::zen, $Code::han);
	} else {
		my $ss=&conv(\$s, "euc", $code);
		$ss=&tr($ss, $Code::zen, $Code::han);
		return &conv(\$s, $code, "euc");
	}
}

sub mime_encode {
	my($s)=@_;
	&init;
	if($Code::Method eq "Jcode") {
		return Jcode->new($s)->mime_encode;
	}
}

sub load_module {
	my $funcp = $::functions{"load_module"};
	return &$funcp(@_);
}

1;
__END__

=head1 NAME

Nana::Code - Code convert wrapper module

=head1 SEE ALSO

=over 4

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/Nana/Code.pm?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/Nana/Code.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/Nana/Code.pm?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/Nana/Code.pm?view=log>

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
