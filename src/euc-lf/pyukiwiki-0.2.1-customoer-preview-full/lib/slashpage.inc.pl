######################################################################
# slashpage.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF EUC-JP TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# This is extented plugin.
# To use this plugin, rename to 'slashpage.inc.cgi'
######################################################################
use strict;
sub plugin_slashpage_init {
	&exec_explugin_sub("lang");
	@::PLUGIN_SLASHPAGE_STACK=();
	foreach my $pages (keys %::database) {
		push(@::PLUGIN_SLASHPAGE_STACK,$pages) if($pages=~/\//);
	}
	@::PLUGIN_SLASHPAGE_STACK=sort @::PLUGIN_SLASHPAGE_STACK;
	my $req=$ENV{QUERY_STRING};
	if($req ne '' && $::form{mypage} eq $::FrontPage && ($::form{cmd} eq '' || $::form{cmd} eq 'read')) {
		if (&is_exist_page($req)) {
			$::form{mypage}=$req;
		} else {
			foreach my $pagetemp (@::PLUGIN_SLASHPAGE_STACK) {
				my $pagetemp2=$pagetemp;
				$pagetemp2=~s/.*\///g;
				if($pagetemp2 eq $req) {
					$::form{mypage}=$pagetemp;
					last;
				}
			}
		}
	}
	return('init'=>1,'func'=>'make_link_wikipage', 'make_link_wikipage'=>\&make_link_wikipage);
}
sub make_link_wikipage {
	my($chunk1,$escapedchunk)=@_;
	my($chunk,$anchor)=$chunk1=~/^([^#]+)#?(.*)/;
	my $cookedchunk  = &encode($chunk);
	my $cookedurl=&make_cookedurl($cookedchunk);
	if (&is_exist_page($chunk)) {
		if($anchor eq '') {
			return qq(<a title="$chunk" href="$cookedurl">$escapedchunk</a>);
		} else {
			return qq(<a title="$chunk" href="$cookedurl#$anchor">$escapedchunk</a>);
		}
	}
	foreach my $pagetemp (@::PLUGIN_SLASHPAGE_STACK) {
		my $pagetemp2=$pagetemp;
		$pagetemp2=~s/.*\///g;
		if($pagetemp2 eq $chunk) {
			$cookedchunk  = &encode($pagetemp);
			$cookedurl=&make_cookedurl($cookedchunk);
			if($anchor eq '') {
				return qq(<a title="$pagetemp" href="$cookedurl">$escapedchunk</a>);
			} else {
				return qq(<a title="$1" href="$cookedurl#$anchor">$escapedchunk</a>);
			}
		}
	}
	if (&is_editable($chunk)) {
		# 2005.10.27 pochi: 自動リンク機能を拡張		# comment
		if ($::editchar eq 'this') {
			return qq(<a title="$::resource{editthispage}" class="editlink" href="$::script?cmd=edit&amp;mypage=$cookedchunk">$escapedchunk</a>);
		} elsif ($::editchar) {
			# original
			return qq($escapedchunk<a title="$::resource{editthispage}" class="editlink" href="$::script?cmd=edit&amp;mypage=$cookedchunk">$::editchar</a>);
		}
	}
	return $escapedchunk;
}
1;
__DATA__
sub plugin_slashpage_setup {
	return(
		ja=>'階層下のページ名を容易にリンクする',
		en=>'Link of the page name under a class easily',
		override=>'make_link_wikipage',
		url=>'http://pyukiwiki.info/PyukiWiki/Plugin/ExPlugin/slashpage/'
	);
__END__
