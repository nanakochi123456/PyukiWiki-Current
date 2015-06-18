######################################################################
# wiki_auth.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 10:38:58
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
$::Token='';
	# 2005.10.27 pochi: 添付用パスワードを設置			# comment
	# 汎用管理パスワード対応							# comment
	# $::adminpass / $::adminpass{attach} ....			# comment
	# 2012.09.12 MD5 / SHA1等対応						# comment
sub _valid_password {
	my ($givenpassword,$type,$enc,$token) = @_;
	$givenpassword=&password_decode($givenpassword,$enc,$token);
	&load_module("Nana::Crypt");
	if($::adminpass{$type} eq "") {
		return Nana::Crypt::check($givenpassword, $::adminpass);
	}
	return Nana::Crypt::check($givenpassword, $::adminpass{$type});
}
sub _passwordform {
	my($default,$mode,$formname,$enc,$token,$size,$minlength,$maxlength,$style, $add)=@_;
	$formname="mypassword" if($formname eq '');
	my $size=10 if($size+0 eq 0);
	$maxlength=32 if($maxlength+0 eq 0);
	if(&iscryptpass) {
		if($enc eq '') {
			$cryptpassform=<<EOM;
<input type="hidden" name="$formname\_enc" id="$formname\_enc" value="" /><input type="hidden" id="$formname\_token" name="$formname\_token" value="$::Token" />
EOM
		} else {
			my $newpass=&password_encode(&password_decode('',$enc,$token), $::Token);
			$cryptpassform=<<EOM;
<input type="hidden" name="$formname\_enc" id="$formname\_enc" value="$newpass" /><input type="hidden" name="$formname\_token" id="$formname\_token" value="$::Token" />
EOM
		}
	}
	if($mode eq 'hidden') {
		return qq(<input type="hidden" name="$formname" id="$formname" value="$default" />$cryptpassform);
	} elsif($default eq '') {
		return qq(<input type="password" name="$formname" id="$formname" value="" size="$size" minlength="$minlength" maxlength="$maxlength" @{[$style eq "" ? "" : qq(style="$style") ]} $add />$cryptpassform);
	} else {
		return qq(<input type="password" name="$formname" id="$formname" value="$default" size="$size" minlength="$minlength" maxlength="$maxlength" @{[$style eq "" ? "" : qq(style="$style") ]} $add />$cryptpassform);
	}
}
sub _authadminpassword {
	my($mode,$title,$type)=@_;
	my $body;
	$type=($type eq "attach" ? "attach" : $type eq "frozen" ? "frozen" : "admin");
	if($mode=~/submit|page|form/) {
		$title=$::resource{admin_passwd_prompt_title} if($title eq '');
		if(!&valid_password($::form{"mypassword_$type"},$type,$::form{"mypassword_$type\_enc"},$::form{"mypassword_$type\_token"})) {
			$body=<<EOM;
<h2>$title</h2>
@{[$ENV{REQUEST_METHOD} eq 'GET' && $::form{mypassword} eq '' ? '' : qq(<div class="error">$::resource{admin_passwd_prompt_error}</div>\n)]}
<form action="$::script" method="post" id="adminpasswordform" name="adminpasswordform">
$::resource{admin_passwd_prompt_msg}@{[&passwordform('','',"mypassword_$type")]}
EOM
			if(&iscryptpass) {
				$body.=<<EOM;
<span id="submitbutton"></span>
<noscript><input type="submit" value="$::resource{admin_passwd_button}" /></noscript>
EOM
				$::IN_JSHEAD.=<<EOM;
	gid("submitbutton").innerHTML='<input type="button" value="$::resource{admin_passwd_button}" onclick="fsubmit(\\'adminpasswordform\\',\\'$type\\');" onkeypress="fsubmit(\\'adminpasswordform\\',\\'$type\\',event);" />';
EOM
			} else {
				$body.=<<EOM;
<input type="submit" value="$::resource{admin_passwd_button}" />
EOM
			}
			foreach my $forms(keys %::form) {
				$body.=qq(<input type="hidden" name="$forms" value="$::form{$forms}" />\n)
					if($forms!~/^mypassword/);
			}
			$body.="</form>\n";
			return('authed'=>0,'html'=>$body, 'crypt'=>&iscryptpass);
		} else {
			$body.=qq(@{[&passwordform($::form{"mypassword\_$type"},"hidden","mypassword\_$type",$::form{"mypassword\_$type\_enc"},$::form{"mypassword\_$type\_token"})]}\n);
			return('authed'=>1,'html'=>$body, 'crypt'=>&iscryptpass);
		}
	} else {
		if(!&valid_password($::form{"mypassword_$type"},$type,$::form{"mypassword_$type\_enc"},$::form{"mypassword_$type\_token"})) {
			$body.=<<EOM;
@{[$ENV{REQUEST_METHOD} eq 'GET' && $::form{mypassword} eq '' ? '' : qq(<div class="error">$::resource{admin_passwd_prompt_error}</div>)]}
EOM
			$body.=qq(@{[$title ne '' ? $title : $::resource{admin_passwd_prompt_msg}]}@{[&passwordform('','',"mypassword_$type")]}\n);
			return('authed'=>0,'html'=>$body, 'crypt'=>&iscryptpass);
		} else {
			$body.=qq(@{[&passwordform($::form{"mypassword\_$type"},"hidden","mypassword\_$type",$::form{"mypassword\_$type\_enc"},$::form{"mypassword\_$type\_token"})]}\n);
			return('authed'=>1,'html'=>$body, 'crypt'=>&iscryptpass);
		}
	}
}
sub _password_decode {
	&load_module("Nana::Enc");
	return Nana::Enc::decode(@_);
}
sub _password_encode {
	&load_module("Nana::Enc");
	return Nana::Enc::encode(@_);
}
sub _iscryptpass {
	&load_module("Nana::Enc");
	return Nana::Enc::iscryptpass(@_);
}
sub _maketoken {
	&load_module("Nana::Enc");
	return Nana::Enc::maketoken(@_);
}
1;
