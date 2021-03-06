######################################################################
# ImageSize.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:15:53
#
# "Nana::ImageSize" ver 0.1 $$
# Author Nanami
# http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
package	Nana::ImageSize;
use 5.005;
use strict;
use integer;
use Exporter;
use vars qw($VERSION @ISA @EXPORTER @EXPORT_OK);
@EXPORT_OK = qw(imgsize);
@ISA = 'Exporter';
$VERSION = '0.1';
sub imgsize {
	my ($file, $type) = @_;
	my $width  = 0;
	my $height = 0;
	my ($data, $m, $c, $l);
	my $fp;
	if ($file =~ /\.[Jj][Pp][Ee]?[Gg]$/i || $type eq lc "jpg") {
		open($fp, "$file") || return (0, 0);
		binmode $fp;
		read($fp, $data, 2);
		while (1) {
			read($fp, $data, 4);
			($m, $c, $l) = unpack("a a n", $data);
			if ($m ne "\xFF") {
				$width = $height = 0;
				last;
			} elsif ((ord($c) >= 0xC0) && (ord($c) <= 0xC3)) {
				read($fp, $data, 5);
				($height, $width) = unpack("xnn", $data);
				last;
			} else {
				read($fp, $data, ($l - 2));
			}
		}
		close($fp);
	} elsif ($file =~ /\.[Gg][Ii][Ff]$/i || $type eq lc "gif") {
		open($fp, "$file") || return (0,0);
		binmode($fp);
		sysread($fp, $data, 10);
		close($fp);
		$data = substr($data, -4) if ($data =~ /^GIF/);
		$width  = unpack("v", substr($data, 0, 2));
		$height = unpack("v", substr($data, 2, 2));
	} elsif ($file =~ /\.[Pp][Nn][Gg]$/i || $type eq lc "png") {
		open($fp, "$file") || return (0,0);
		binmode($fp);
		read($fp, $data, 24);
		close($fp);
		$width  = unpack("N", substr($data, 16, 20));
		$height = unpack("N", substr($data, 20, 24));
	}
	return ($width, $height);
}
1;
__END__
