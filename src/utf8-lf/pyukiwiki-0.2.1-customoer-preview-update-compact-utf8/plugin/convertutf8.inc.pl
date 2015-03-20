######################################################################
# convertutf8.inc.pl - $Id$
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami
# (C)2005-2015 PyukiWiki Developers Team/2004-2007 Nekyo
# http://pyukiwiki.info/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
sub plugin_convertutf8_action {
	my @convertdirs=(
		"$::upload_dir",
		"$::backup_dir",
		"$::diff_dir",
		"$::counter_dir",
		"$::info_dir",
		"$::data_dir",
		"$::user_dir",
	);
	my @convertfiles=(
		"$::backup_dir",
		"$::diff_dir",
		"$::data_dir",
		"$::user_dir",
	);
	%::auth=&authadminpassword(submit);
	return('msg'=>"\t$::resource{convertutf8_plugin_title}",'body'=>$auth{html})
		if($auth{authed} eq 0);
	if($::defaultcode eq 'utf8') {
		return('msg'=>"\t$::resource{convertutf8_plugin_title}"
			  ,'body'=>"$::resource{convertutf8_pluin_noutf8}");
	}
	if($::lang ne 'ja') {
		return('msg'=>"\t$::resource{convertutf8_plugin_title}"
			  ,'body'=>"$::resource{convertutf8_pluin_nojapanese}");
	}
	if($::utf8convertexeced eq 1) {
		return('msg'=>"\t$::resource{convertutf8_plugin_title}"
			  ,'body'=>"$::resource{convertutf8_pluin_converted_always}");
	}
	if($::form{confirm} eq '') {
		$body=<<EOM;
<form action="$::script" method="POST">
$auth{html}
<input type="hidden" name="cmd" value="convertutf8" />
$::resource{convertutf8_pluin_convert}<br />
<input type="submit" name="confirm" value="$::resource{convertutf8_pluin_convert_yes}" />
</form>
EOM
		return('msg'=>"\t$::resource{convertutf8_plugin_title}"
			  ,'body'=>"$body");
	}
	# convert filname
	foreach(@convertdirs) {
		next if($_ eq '');
		opendir(DIR,$_);
		while($file=readdir(DIR)) {
			next if($file eq '.' || $file eq '..');
			next if($file=~/\.html$/ || $file=~/^\.ht/ || $file=~/\.pl$/ || $file=~/\.cgi$/);
			$ext="";
			if($file=~/\.txt$/) {
				$ext=".txt";
				$file=~s/\.txt$//;
			} elsif($file=~/$::counter_ext$/) {
				$ext="$::counter_ext";
				$file=~s/$::counter_ext$//;
			} elsif($file=~/\.gz$/) {
				$ext=".gz";
				$file=~s/\.gz$//;
			}
			if($file=~/^(.+)?\_(.+)?/) {
				$dbm1=&undbmname($1);
				$dbm2=&undbmname($2);
				$dbm1=&code_convert(\$dbm1, "utf8");
				$dbm1=&dbmname($dbm1);
				$dbm2=&code_convert(\$dbm2, "utf8");
				$dbm2=&dbmname($dbm2);
				$old="$_/$file$ext";
				$new="$_/$dbm1\_$dbm2$ext";
			} else {
				$dbm=&undbmname($file);
				$dbm=&code_convert(\$dbm, "utf8");
				$dbm=&dbmname($dbm);
				$old="$_/$file$ext";
				$new="$_/$dbm$ext";
			}
			$body.="rename<br />$old<br />$new<br /><br />";
			rename($old,$new);
		}
	}
	# convert data
	foreach(@convertfiles) {
		next if($_ eq '');
		opendir(DIR,$_);
		while($file=readdir(DIR)) {
			next if($file eq '.' || $file eq '..');
			next if($file=~/\.html$/ || $file=~/^\.ht/ || $file=~/\.pl$/ || $file=~/\.cgi$/);
			if($file=~/\.txt$/) {
				$ext=".txt";
				$file=~s/\.txt$//;
			} elsif($file=~/\.gz$/) {
				$ext=".gz";
				$file=~s/\.gz$//;
			}
			$buf="";
			open(R,"$_/$file$ext");
			foreach $data(<R>) {
				$buf.=$data;
			}
			close(R);
			$buf=&code_convert(\$buf, "utf8");
			open(W,">$_/$file$ext");
			print W $buf;
			close(W);
			$body.="convert<br />$_/$file$ext<br /><br />";
		}
	}
	if(-w $::setup_file) {
		$buf="";
		open(R,"$::setup_file");
		foreach $data(<R>) {
			$buf.=$data;
		}
		close(R);
		$buf=&code_convert(\$buf, "utf8");
		open(W,">$::setup_file");
		print W $buf;
		close(W);
		open(W, ">>$::setup_file");
		print W <<EOM;
\$::kanjicode = "utf8";			# converted utf8
\$::charset = "utf-8";			# converted utf8
\$::utf8convertexeced=1;		# converted utf8
1;
EOM
	}
	$::allview=0;
	return('msg'=>"\t$::resource{convertutf8_plugin_title}"
		  ,'body'=>"$::resource{convertutf8_pluin_converted}<hr />$body");
}
1;
__END__
