######################################################################
# img.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:14:37
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
# �摜��\������B
# :����|
#  #img(�摜��URI[,����][,alt�R�����g][,width,height])
# �����Fr,right(�E��) or l,left(����) or center (������)
# or module(index.cgi ����̌Ăяo��)
# or ����ȊO(�N���A)~
# Pyukiwiki Classic v0.1.6b ��肱�̊֐���
# lib/wiki.cgi �� img �ϊ��ł��Ăяo���悤�C���B(�K�{)
######################################################################
# �����Agif, png, jpg, jpeg �łȂ��Ă��Aimg �^�O��\������
$img::force_img_tag=0
	if(!defined(img::force_img_tag));
sub plugin_img_inline {
	return &plugin_img_convert(@_);
}
sub plugin_img_convert {
	my ($uri, $align, $alt, $width, $height) = split(/,/, shift);
	$uri   = &trim($uri);
	$align = &trim($align);
	$alt   = &trim($alt);
	my $module = 0;
	my $res = '';
	if ($align =~ /^(r|right)/i) {
		$align = 'right';
	} elsif ($align =~ /^(l|left)/i) {
		$align = 'left';
	} elsif ($align =~ /^(center)/i) {
		$align = 'center';
	} elsif ($align =~ /^module$/i) {
		$module = 1;
	} elsif ($align ne '') {
		return '<div style="clear:both"></div>';
	}
		if ($uri =~ /\.(gif|png|jpe?g)$/i || $img::force_img_tag eq 1) {
			if ($module == 1) {
				# �K�v�ł���΁A���̕������g������B
				$res .= "<a href=\"$uri\"><img src=\"$uri\" /></a>\n";
			} else {
				$res .= "<div style=\"float:$align; padding:.5em 1.5em .5em 1.5em;\">"
					if($height ne 1 && $width ne 1);
				$res .= "<img src=\"$uri\"";
				$res .= " alt=\"$alt\"" if ($alt ne '');
				if($width ne '' && $height ne '') {
					$res .= " width=\"$width\" height=\"$height\"";
				}
				if($height ne 1 && $width ne 1) {
					$res .= " /></div>\n";
				} else {
					$res .= "/>\n";
				}
			}
		}
	return $res;
}
1;
__END__