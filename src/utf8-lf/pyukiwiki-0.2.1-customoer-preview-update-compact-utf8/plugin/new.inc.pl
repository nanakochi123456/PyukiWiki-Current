######################################################################
# new.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
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
	my $now=Time::Local::timelocal(0,0,0,$mday,$mon,$year);
	$date =~ /(\d+)-(\d+)-(\d+)/;
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
