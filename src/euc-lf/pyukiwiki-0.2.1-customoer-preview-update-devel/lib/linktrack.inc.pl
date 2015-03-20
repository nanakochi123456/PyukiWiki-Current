######################################################################
# linktrack.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 08:45:45
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'linktrack.inc.cgi'
######################################################################
#
# リンクトラッキングカウンター
#
######################################################################

# この変数に自分のURL（http://等を除く) を入れれば、
# その分のカウンターを弾く
#
$linktrack::ignoredomain = $ENV{HTTP_HOST}
	if($linktrack::ignoredomain eq '');

$linktrack::cgilink=0
	if(!defined($linktrack::cgilink));

$linktrack::refresh=1
	if(!defined($linktrack::refresh));

######################################################################

# Initlize												# comment

sub plugin_linktrack_init {
	my $jsheader=<<EOM;
var mypage='$::form{mypage}';
var script='$::script';
EOM
	return ('init'=>1, 'jsheadervalue'=>$jsheader
		, 'func'=>'make_link_target', 'make_link_target'=>\&make_link_target);
}

$::linktrack_link_id=0;

sub make_link_target {
	my($url,$class,$target,$escapedchunk,$flag)=@_;
	$flag=$::use_popup if($flag eq '');
	$class=&htmlspecialchars($class);
	$target=&htmlspecialchars($target);
	$escapedchunk=&htmlspecialchars($escapedchunk);
	my $popup_allow=$::setting_cookie{popup} ne '' ? $::setting_cookie{popup}
					: $flag+0 ? 1 : 0;
	my $target=$popup_allow != 0 ? $target : '';
	$target='' if($flag eq 2 && $url=~/ttp\:\/\/$ENV{HTTP_HOST}/);
	if($target ne '' && $flag eq 3) {
		my $tmp=$::basehref;
		$tmp=~s/\/.*//g;
		$target='' if($url=~/\Q$tmp/);
	}
	my $mydomain=0;
	foreach(split(/,/,$linktrack::ignoredomain)) {
		if($url=~/\/\/$_/) {
			$mydomain=1;
		}
	}
	my $escapedurl;
	if($mydomain eq 0) {
#		$escapedurl="?cmd=ck&amp;p=" . &escape($::form{mypage}) . "&amp;lk=" . &dbmname(&unescape($url));
		my $mp=&dbmname(&unescape($::form{mypage}));
#		$escapedurl="p=" . $mp . "&amp;l=" . &dbmname(&unescape($url));
		$::linktrack_link_id++;
		if($target eq '') {
			return qq(<a href="@{[&mkurl($url)]}" @{[$class eq '' ? '' : qq(class="$class")]} title="$escapedchunk"@{[&mkurl($url,"onclick","")]}@{[&mkurl($url,"oncontextmenu","r")]}>);
		} elsif($::is_xhtml) {
			return qq(<a href="@{[&mkurl($url)]}" @{[$class eq '' ? '' : qq(class="$class")]} title="$escapedchunk"@{[&mkurl($url,"onclick",$target eq "_blank" ? "b" : $target)]}@{[&mkurl($url,"oncontextmenu","r")]}>);
		} else {
			return qq(<a href="@{[&mkurl($url)]}" @{[$class eq '' ? '' : qq(class="$class")]} title="$escapedchunk"@{[&mkurl($url,"onclick",$target eq "_blank" ? "b" : $target)]}@{[&mkurl($url,"oncontextmenu","r")]}>);
		}
	} else {
		if($target eq '') {
			return qq(<a href="@{[&mkurl($url)]}" @{[$class eq '' ? '' : qq(class="$class")]} title="$escapedchunk">);
		} elsif($::is_xhtml) {
			return qq(<a href="@{[&mkurl($url)]}" @{[$class eq '' ? '' : qq(class="$class")]} title="$escapedchunk"@{[&mkurl($url,"ou",$target eq "_blank" ? "b" : $target)]}>);

		} else {
			return qq(<a href="@{[&mkurl($url)]}" @{[$class eq '' ? '' : qq(class="$class")]} target="$target" title="$escapedchunk">);
		}
	}
}

sub mkurl {
	my($url, $flg, $taget)=@_;
	if($flg eq "onclick") {
		if($linktrack::cgilink eq 1) {
			return "";
		}
		if($target eq "") {
			return qq( onclick="return Ck(this,this.href);");
		} else {
			return qq( onclick="return Ck(this,this.href,'$target');");
		}
	}
	if($flg eq "oncontextmenu") {
		if($linktrack::cgilink eq 1) {
			return "";
		}
		return qq( oncontextmenu="return Ck(this,this.href,'r');");
	}
	if($flg eq "ou") {
		return qq( onclick="return ou(this.href,'$target');");
	}
	if($linktrack::cgilink eq 1) {
		my $hs=&dbmname($::form{mypage});
		my $lk=&dbmname($url);
		my $urlbase="$::script?cmd=ck&amp;p=$hs&amp;l=$lk";
		return $urlbase;
	}
	return $url;
}

1;
__DATA__
sub plugin_linktrack_setup {
	return(
		en=>'Out link to tracking counter.',
		jp=>'外部リンクへのカウンターを取る',
		override=>'make_link_target',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/linktrack/'
	);
__END__

=head1 NAME

linktrack.inc.pl - PyukiWiki Plugin

=head1 SYNOPSIS

Out link to tracking counter

=head1 USAGE

rename to linktrack.inc.cgi

setting info/setup.cgi to this value for use.

$linktrack::ignoredomain : my wiki url (default = Hostname)

Example, http:// prefix do not writte.

To specify multiple Separate of [,]

example : abcdefg.com/~user,example.com

=head1 OVERRIDE

make_link_target function was overrided.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/linktrack

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/linktrack/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/linktrack.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/linktrack.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/linktrack.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/linktrack.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

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
