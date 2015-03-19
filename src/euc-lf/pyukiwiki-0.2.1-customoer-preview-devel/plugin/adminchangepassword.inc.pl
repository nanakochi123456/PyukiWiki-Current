######################################################################
# adminchangepassword.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:07
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

$adminchangepassword::dummypass="aetipaesgyaigygoqyiwgorygaeta";
$adminchangepassword::setupinicgi=$::setup_file;
$adminchangepassword::minlength=6;
$adminchangepassword::maxlength=32;
$adminchangepassword::tableleftwidth=150;

sub plugin_adminchangepassword_action {
	my $stat,$body;
	&load_wiki_module("auth");
	%::auth=&authadminpassword(submit);
	return('msg'=>"\t$::resource{adminchangepassword_plugin_title}",'body'=>$auth{html})
		if($auth{authed} eq 0);

	my($h,$b,$stat,$body);
	if(defined($::form{extpass})) {
		($stat,$body)=&plugin_adminchangepassword_set;
		if($stat ne 0) {
			($h,$b)=&plugin_adminchangepassword_input($auth{crypt});
			$body.=$b;
		}
	} else {
		($h,$body)=&plugin_adminchangepassword_input($auth{crypt});
	}

	my $in_jshead=<<EOM;


function ViewPassForm(id,mode){
	var	obj,
		block="block",
		none="none";

	if(d.all || d.getElementById){	//IE4, NN6 or later
		if(d.all){
			obj = d.all(id).style;
		}else if(d.getElementById){
			obj = d.getElementById(id).style;
		}
		if(mode == "view") {
			obj.display = block;
		} else if(mode == none) {
			obj.display = none;
		} else if(obj.display == block){
			obj.display = none;		//hidden
		}else if(obj.display == none){
			obj.display = block;		//view
		}
	}
}
@{[$h ne '' ? "\nfunction SetPass(e){$h}" : ""]}
EOM
	return ('msg'=>"\t$::resource{adminchangepassword_plugin_title}", 'body'=>$body,
			'jsheadervalue'=>$in_jshead);
}

sub plugin_adminchangepassword_set {
	my($stat,$body);
	$stat=0;
	if($::form{extpass} eq 1) {
		($stat,$body)=&plugin_adminchangepassword_check("admin",$stat,$body);
		($stat,$body)=&plugin_adminchangepassword_check("frozen",$stat,$body);
		($stat,$body)=&plugin_adminchangepassword_check("attach",$stat,$body);
	} else {
		($stat,$body)=&plugin_adminchangepassword_check("common",$stat,$body);
	}
	$body.=&plugin_adminchangepassword_write if($stat eq 0);
	return($stat,$body);
}

sub plugin_adminchangepassword_write {
	my ($body,$write);
$::debug.="$::form{passwd_common},$::form{passwd_common_enc},$::form{passwd_common_token}\n";
	if($::form{extpass} eq 1) {
		$write=<<EOM;
\$::adminpass = '$adminchangepassword::dummypass';
\$::adminpass{admin} = '@{[&plugin_adminchangepassword_crypt($::form{passwd_admin})]}';
\$::adminpass{frozen} = '@{[&plugin_adminchangepassword_crypt($::form{passwd_frozen})]}';
\$::adminpass{attach} = '@{[&plugin_adminchangepassword_crypt($::form{passwd_attach})]}';
1;
EOM
	} else {
		$write=<<EOM;
\$::adminpass = '@{[&plugin_adminchangepassword_crypt($::form{passwd_common})]}';
\$::adminpass{admin}='';
\$::adminpass{frozen}='';
\$::adminpass{attach}='';
1;
EOM
	}
	if(open(W,">>$adminchangepassword::setupinicgi")) {
		print W $write;
		close(W);
		$body=<<EOM;
$::resource{adminchangepassword_plugin_msg_complete}<br />
<form action="$::script" method="POST" id="adminchangepasswd" name="adminchangepasswd">
<input type="hidden" name="cmd" value="adminchangepassword" />
<input type="submit" value="$::resource{adminchangepassword_plugin_btn_back}" />
</form>
EOM
	} else {
		my $msg=$::resource{adminchangepassword_plugin_err_write};
		$msg=~s/\$FILE/$adminchangepassword::setupinicgi/g;
		$body=<<EOM;
<div class="error">$msg<br />
<form action="$::script" method="POST" id="adminchangepasswd" name="adminchangepasswd">
<input type="hidden" name="cmd" value="adminchangepassword" />
<input type="submit" value="$::resource{adminchangepassword_plugin_btn_back}" />
</form>
EOM
	}
	return $body;
}

sub plugin_adminchangepassword_check {
	my($form,$stat,$body)=@_;

	if($::form{"passwd_" . $form} eq '') {
		$::form{"passwd_" . $form}=&password_decode($::form{"passwd_" . $form},$::form{"passwd_" . $form . "_enc"},$::form{"passwd_" . $form . "_token"});
		$::form{"passwd2_" . $form}=&password_decode($::form{"passwd2_" . $form},$::form{"passwd2_" . $form . "_enc"},$::form{"passwd_" . $form . "_token"});
	}
	if($::form{"passwd_" . $form} eq '') {
		$stat=1;
		$body.=<<EOM;
<div class="error">
$::resource{"adminchangepassword_plugin_" . $form}
$::resource{adminchangepassword_plugin_err_nopass}
</div>
<br />
EOM
	} elsif(length($::form{"passwd_" . $form}) < $adminchangepassword::minlength
	|| length($::form{"passwd_" . $form}) > $adminchangepassword::maxlength) {
		$stat=1;
		my $msg=$::resource{adminchangepassword_plugin_err_strmin};
		$msg=~s/\$MIN/$adminchangepassword::minlength/g;
		$msg=~s/\$MAX/$adminchangepassword::maxlength/g;
		$body.=<<EOM;
<div class="error">
$::resource{"adminchangepassword_plugin_" . $form}$msg
</div>
<br />
EOM
	} elsif($::form{"passwd_" . $form} ne $::form{"passwd2_" . $form}) {
		$stat=1;
		$body.=<<EOM;
<div class="error">
$::resource{"adminchangepassword_plugin_" . $form}
$::resource{adminchangepassword_plugin_err_ignore}
</div>
<br />
EOM
	}
	if($stat eq 1) {
		$::form{"passwd_" . $form}="";
		$::form{"passwd2_" . $form}="";
	}
	return ($stat,$body);
}

sub plugin_adminchangepassword_input {
	my($cryptflg)=@_;

	my $body;
	$body=<<EOM;
<form action="$::script" method="POST" id="adminchangepasswd" name="adminchangepasswd">
<input type="hidden" name="cmd" value="adminchangepassword" />
$auth{html}
<table>
<tr>
<td width="$adminchangepassword::tableleftwidth">$::resource{adminchangepassword_plugin_extpass}:</td>
<td>
<input type="radio" name="extpass" value="0" onclick="ViewPassForm('common','view');ViewPassForm('admin','none');ViewPassForm('frozen','none');ViewPassForm('attach','none');"@{[!&plugin_adminchangepassword_checkmode ? qq( checked="checked") : ""]} />
$::resource{adminchangepassword_plugin_nouse}
<input type="radio" name="extpass" value="1" onclick="ViewPassForm('common','none');ViewPassForm('admin','view');ViewPassForm('frozen','view');ViewPassForm('attach','view');"@{[&plugin_adminchangepassword_checkmode ? qq( checked="checked") : ""]} />
$::resource{adminchangepassword_plugin_use}
</td>
</tr>
</table>
EOM
	$body.=&plugin_adminchangepassword_makepasswdform("common"
		,!&plugin_adminchangepassword_checkmode ? "block" : "none");
	$body.=&plugin_adminchangepassword_makepasswdform("admin"
		,&plugin_adminchangepassword_checkmode ? "block" : "none");
	$body.=&plugin_adminchangepassword_makepasswdform("frozen"
		,&plugin_adminchangepassword_checkmode ? "block" : "none");
	$body.=&plugin_adminchangepassword_makepasswdform("attach"
		,&plugin_adminchangepassword_checkmode ? "block" : "none");

	$body.=<<EOM;
<table>
<tr>
<td width="$adminchangepassword::tableleftwidth">&nbsp;</td>
EOM

	my $js;
	if($cryptflg) {
		$js.="if(keypress(e)==false) return;";
		$js.="var f=gid('adminchangepasswd');";
		foreach("common","admin","frozen","attach") {
			$js.="pencf(f.passwd\_$_,f.passwd\_$_\_enc,f.passwd\_$_\_token);";
			$js.="pencf(f.passwd2\_$_,f.passwd2\_$_\_enc,f.passwd2\_$_\_token);";
		}
		$js.="fsubmitdelay('adminchangepasswd',e);";

		$body.=<<EOM;
<td><input type="button" value="$::resource{adminchangepassword_plugin_btn_submit}" onclick="SetPass();" onkeypress="SetPass(event);" />
</td>
EOM
	} else {
		$body.=<<EOM;
<td><input type="submit" value="$::resource{adminchangepassword_plugin_btn_submit}" />
</td>
EOM
	}
	$body.=<<EOM;
</tr>
</table>
</form>
EOM
	return ($js,$body);
}

sub plugin_adminchangepassword_crypt {
	my($passwd)=@_;
	$passwd=~s/\t.*//g;

	&load_module("Nana::Crypt");
	return Nana::Crypt::encode($passwd);
}

sub plugin_adminchangepassword_checkmode {
	return $::form{extpass} if(defined($::form{extpass}));
	return 1 if($::adminpass{admin} ne '');
	return 0;
}

sub plugin_adminchangepassword_makepasswdform {
	my ($v,$s)=@_;
	return <<EOM;
<table style="display: $s;" id="$v">
<tr>
<td width="$adminchangepassword::tableleftwidth">$::resource{"adminchangepassword_plugin_" . $v}:</td>
<td>@{[&passwordform($::form{"passwd_" . $v},"","passwd_" . $v)]}</td>
</tr>
<tr>
<td>$::resource{adminchangepassword_plugin_reinput}:</td>
<td>@{[&passwordform($::form{"passwd_" . $v},"","passwd2_" . $v)]}</td>
</tr>
</table>
EOM
}

1;
__DATA__

sub plugin_adminchangepassword_usage {
	return {
		name => 'adminchangepassword',
		version => '1.3',
		type => 'admin,command',
		author => 'Nanami',
		syntax => '?cmd=adminchangepassword',
		description => "Change Administrator's password (or frozen, attach)",
',
		description_ja => '管理パスワード（凍結・添付）を変更する。',
		example => 'http://example/?cmd=adminchangepassword',
	};
}

1;
__END__

=head1 NAME

adminchangepassword.inc.pl - PyukiWiki Administrator's Plugin

=head1 SYNOPSIS

 ?cmd=adminchangepassword

=head1 DESCRIPTION

Change Administrator's password (or frozen, attach)

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Admin/adminchangepassword

L<http://pyukiwiki.info/PyukiWiki/Plugin/Admin/adminchangepassword/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/adminchangepassword.inc.pl?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/adminchangepassword.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/adminchangepassword.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/adminchangepassword.inc.pl?view=log>

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
