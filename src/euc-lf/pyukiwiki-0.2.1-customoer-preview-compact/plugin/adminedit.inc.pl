######################################################################
# adminedit.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nekyo
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF Shift-JIS 4Spaces GPL3 and/or Artistic License
######################################################################
use strict;
sub plugin_adminedit_action {
	if (1 == &exist_plugin('edit')) {
		my ($page) = &unarmor_name(&armor_name($::form{mypage}));
		my $body;
		if (not &is_editable($page)) {
			$body .= qq(<p><strong>$::resource{edit_plugin_cantchange}</strong></p>);
		} else {
			$body .= qq(<p><strong>$::resource{adminedit_plugin_passwordneeded}</strong></p>);
			# 2005.11.2 pochi: �����ҏW���\�� (thanks Walrus)	# comment
			my $pagemsg;
			if ($::form{mypart} =~ /^\d+$/ and $::form{mypart}) {
				my $mymsg = (&read_by_part($page))[$::form{mypart} - 1];
				$pagemsg = \$mymsg;
			} else {
				# original
				$pagemsg = \$::database{$page};
			}
			$body .= &plugin_edit_editform($$pagemsg,
				&get_info($page, $::info_ConflictChecker), admin=>1);
		}
		return ('msg'=>"$page\t$::resource{adminedit_plugin_title}", 'body'=>$body, 'ispage'=>1);
	}
	return "";
}
1;
__DATA__
sub plugin_adminedit_usage {
	return {
		name => 'adminedit',
		version => '3.0',
		type => 'admin,command',
		author => 'Nanami',
		syntax => '?cmd=adminedit&mypage=pagename',
		description => 'Edit page and frozen/unfrozen page.',
		description_ja => '�w�肵���y�[�W��ҏW�E��������',
		example => 'http://example/?cmd=adminedit&mypage=pagename',
	};
}
1;
__END__