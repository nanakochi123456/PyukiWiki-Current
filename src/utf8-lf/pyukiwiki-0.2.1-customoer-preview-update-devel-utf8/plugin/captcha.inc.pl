######################################################################
# captcha.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 12:57:26
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is sub plugin of captcha.inc.cgi
######################################################################

use strict;
use warnings;
use GD;
use File::Spec;

sub getvalue {
	my ($v)=@_;
	if(ref($v) eq "ARRAY") {
		my @v=@{$v};
		return $v[int(rand($#v+1))];
	} else {
		return $v;
	}
}
sub getcolor {
	my($obj, $color)=@_;
	my $tmpcolor=&getvalue($color);

	if($tmpcolor=~/^#([0-9A-Fa-f][0-9A-Fa-f])([0-9A-Fa-f][0-9A-Fa-f])([0-9A-Fa-f][0-9A-Fa-f])$/) {
		return $obj->colorAllocate(hex($1),hex($2),hex($3));
	}
	return undef;
}

sub plugin_captcha_action {
	return if($::form{mode} ne "image");

	srand();

	my $chk=1;
	for(my $i=1; $i<100; $i++) {
		$chk=$i if(defined($captcha::parm{$i}->{fontcolor}));
	}

	return if($::form{teststring} eq "");
	my($captcha_lang, $rand, $tmpstr)=&plugin_captcha_random($::form{teststring});
	my $str=$tmpstr;

	my $width=$captcha::parm{$captcha_lang}->{width};
	my $height=$captcha::parm{$captcha_lang}->{height};
	my $im = new GD::Image($width, $height);
	$im->trueColor(1);


	# 背景色として塗りつぶし四角を描く				# comment
	$im->filledRectangle(0, 0, $width-1, $height-1, &getcolor($im, $captcha::parm{$rand}->{bgcolor}));

	# 外枠を描画									# comment
	$im->rectangle(0, 0, $width-1, $height-1, &getcolor($im, $captcha::parm{$rand}->{backlinecolor}));

	# 文字の前に線と丸を書く						# comment
	for(my $i=0; $i<$captcha::parm{$rand}->{rndlines}; $i++) {
		$im->line(
			rand($width-1), rand($height-1)
		  , rand($width-1), rand($height-1)
		  , &getcolor($im, $captcha::parm{$rand}->{rndcolors})
		);
	}

	for(my $i=0; $i<$captcha::parm{$rand}->{rndcircles}; $i++) {
		$im->arc(
			rand($width-1), rand($height-1)
		  , rand($width-1), rand($height-1)
		  , 0, 360
		  , &getcolor($im, $captcha::parm{$rand}->{rndcolors})
		);
	}

	my $PI=3.141592;
	my $str_x=10;
	my $str_y=40;
	my $ut8encoded;
	if($::defaultcode eq "utf8") {
		$ut8encoded=$str;
	} else {
		$ut8encoded=&code_convert(\$str, "utf8", "euc");
	}
	utf8::decode($ut8encoded);
	my $bkfontcolor;
	for(my $i=0; $i<length($ut8encoded); $i++) {
		my $char=substr($ut8encoded, $i, 1);
		utf8::encode($char);
		my $fontcolor=&getcolor($im, $captcha::parm{$rand}->{fontcolor});
     	# 文字を描画								# comment
		my $size=&getvalue($captcha::parm{$captcha_lang}->{size});
     	$im->stringFT($fontcolor,
				File::Spec->rel2abs(&getvalue($captcha::parm{$captcha_lang}->{font})),
				$size,
				&getvalue($captcha::parm{$captcha_lang}->{angle}) * ($PI/180),
				$str_x + $size*$i * &getvalue($captcha::parm{$captcha_lang}->{space}), $str_y,
				$char);
	}

	# 文字の後に線と丸を書く					# comment
	for(my $i=0; $i<$captcha::parm{$rand}->{lastrndlines}; $i++) {
		$im->line(
			rand($width-1), rand($height-1)
		  , rand($width-1), rand($height-1)
		  , &getcolor($im, $captcha::parm{$rand}->{rndcolors})
		);
	}

	for(my $i=0; $i<$captcha::parm{$rand}->{lastrndcircles}; $i++) {
		$im->arc(
			rand($width-1), rand($height-1)
		  , rand($width-1), rand($height-1)
		  , 0, 360
		  , &getcolor($im, $captcha::parm{$rand}->{rndcolors})
		);
	}

	print &http_header("Content-type: image/png");
	binmode STDOUT;
	print $im->png;
	exit;
}
1;
__END__
=head1 NAME

captcha.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 ?cmd=captcha

=head1 DESCRIPTION

Sub plugin for captcha.inc.cgi

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/captcha

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/captcha/>

=item PyukiWiki/Plugin/ExPlugin/captcha

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/captcha/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/captcha.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/captcha.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/captcha.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/captcha.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/captcha.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/captcha.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/captcha.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/captcha.inc.pl?view=log>

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
