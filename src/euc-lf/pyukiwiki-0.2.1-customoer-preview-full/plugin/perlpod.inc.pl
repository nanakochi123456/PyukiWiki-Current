######################################################################
# perlpod.inc.pl - This is PyukiWiki yet another Wiki clone
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
use Nana::Pod2Wiki;
use strict;
require "$::plugin_dir/contents.inc.pl";
sub plugin_perlpod_action {
	my $file;
	if($ENV{HTTP_USER_AGENT} ne '' || $ENV{HTTP_HOST} ne ''
	|| $ENV{REMOTE_ADDR} ne '') {
		$file=$::form{file};
		return if($file=~/\.\./ || $file=~/^\// || $file=~/[|><%'"]/);
		return('msg'=>"\t$::$file"
			,'body'=>&perlpod($file
							, $::form{notitle} ne '' ? "notitle" : ""
							, $::form{source} ne '' ? 1 : 0));
	}
	$::nowikiname = 1;
	&load_wiki_module(
		"init", "func", "db", "http", "html",
		"link", "sub", "plugin", "wiki");
	my $file=$ARGV[0];
	my ($name,$body)=Nana::Pod2Wiki::pod2wiki($file,0);
	print "*$name\n\#contents\n----\n$body";
	exit;
}
sub plugin_perlpod_convert {
	my $file;
	my($file,$notitle,$source)=split(/,/,shift);
	$source+=0;
	return if($file=~/\.\./ || $file=~/^\// || $file=~/[|><%'"]/);
	return(&perlpod($file,$notitle ne '' ? "notitle" : "",$source));
}
sub getperlpath{
	my $perlpath;
	if(open(R,"$0")) {
		$perlpath=<R>;
		close(R);
		$perlpath=~s/#!//g;
		$perlpath=~s/-//g;
		$perlpath=~s/ //g;
		$perlpath=~s/[\r\n]//g;
		return $perlpath;
	}
	return '';
}
sub perlpod {
	my($file,$notitle,$source)=@_;
	$file=~s/.*\///g;
	my $dir;
	$::interwiki_definition="";
	$::interwiki_definition2="";
	foreach my $dirs($::data_home, $::data_pub, $::explugin_dir, $::plugin_dir
			, $::res_dir, $::skin_dir, $::image_dir) {
		if(-r "$dir/$file") {
			my $html;
			return &perlpod_sub("$dir/$file",$notitle,$source);
		}
	}
	foreach my $dirs($::explugin_dir, $::plugin_dir, $::res_dir, $::skin_dir, $::data_home, $::data_pub) {
		my $ret=&perlpod_sub2($dirs,$file);
		if($ret ne '') {
			return &perlpod_sub($ret,$notitle,$source);
		}
	}
	return("File nod found:$file");
}
my $level=0;
sub perlpod_sub {
	my($file,$notitle,$source)=@_;
	my ($name,$body)=Nana::Pod2Wiki::pod2wiki($file,$notitle);
	my $html;
	my $query=&htmlspecialchars($ENV{QUERY_STRING});
	if($source+0 eq 0) {
		if($notitle eq '') {
			$html=&text_to_html("*$name\n\pod2wikidummycontents\n----\n$body");
			my $contents=&plugin_contents_main("?$query",,split(/\n/,"*$name\n\pod2wikidummycontents\n----\n$body"));
			$html=~s!pod2wikidummycontents!$contents!g;
		} else {
			$html.=&plugin_contents_main("?$query",,split(/\n/,"$body"));
			$html.=&text_to_html("----\n$body");
		}
	} else {
		if($notitle eq '') {
			$html="*$name\n\#contents\n----\n$body";
		} else {
			$html="#contents\n";
			$html.="----\n$body";
		}
		$html=<<EOM;
<form>
<textarea cols="$::cols" rows="$::rows" name="mymsg">$html</textarea>
</form>
EOM
	}
	$html=~s/\x5/\#/g;
	$html=~s/\x6/\&/g;
	$html=~s/\x4/\:/g;
	return $html;
}
sub perlpod_sub2 {
	my($dir,$file)=@_;
	opendir(DIR,$dir);
	my @files=readdir(DIR);
	closedir(DIR);
	foreach(@files) {
		next if($_ eq '.' || $_ eq '..');
		my $path="$dir/$_";
		return $path if($_ eq $file);
		if(-d $path) {
			$level++;
			return '' if($level > 10);
			my $ret=&perlpod_sub2($path,$file);
			return $ret if($ret ne '');
			$level--;
		}
	}
	return "";
}
1;
__END__
