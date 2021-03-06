######################################################################
# server.inc.pl - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-06-18 11:04:56
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# Author Nanami http://nano.daiba.cx/
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.osdn.jp/
# CRLF UTF-8 TAB=4Spaces GPL3 and/or Artistic License
######################################################################
# 携帯に対応していたのですが、削除しました。
# ベンチマークは、サーバーを4秒間高負荷の状態にしますので注意
# Perl詳細情報は、可能な限りのperlモジュールを検索するので、場合に
# よっては、タイムアウトでInternal Server Errorになる可能性があります。
######################################################################
# 0.2.0-p2 :
# ベンチマークの所要時間を１／４にした
# ベンチマークを分割実行できるようにした
######################################################################

use Time::HiRes qw(gettimeofday tv_interval);

my @info_envs=(
	":server",
	"OSNAME:1",
	"SERVER_SOFTWARE:1",
	"SERVER_NAME:1",
	"SERVER_PORT:1",
	"SERVER_ADDR:0",
	"DOCUMENT_ROOT:0",
	"SERVER_PROTOCOL:0",
	"SERVER_ADMIN:1",
	"UPTIME:0",
	":userhome",
	"USERMODE:1",
	"FLOCK:1",
	"SYMLINK:1",
	"U_HOME:1",
	"U_NAME:1",
	"U_GROUP:1",
	"W_NAME:1",
	"W_GROUP:1",
	":pathinfo",
	"PATH_PERL:1",
	"PATH_SENDMAIL:1",
	"PATH_GZIP:1",
	"PATH_ZIP:1",
	"PATH_LHA:1",
	"PATH_RUBY:1",
	"PATH_PHP:1",
	"PATH_PYTHON:1",
	"PATH_SH:1",
	"PATH_GCC:1",
	"PATH_NKF:1",
	"PATH_BASE64:1",
	"PATH_UU:1",
	"PATH_LYNX:1",
	"PATH_W3M:1",
	":client",
	"REMOTE_ADDR:1",
	"REMOTE_HOST:1",
	"REMOTE_PORT:1",
	"HTTP_USER_AGENT:1",
	"HTTP_USER_AGENT_BROWSERNAME:1",
	"HTTP_USER_AGENT_BROWSERVERSION:1",
	"HTTP_USER_AGENT_UAOS:1",
	"HTTP_ACCEPT_LANGUAGE:0",
	"HTTP_ACCEPT_ENCODING:0",
	":request",
	"HTTP_HOST:1",
	"REQUEST_METHOD:1",
	"REQUEST_URI:1",
	"SCRIPT_NAME:1",
	"SCRIPT_FILENAME:0",
	"QUERY_STRING:1",
	"HTTP_COOKIE:1"
);

my @bench_envs=(
	"MATHCOUNT:1",
	"PROCCOUNT:1",
	"FILECOUNT:1",
	"REGCOUNT:1"
);

my @bench1_envs=(
	"MATHCOUNT:1",
);

my @bench2_envs=(
	"PROCCOUNT:1",
);

my @bench3_envs=(
	"FILECOUNT:1",
);

my @bench4_envs=(
	"REGCOUNT:1"
);

my @perl_envs=(
	":perl",
	"PERLPATH:1",
	"PERLVER:1",
	"64BITPERL:1",
	":perlmodule"
);

my @linux_info=(
	":cpuinfo",
	"cpuinfo:/proc/cpuinfo",
	":meminfo",
	"meminfo:/proc/meminfo",
	":loadavg",
	"loadavg:/proc/loadavg",
);

my @freebsd_info=(
	":dmesginfo",
	"dmesginfo:/var/run/dmesg.boot",
);

my @envs;

sub plugin_server_bench_gcd{
	local($a,$b)=@_;
	local($c);
	$c=($a%$b);
	return $b if($c eq 0);
	return &plugin_server_bench_gcd($b,$c);
}

sub plugin_server_bench_euler{
	local($x)=@_;
	local($p,$r,$n);

	$p = 2;
	$n = x;
	$r = x;
	while ($n > 1) {
		if ($n % $p eq 0) {
			$r /= $p;
			$r *= ($p - 1);
			while($n % $p eq 0) {
				$n /= $p;
			}
		}
		$p++;
	}
	return $r;
}

sub plugin_server_bench_powermod_exec {
	local($x,$e,$n)=@_;
	if(($e % 2) eq 0) {
		return &plugin_server_bench_powermod_exec($x * $x % $n, $e / 2, $n);
	} else {
		return $x if($e eq 1);
		return $x * &plugin_server_bench_powermod_exec($x, $e - 1, $n) % $n;
	}
}

sub plugin_server_bench_powermod {
	local($x,$e,$n)=@_;
	return -1 if($e < 1);
	return -2 if($n < 1);
	return(&plugin_server_bench_powermod_exec($x % $n, $e, $n)) if($x >= $n);
	return(&plugin_server_bench_powermod_exec($x, $e, $n));
}

sub plugin_server_bench {
	my($mode)=@_;
	if($mode eq 0 || $mode eq 1) {
	#	$BENCH=(times)[0];
		$BENCH1=[gettimeofday];
		$BENCH2=[gettimeofday];
		$mathcount=0;
	#	while((times)[0]<$BENCH+1) {
		while(sprintf("%.8f",tv_interval $BENCH1, $BENCH2)+0<=0.25) {
			$p=5557;
			$q=5563;
			$e=395131;
			for($i=2;$i<$p;$i++) { $pp=$p%$i; }
			for($i=2;$i<$q;$i++) { $qq=$q%$i; }
			$n=$p*$q; $nn=($p-1)*($q-1);
			&plugin_server_bench_gcd($nn,$e);
			$a=&plugin_server_bench_euler($nn);
			&plugin_server_bench_powermod($e,$a-1,$nn);
			$mathcount++;
			$BENCH2=[gettimeofday];
		}
	}
	if($mode eq 0 || $mode eq 4) {
	#	$BENCH=(times)[0];
		$regcount=0;
		open(R,"$::skin_file");
		foreach(<R>) { $DATA.=$r; } close(R);
		$BENCH1=[gettimeofday];
		$BENCH2=[gettimeofday];
	#	while((times)[0]<$BENCH+1) {
		while(sprintf("%.8f",tv_interval $BENCH1, $BENCH2)+0<=0.25) {
			$test=$DATA;
			for($i=0;$i<1000;$i++) {
				$test=~s/\#/\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#/g;
			}
			$test=~s/\#.*//g;
			$regcount++;
			$BENCH2=[gettimeofday];
		}
	}
	if($mode eq 0 || $mode eq 3) {
	#	$BENCH=(times)[0];
		$BENCH1=[gettimeofday];
		$BENCH2=[gettimeofday];
		$filecount=0;
	#	while((times)[0]<$BENCH+1) {
		while(sprintf("%.8f",tv_interval $BENCH1, $BENCH2)+0<=0.25) {
			open(R,"$::skin_file");
			foreach(<R>) { $DATA=$r; } close(R);
			$filecount++;
			$BENCH2=[gettimeofday];
		}
	}
	if($mode eq 0 || $mode eq 2) {
	#	$BENCH=(times)[0];
		$BENCH1=[gettimeofday];
		$BENCH2=[gettimeofday];
		$proccount=0;
	#	while((times)[0]<$BENCH+1) {
		while(sprintf("%.8f",tv_interval $BENCH1, $BENCH2)+0<=0.25) {
			open(PROC,"$0");
			foreach(<PROC>) {
				$r=$_;
			}
			close(PROC);
			$proccount++;
			$BENCH2=[gettimeofday];
		}
	}
	$ENV{MATHCOUNT}=$mathcount*4;
	$ENV{PROCCOUNT}=$proccount*4;
	$ENV{FILECOUNT}=$filecount*4;
	$ENV{REGCOUNT}=$regcount*4;
}

sub uptime {
	my $path;
	foreach(split(/:/,$ENV{PATH})) {
		if(-x "$_/uptime") {
			$path="$_/uptime";
			last;
		}
	}
	my $uptime;
	if(open(PIPE,"$path |")) {
		foreach(<PIPE>) {
			$uptime.=$_;
		}
		close(PIPE);
	}
	$uptime=~s/[\r|\n]//g;
	return $uptime;
}

sub uname {
	my $path;
	foreach(split(/:/,$ENV{PATH})) {
		if(-x "$_/uname") {
			$path="$_/uname";
			last;
		}
	}
	my $uname;
	if(open(PIPE,"$path -s |")) {
		foreach(<PIPE>) {
			$uname.=$_;
		}
		close(PIPE);
		if(open(PIPE,"$path -r |")) {
			$uname .=" ";
			foreach(<PIPE>) {
				$uname.=$_;
			}
			close(PIPE);
			if(open(PIPE,"$path -m |")) {
				$uname .="(";
				foreach(<PIPE>) {
					$uname.=$_;
				}
				close(PIPE);
				$uname .= ")";
			}
		}
	} elsif(open(PIPE, "$path -a |")) {
		foreach(<PIPE>) {
			$uname.=$_;
		}
		close(PIPE);
	}
	$uname=~s/[\r|\n]//g;
	return $uname;
}

sub plugin_server_checkusermode {
	my($testfile,$testdata);

	if((stat("."))[4] eq $< && $< eq $>) {
		$testfile="./test.tmp";
		$testdata="";
		open(TEST,">$testfile");
		print TEST "test";
		close(TEST);
		open(TEST,"$testfile");
		$testdata=<TEST>;
		close(TEST);
		unlink($testfile);
		if($testdata=~/test/) {
			return 1;
		}
	}
	return 0;
}

sub plugin_server_flock {
	my $lockfile = './lock.tmp';
	open(LOCK, "> $lockfile");
	my $flock = eval { flock(LOCK, 2); 1; };
	close(LOCK);
	unlink($lockfile) if (-e $lockfile);
	if ($@) { $flock = 2; }
	return $flock;
}

sub plugin_server_symlink {
	my $symlink = ''; $@='';
	$symlink = eval { symlink("",""); 1; };
	if ($@) { $symlink = 2; }
	return $symlink;
}

sub plugin_server_setenv {
	my($envname, $flag)=@_;
	if($flag) {
		$ENV{$envname}=$::resource{server_plugin_yes};
	} else {
		$ENV{$envname}=$::resource{server_plugin_no};
	}
}

sub plugin_server_64bitperlchk {
	if(sprintf("%d",4294967295+1) eq '4294967296') {
		return 1;
	}
	return 0;
}

sub plugin_server_getperlpath{
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
	return $::resource{server_plugin_unknown};
}

sub plugin_server_pathchk() {
	my $r;
	foreach(@_) {
		my ($exec,$count)=split(/:/,$_);
		foreach my $d(split(/:/,"$ENV{PATH}:/var/qmail/bin")) {
			opendir(DIR,$d);
			@DIR=readdir(DIR);
			close(DIR);
			foreach $f(@DIR) {
				if($f=~/^$exec$/) {
					$r.="$d/$f~\n" if(-x "$d/$f" && $d ne '');
				}
			}
		}
	}
	$r=~s/\~\n$//g;
	return $r;
}

sub getagent {
	require "$::explugin_dir/AWS/browsers.pm";
	require "$::explugin_dir/AWS/domains.pm";
	require "$::explugin_dir/AWS/operating_systems.pm";
	require "$::explugin_dir/AWS/robots.pm";
	require "$::explugin_dir/AWS/search_engines.pm";
	push(@RobotsSearchIDOrder, @RobotsSearchIDOrder_list1);
	push(@RobotsSearchIDOrder, @RobotsSearchIDOrder_list2);
	push(@RobotsSearchIDOrder, @RobotsSearchIDOrder_listgen);

	my $uabrowser;
	my $uabrowserver;
	my($checkbrowser, $checkver)=split(/\//,lc $checkname);
	my $browser=lc $ENV{HTTP_USER_AGENT};

	# ブラウザー判定
	foreach my $id(@BrowsersFamily) {
		if($browser=~/$BrowsersVersionHashIDLib{$id}/) {
			my $version=$2 eq '' ? $1 : $2;
			if($id eq "safari") {
				$version=$BrowsersSafariBuildToVersionHash{$version};
			}
			$uaid=$id;
			$uabrowser=$BrowsersHashIDLib{$id};
			$uabrowserver=$version;
			$ENV{HTTP_USER_AGENT_BROWSERNAME}=$uabrowser;
			$ENV{HTTP_USER_AGENT_BROWSERVERSION}=$uabrowserver;
			last;
		}
	}

	# OS判定
	foreach my $regex(@OSSearchIDOrder) {
		if($browser=~/$regex/) {
			$uaos=&plugin_server_htmlcut($OSHashLib{$OSHashID{$regex}});
			$ENV{HTTP_USER_AGENT_UAOS}=$uaos;
			last;
		}
	}

	# ロボット判定
	foreach(@RobotsSearchIDOrder) {
		if($browser =~ /$_/) {
			$uabrowser='robot';
			$uabrowserver=&plugin_server_htmlcut($RobotsHashIDLib{$_});
			$ENV{HTTP_USER_AGENT_BROWSERNAME}=$uabrowser;
			$ENV{HTTP_USER_AGENT_BROWSERVERSION}=$uabrowserver;
			last;
		}
	}
}

sub plugin_server_htmlcut {
	my($text)=shift;
	$text=~s/<([^<>]+)>//g;
	return $text;
}

sub plugin_server_infomation {
	&getagent;

	$ENV{UPTIME}=&uptime;
	$ENV{OSNAME}=&uname;
	if($ENV{OSNAME} eq '') {
		if($ENV{OS} ne '') {
			$ENV{OSNAME}=$ENV{OS};	# for Windows NT		# comment
		} else {
			$ENV{OSNAME}=$::resource{server_plugin_unknown};
		}
	}
	&plugin_server_setenv("USERMODE",&plugin_server_checkusermode eq 1);
	&plugin_server_setenv("FLOCK",&plugin_server_flock eq 1);
	&plugin_server_setenv("SYMLINK",&plugin_server_symlink eq 1);
	$ENV{U_NAME}=eval { (getpwuid((stat("."))[4]))[0]; };
	$ENV{U_HOME}=eval { (getpwuid((stat("."))[4]))[7]; };
	$ENV{U_GROUP}=eval { (getgrgid((getpwuid((stat("."))[4]))[3]))[0]; };
	$ENV{W_NAME}=eval { (getpwuid($<))[0]; };
	$ENV{W_GROUP}=eval { (getgrgid((getpwuid($<))[3]))[0]; };
	$ENV{PATH_PERL}=&plugin_server_pathchk("perl","perl[0-9].*");
	$ENV{PATH_SENDMAIL}=&plugin_server_pathchk("sendmail");
	$ENV{PATH_GZIP}=&plugin_server_pathchk("gzip");
	$ENV{PATH_ZIP}=&plugin_server_pathchk("zip","unzip");
	$ENV{PATH_LHA}=&plugin_server_pathchk("lha");
	$ENV{PATH_RUBY}=&plugin_server_pathchk("ruby","ruby[0-9].*");
	$ENV{PATH_PHP}=&plugin_server_pathchk("php","php[0-9].*");
	$ENV{PATH_PYTHON}=&plugin_server_pathchk("python","python[0-9].*");
	$ENV{PATH_SH}=&plugin_server_pathchk("sh","csh","bash","zsh");
	$ENV{PATH_NKF}=&plugin_server_pathchk("nkf");
	$ENV{PATH_GCC}=&plugin_server_pathchk("gcc","gcc[0-9].*");
	$ENV{PATH_BASE64}=&plugin_server_pathchk("base64");
	$ENV{PATH_UU}=&plugin_server_pathchk("uuencode","uudecode");
	$ENV{PATH_LYNX}=&plugin_server_pathchk("lynx");
	$ENV{PATH_W3M}=&plugin_server_pathchk("w3m");
}


sub plugin_server_perl_getmodule_sub {
	my(%all, %inc);
	foreach (@INC) {
		$inc{$_} ++;
	}
	foreach my $k(@INC) {
		next if($k eq '.');
		foreach my $k2 (@INC) {
			next if($k2 eq '.');
			if($k =~ /^${k2}.+/) {
				delete $inc{$k};
				last;
			}
		}
	}
	for my $p (keys %inc) {
		my %find = &plugin_server_perl_getmodule_sub2($p,0);
		for my $mod (keys %find) {
			$all{$mod} .= "$find{$mod}\t";
		}
	}
	return %all;
}

sub plugin_server_perl_getmodule_sub2 {
	my($p,$z) = @_;
	my(%mods);
	opendir(DIR, $p);
	my @f = readdir(DIR);
	closedir(DIR);
	for my $f (@f) {
		next if($f =~ /^\./);
		if(-d "$p/$f") {
			if($z<1) {
				my %sub_mods = &plugin_server_perl_getmodule_sub2("$p/$f",$z+1);
				for my $key (keys %sub_mods) {
					$mods{$key} .= "$sub_mods{$key}\t";
				}
			}
		} else {
			if($f =~ /\.pm$/) {
				if(open(R, "$p/$f")) {
					while(<R>) {
						if (/^\s*package\s+(\S+)\s*;/){
							my $name = $1;
							$mods{$name} .= "$p/$f\t";
							unless($f eq 'DB_File.pm') {
								last;
							}
						}
					}
					close(R);
				}
			}
		}
	}
	return %mods;
}

sub plugin_server_perl_getmodule_sub3 {
	my($mod) = @_;
	my $ver;
	#chdir("lib");									# comment
	if($^O =~ /MSWin32/i) {
		$ver = `/usr/bin/perl -m$mod -e "print \$${module}::VERSION"`;
	} else {
#		$ver = `$^X -m$mod -e 'print \$${mod}::VERSION' 2>/dev/null`;
		$ver = `$^X -m$mod -e 'print "\$mod::VERSION";' 2>/dev/null`;
	}
	if($ver !~ /[0-9]/) {
		$ver = '';
	}
	return $ver;
}

sub plugin_server_perl_getmodule {
	my %all=&plugin_server_perl_getmodule_sub;
	my $r;
	my $v;
	my $t;
	foreach(keys %all) {
		push(@mods,$_);
	}
	@mods=sort @mods;
	$r="<table><tr>";
	foreach $m(@mods) {
		$v=&plugin_server_perl_getmodule_sub3($m);
		if($v ne '') {
			$m="$m-$v";
		}
		$r.="<td>$m</td>";
		if($t++>=3) {
			$t=0;
			$r.="</tr><tr>";
		}
	}
	$r=~s/<\/tr><tr>$//g;
	$r.="</tr></table>";
	return $r;
}

sub plugin_server_perl {
	$ENV{PERLPATH}=&plugin_server_getperlpath;
	$ENV{PERLVER}=$];
	&plugin_server_setenv("64BITPERL",&plugin_server_64bitperlchk eq 1);
	return  &plugin_server_perl_getmodule;
}

sub plugin_server_info {
	my ($form)=@_;
	my $buf;
	my $body;

	foreach (@envs) {
		my($name,$flag)=split(/:/,$_);
		if($name eq '') {
			$body.=qq(** $flag $::resource{"server_plugin_" . $flag . "_title"} \n);
		} else {
			$buf=" $name:$flag\n";
			if(open(R,$flag)) {
				foreach(<R>) {
					chomp;
					$buf.=" $_\n";
				}
				close(R);
				$body.=$buf;
			} else {
				$body=qq(''Can't open $flag'');
			}
		}
	}
	$body= $form .  &text_to_html($body);
	return($::resource{server_plugin_server_title},$body);
}

sub linuxbutton {
	my $path;
	foreach(split(/:/,$ENV{PATH})) {
		if(-x "$_/uname") {
			$path="$_/uname";
			last;
		}
	}
	my $osname;
	if(open(PIPE,"$path |")) {
		foreach(<PIPE>) {
			$osname.=$_;
		}
		close(PIPE);
	}
	$osname=~s/[\s|\r|\n]//g;
	my $button;
	if($osname=~/[Ll][Ii][Nn][Uu][Xx]/) {
		$button=<<EOM;
<input type="submit" name="linux" value="$::resource{server_plugin_linux_button}" />
EOM
	}
	return $button;
}

sub freebsdbutton {
	my $path;
	foreach(split(/:/,$ENV{PATH})) {
		if(-x "$_/uname") {
			$path="$_/uname";
			last;
		}
	}
	my $osname;
	if(open(PIPE,"$path |")) {
		foreach(<PIPE>) {
			$osname.=$_;
		}
		close(PIPE);
	}
	$osname=~s/[\s|\r|\n]//g;
	my $button;
	if($osname=~/[Ff][Rr][Ee][Ee][Bb][Ss][Dd]/) {
		$button=<<EOM;
<input type="submit" name="freebsd" value="$::resource{server_plugin_freebsd_button}" />
EOM
	}
	return $button;
}

sub makeform {
	my($mode,$authed)=@_;

	$form=<<EOM;
<h2>$::resource{"server_plugin_" . $mode . "_button"}</h2>
<form action="$::script" method="POST">
<input type="hidden" name="cmd" value="$::form{cmd}" />
$authed
<table><tr>
<td>
<input type="submit" name="infomation" value="$::resource{server_plugin_infomation_button}" />
</td><td>
<input type="submit" name="perlinfo" value="$::resource{server_plugin_perlinfo_button}" />
</td><td>
<input type="submit" name="benchmark" value="$::resource{server_plugin_benchmark_button}" />
<input type="submit" name="benchmark1" value="$::resource{server_plugin_benchmark1_button}" />
<input type="submit" name="benchmark2" value="$::resource{server_plugin_benchmark2_button}" />
<input type="submit" name="benchmark3" value="$::resource{server_plugin_benchmark3_button}" />
<input type="submit" name="benchmark4" value="$::resource{server_plugin_benchmark4_button}" />
@{[&linuxbutton]}
@{[&freebsdbutton]}
</td></tr></table></form>
EOM

	return $form;
}

sub plugin_server_action {
	my $body;
	my $envname;
	my $flag;
	my $form;
	my $mode;
	my $html;
	&load_wiki_module("auth");
	my %auth=&authadminpassword(submit,"","admin");
	return('msg'=>"\t$::resource{server_plugin_title}",'body'=>$auth{html})
		if($auth{authed} eq 0);
	$::allview=0;
	if($ENV{PATH}=~/:/) {
		my %path;
		foreach(split(/:/,$ENV{PATH})) {
			$path{$_}=1;
		}
		$path{"/bin"}=1;
		$path{"/usr/bin"}=1;
		$path{"/usr/local/bin"}=1;
		$path{"/opt"}=1;
		$path{"/opt/bin"}=1;
		$path{"/usr/opt/bin"}=1;
		$path{"/opt/usr/bin"}=1;
		$ENV{PATH}="";
		foreach(keys %path) {
			$ENV{PATH}.="$_:";
		}
		$ENV{PATH}.=".";
	}

	if($::form{perlinfo} ne '') {
		$mode="perlinfo";
		$html=&plugin_server_perl;
		@envs=@perl_envs;
	} elsif($::form{benchmark} ne '') {
		$mode="benchmark";
		&plugin_server_bench(0);
		@envs=@bench_envs;
	} elsif($::form{benchmark1} ne '') {
		$mode="benchmark";
		&plugin_server_bench(1);
		@envs=@bench1_envs;
	} elsif($::form{benchmark2} ne '') {
		$mode="benchmark";
		&plugin_server_bench(2);
		@envs=@bench2_envs;
	} elsif($::form{benchmark3} ne '') {
		$mode="benchmark";
		&plugin_server_bench(3);
		@envs=@bench3_envs;
	} elsif($::form{benchmark4} ne '') {
		$mode="benchmark";
		&plugin_server_bench(4);
		@envs=@bench4_envs;
	} elsif($::form{linux} ne '') {
		$mode="linux";
		@envs=@linux_info;
		my($m,$b)=&plugin_server_info(&makeform($mode,$auth{html}));
		return('msg'=>"\t$m",'body'=>$b);
	} elsif($::form{freebsd} ne '') {
		$mode="freebsd";
		@envs=@freebsd_info;
		my($m,$b)=&plugin_server_info(&makeform($mode,$auth{html}));
		return('msg'=>"\t$m",'body'=>$b);
	} else {
		$mode="infomation";
		@envs=@info_envs;
		&getremotehost;
		&plugin_server_infomation
	}
	$form=&makeform($mode,$auth{html});

	foreach (@envs) {
		my($name,$flag)=split(/:/,$_);
		if($name eq '') {
			$body.=qq(**$::resource{"server_plugin_" . $flag . "_title"}\n);
		} else {
			unless($flag eq 0 && $ENV{$name} eq '') {
				$body.=qq(:$::resource{"server_plugin_" .$name}:$ENV{$name} \n);
			}
		}
	}
	$body=$form . &text_to_html($body) . $html;
	return('msg'=>"\t$::resource{server_plugin_server_title}",'body'=>$body);
}

sub disp {
	my ($s) = @_;

	return ($s ? $s : "-");
}

# 以前のバージョンのを改悪 (携帯関連の取り除き）				# comment

sub plugin_server_convert {
	return &plugin_inline;
}

sub plugin_server_inline {
	my $useragent = $::ENV{'HTTP_USER_AGENT'};
	my $body =<<"EOD";
<dl>
<dt>Server Name</dt>
<dd>$ENV{SERVER_NAME}&nbsp;</dd>
<dt>Server Software</dt>
<dd>$ENV{SERVER_SOFTWARE}&nbsp;</dd>
<dt>Server Admin</dt>
<dd>$ENV{SERVER_ADMIN}&nbsp;</dd>
<dt>User Agent</dt>
<dd>$ENV{HTTP_USER_AGENT}&nbsp;</dd>
EOD
	return $body;
}

1;
__END__

=head1 NAME

server.inc.pl - PyukiWiki Administrator's Plugin

=head1 SYNOPSIS

 ?cmd=server
 #server

=head1 DESCRIPTION

Display server infomation

If using this plugin, authentication of frozen password.

In addition to the display of a fundamental environment variable, the module information on Perl and a benchmark are acquirable.

When collecting the module information on Perl, it takes time very much.
Therefore, for some servers of use, there may be no response at Server Error.

Since a server is made into high load for about 4 seconds, please do not abuse a benchmark.

When it uses it as a block type plugin, the frozen password becomes a display only of minimam information though it is unnecessary.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Plugin/Admin/server

L<http://pyukiwiki.info/PyukiWiki/Plugin/Admin/server/>

=item PyukiWiki CVS

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/plugin/server.inc.pl?view=log>

L<http://osdn.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/plugin/server.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/plugin/server.inc.pl?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/plugin/server.inc.pl?view=log>

=back

=head1 AUTHOR

=over 4

=item Nanami

L<http://nano.daiba.cx/> etc...

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
