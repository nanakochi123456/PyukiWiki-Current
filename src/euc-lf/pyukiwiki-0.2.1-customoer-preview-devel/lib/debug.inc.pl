######################################################################
# debug.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:18:59
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'debug.inc.cgi'
# WARNING!: Internet Explorer or FireFox Only...TT
# Can't use xhtml11 mode
######################################################################

use strict;

$::debug_authadmin=1
	if(!defined($::debug_authadmin));

$::mode_debug=1;

sub plugin_debug_init {
	# コマンドライン処理
	for(my $i=0; defined($ARGV[$i]); $i++) {
		if($ARGV[$i]=~/=/) {
			my($l, $r)=split(/=/, $ARGV[$i]);
			$::form{$l}=$r;
		}
	}

	# 管理者認証なし
	&exec_explugin_sub("authadmin_cookie");
	if($::_exec_plugined{"authadmin_cookie"} < 2 || $::debug_authadmin eq 0) {
		&jscss_include("debugscript:_Display","",99);
		return(
#			'http_header'=>"X-PyukiWiki-Version: $::version Debug (No auth)",
			'init'=>1,
			'func'=>'_db',
			'_db'=>\&_db,
		);
	}

	# cookie認証通らない場合無効
	if($::authadmin_cookie_user_name ne $::authadmin_cookie_admin_name{admin}
	   && $::debug_authadmin eq 1) {
		return(
			'http_header'=>"X-PyukiWiki-Version: $::version",
			'init'=>0,
		);
	}

	# 管理者認証あり
	&jscss_include("debugscript:_Display","",99);
	return(
#		'http_header'=>"X-PyukiWiki-Version: $::version Debug (Authed)",
		'init'=>1,
		'func'=>'_db',
		'_db'=>\&_db,
	);
}

sub _db {
	my ($pagebody)=@_;
	my $envs;
	my $forms;
	my $body;
	my $jsclose;

	# cookie認証通らない場合無効
	if($::authadmin_cookie_user_name ne $::authadmin_cookie_admin_name{admin}
		&& $::debug_authadmin eq 1) {
		return $pagebody;
	}

	foreach(keys %ENV) {
		$envs.="$_=$ENV{$_}\n";
	}
	foreach(keys %::form) {
		$forms.="$_=$::form{$_}\n";
	}
	my @DB;
	my %DB;

	push(@DB,"debug");
	push(@DB,"form");
	push(@DB,"http");
	push(@DB,"env");
	push(@DB,"js");

	$DB{debug_msg}="Debug Msg(\$::debug)";
	$DB{debug_arg}=$::debug;
	$DB{form_msg}="Form Data";
	$DB{form_arg}=$forms;
	$DB{http_msg}="HTTP Header";
	$DB{http_arg}=$::HTTP_HEADER;
	$DB{env_msg}="Environment";
	$DB{env_arg}=$envs;
	$DB{js_msg}="JavaScript";
	$DB{js_arg}="";

	$body=<<EOM;
<table width="100%"><form>
<tr><th class="style_th">
EOM
	foreach my $db1(@DB) {
		$jsclose.="_Display('$db1','none');";
	}
	foreach my $db1(@DB) {
		$body.=<<EOM;
[<a href="javascript:$jsclose _Display('$db1','view');">$DB{$db1 . '_msg'}</a>]
EOM
	}
	$body.=<<EOM;
[<a href="javascript:$jsclose">X</a>]</th></tr>
EOM
	foreach my $db1(@DB) {
		$body.=<<EOM;
<tr><td class="style_td" style="display: none;" id="$db1" align="center"><textarea cols="100" rows="5" name="db_$db1" id="db_$db1">@{[&htmlspecialchars($DB{$db1 . '_arg'},1)]}</textarea></td></tr>
EOM
	}
	$body.=<<EOM;
</form></table>
EOM

	$pagebody=~s!<div id="navigator">!$body<div id="navigator">!g;
	return $pagebody;
}

1;
__DATA__
sub plugin_debug_setup {
	return(
		en=>'PyukiWiki Debug Plugin',
		override=>'_db',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/debug/'
	);
__END__

=head1 NAME

debug.inc.pl - PyukiWiki Developpers Plugin

=head1 SYNOPSIS

Instant debugger for PyukiWiki

=head1 DESCRIPTION

value $::debug, the received form data, Cookie (un-mounting), a HTTP header, and a server environment variable are displayed on the page upper part.

=head1 USAGE

rename to debug.inc.cgi

=head1 OVERRIDE

_db function was overrided.

=head1 WARNING

Now, only Internet Explorer is supported.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/ExPlugin/debug

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/debug/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/debug.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/debug.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/debug.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/debug.inc.pl?view=log>

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
