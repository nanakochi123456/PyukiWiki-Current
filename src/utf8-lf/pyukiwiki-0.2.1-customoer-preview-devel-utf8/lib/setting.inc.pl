######################################################################
# setting.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-20 09:09:37
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nanakochi.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF UTF-8 4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'setting.inc.cgi'
######################################################################

# Initlize											# comment

%::setting_cookie;
$::setting_cookie="PWS_"
				. &dbmname($::basepath);
%::name_cookie;
$::name_cookie="PWU_"
				. &dbmname($::basepath);

sub plugin_setting_init {
	&exec_explugin_sub("lang");
	&exec_explugin_sub("urlhack");
	if($::navi{"setting_url"} eq '') {
		push(@::addnavi,"setting:help");
		$::navi{"setting_url"}="$::script?cmd=setting&amp;mypage=@{[&encode($::form{mypage} ne '' ? $::form{mypage} : $::form{refer})]}";
		$::navi{"setting_name"}=$::resource{"settingbutton"};
		$::navi{"setting_type"}="plugin";
	}
	%::setting_cookie=();
	%::setting_cookie=&getcookie($::setting_cookie,%::setting_cookie);
	%::name_cookie=&getcookie($::name_cookie,%::name_cookie);
	if($::setting_cookie{savename} eq 0) {
		if($::name_cookie{myname} ne '') {
			$::name_cookie{myname}="";
			$::name_cookie{myurl}="";
			$::name_cookie{mymail}="";
			&setcookie($::name_cookie, -1, %::name_cookie);
		}
	}
	&plugin_setting_setting;
	return ('init'=>1);
}

sub plugin_setting_savename {
	my($name, $url, $mail)=@_;
	$::name_cookie{myname}=$name;
	$::name_cookie{myurl}=$url if($url=~/$::isurl/o && $url ne "");
	$::name_cookie{mymail}=$mail if($mail=~/$::ismail/o && $mail ne "");

	&setcookie($::name_cookie, 1, %::name_cookie);
}

sub plugin_setting_setting {
	if($::setting_cookie{style} ne '') {
		my $style=$::setting_cookie{style};
		if($style!~/\//) {
#			my $push=$::skin_name;			# comment
			# bug fix 0.2.0-p3				# comment
			if($style=~/^\w{1,64}$/) {
				$::skin_name=$style;
				&skin_init;
			}
#			$::skin_name=$push;				# comment
		}
	}
	if($::setting_cookie{fontsize}+0 > 0) {
		$::IN_HEAD.=<<EOM
<style type="text/css"><!--
#body{font-size:@{[$::setting_cookie{fontsize} eq 1 ? '120' : '90']}%;}
//--></style>
EOM
	}

	my $escapeoff=0;
	if(defined($::setting_cookie{escapeoff})) {
		$escapeoff=$::setting_cookie{escapeoff}+0;
	} else {
		$escapeoff=$::use_escapeoff+0;
	}
	&escapeoff($escapeoff);
}
1;
__DATA__
sub plugin_setting_setup {
	return(
		ja=>'cookieに対してWikiの表示設定をする',
		en=>'Setup of Wiki is carried out to cookie.',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/Admin/setting/'
	);
__END__

=head1 NAME

setting.inc.pl - PyukiWiki ExPlugin

=head1 SYNOPSIS

This is plugin/setting.inc.pl 's sub plugin, look plugin document.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Admin/setting

L<http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/punyurl/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/setting.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/setting.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/setting.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/setting.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/setting.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/setting.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/setting.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/setting.inc.pl?view=log>

=back

=head1 AUTHOR

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=head1 LICENSE

(C)2005-2015 by Nanami.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
