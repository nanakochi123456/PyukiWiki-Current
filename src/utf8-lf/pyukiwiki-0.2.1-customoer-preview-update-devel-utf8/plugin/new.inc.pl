######################################################################
# new.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:16:42
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo http://nekyo.qp.land.to/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################

$new::dates_short=1*24*60*60
	if(!defined($new::dates_short));
$new::dates_long=5*24*60*60
	if(!defined($new::dates_long));
$new::string_short=' <span class="new1">New!</span>'
	if(!defined($new::string_short));
$new::string_long=' <span class="new5">New</span>'
	if(!defined($new::string_long));
######################################################################

sub plugin_new_inline {
	my $date = shift;
	if ($date eq '') { return ''; }

	my $retval = $date;
	my ($mday, $mon, $year) = (localtime())[3..5];

#	my $now = &mktime(0, 0, 0, $mon + 1, $mday, $year + 1900);	# comment
	my $now=Time::Local::timelocal(0,0,0,$mday,$mon,$year);
	$date =~ /(\d+)-(\d+)-(\d+)/;
#	my $past = &mktime(0, 0, 0, $2, $3, $1);					# comment
	my $past=Time::Local::timelocal(0,0,0,$3,$2-1,$1-1900);
	if (($now - $past) <= $new::dates_short) {
		$retval .= $new::string_short;
	} elsif (($now - $past) <= $new::dates_long) {
		$retval .= $new::string_long;
	}
	return '<span class="comment_date">' . $retval . '</span>';
}

1;
__END__

=head1 NAME

new.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

 &new{2006-01-01 (Sun) 00:00:00};

=head1 DESCRIPTION

When the specified contents are less than regular dates, it is displayed as New.

=head1 USAGE

 &new(date-format);

=head1 SETTING

=over 4

=item my $new::dates_short

Setup regular dates of print 'New!'

=item my $new::dates_long

Setup regular dates of print 'New'

=item my $new::string_short

Setting displayed text which time of setuped by $new::dates_short.

=item my $new::string_long

Setting displayed text which time of setuped by $new::dates_long.

=back

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Standard/new

L<http://pyukiwiki.info/PyukiWiki/Plugin/Standard/new/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/new.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/new.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/new.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/new.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

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
