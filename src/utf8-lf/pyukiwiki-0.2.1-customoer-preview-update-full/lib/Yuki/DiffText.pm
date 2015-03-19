######################################################################
# DiffText.pm - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:35:24
#
# "Yuki::DiffText" ver 0.1 $$
# Author Hiroshi Yuki
# http://www.hyuki.com/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
package Yuki::DiffText;
use strict;
use Algorithm::Diff qw(traverse_sequences);
use vars qw($VERSION @EXPORT_OK @ISA);
use vars qw($diff_text $diff_msgrefA $diff_msgrefB @diff_deleted @diff_added);
require Exporter;
@ISA = qw(Exporter);
@EXPORT_OK = qw(difftext);
$VERSION = '0.1';
sub difftext {
	($diff_msgrefA, $diff_msgrefB) = @_;
	undef $diff_text;
	undef @diff_deleted;
	undef @diff_added;
	traverse_sequences(
		$diff_msgrefA, $diff_msgrefB,
		{
			MATCH => \&df_match,
			DISCARD_A => \&df_delete,
			DISCARD_B => \&df_add,
		}
	);
	&diff_flush;
	return $diff_text;
}
sub diff_flush {
	$diff_text .= join('', map { "-$_\n" } splice(@diff_deleted));
	$diff_text .= join('', map { "+$_\n" } splice(@diff_added));
}
sub df_match {
	my ($a, $b) = @_;
	&diff_flush;
	$diff_text .= "=$diff_msgrefA->[$a]\n";
}
sub df_delete {
	my ($a, $b) = @_;
	push(@diff_deleted, $diff_msgrefA->[$a]);
}
sub df_add {
	my ($a, $b) = @_;
	push(@diff_added, $diff_msgrefB->[$b]);
}
1;
__END__
