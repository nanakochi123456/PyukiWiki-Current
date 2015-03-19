######################################################################
# wiki_http.cgi - This is PyukiWiki yet another Wiki clone
# $Id$
# Build 2015-03-19 08:19:06
#
# "PyukiWiki" ver 0.2.1-customoer-preview $$
# (C)2004-2007 Nekyo
# (C)2005-2015 PyukiWiki Developers Team
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pukiwiki.sfjp.jp/
# License GPL3 and/or Artistic or each later version
# CRLF EUC-JP 4Spaces GPL3 and/or Artistic License
######################################################################

=head1 NAME

wiki_http.cgi - This is PyukiWiki, yet another Wiki clone.

=head1 SEE ALSO

=over 4

=item PyukiWiki/Dev/Specification/wiki_http.cgi

L<http://pyukiwiki.info/PyukiWiki/Dev/Specification/wiki_http.cgi/>

=item PyukiWiki CVS

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel/lib/wiki_http.cgi?view=log>

L<http://sfjp.jp/cvs/view/pyukiwiki/PyukiWiki-Devel-UTF8/lib/wiki_http.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel/lib/wiki_http.cgi?view=log>

L<http://cvs.pyukiwiki.info/cgi-bin/cvsweb.cgi/PyukiWiki-Devel-UTF8/lib/wiki_http.cgi?view=log>

=back

=head1 AUTHOR

=over 4

=item Nekyo

obsoleted

=item Nanami

L<http://nanakochi.daiba.cx/> etc...

=item PyukiWiki Developers Team

L<http://pyukiwiki.info/>

=back

=head1 LICENSE

(C)2004-2007 by Nekyo.

(C)2005-2015 by PyukiWiki Developers Team

License is GNU GENERAL PUBLIC LICENSE 3 and/or Artistic 1 or each later version.

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut

=lang ja

=head2 content_output

=over 4

=item ������

&content_output(http_header, body of HTML);

=item ����

ɸ�����

=item �����С��饤��

��

=item ����

CGI����Τ��٤Ƥν��Ϥ򤹤롣

=back

=cut

sub _content_output {
	my ($http_header,$body)=@_;
	$http_header=~s/\n\n/\n/g;
	$http_header=~s/\r\n\r\n/\r\n/g;
	print "$http_header\n";

	&load_module("Nana::HTMLOpt");
	if($::is_xhtml) {
		$body=Nana::HTMLOpt::xhtml($body);
	} else {
		$body=Nana::HTMLOpt::html($body);
	}

	&compress_output($body . &exec_explugin_last);
}

=lang ja

=head2 compress_output

=over 4

=item ������

&compress_output(HTML or XML etc...);

=item ����

ɸ�����

=item �����С��饤��

��

=item ����

���̽��Ϥ�ͭ���ʻ��ϡ����̽��Ϥ򤹤롣

=back

=cut

sub _compress_output {
	my($data)=shift;
	if($::gzip_exec eq 1) {
		&load_module("Nana::HTTPCompress");
		Nana::HTTPCompress::output($data);
	} else {
		print $data;
	}
}

=lang ja

=head2 http_header

=over 4

=item ������

���Ϥ���http�إå��������

=item ����

http�إå�ʸ����

=item �����С��饤��

��

=item ����

http�إå��ν�����򤹤롣

=back

=cut

sub _http_header {
	my $http_header;
	my $nph_http_header;
	my $nph_http_header_first;

	foreach(@_) {
		$http_header.="$_\n";
	}
	$http_header=~s/\r//g;
	while($http_header=~/\n\n/) {
		$http_header=~s/\n\n/"\n"/ge;
	}
	$http_header=~s/\n$//g;
	$http_header.="\n";

	# nph������ץȤξ�硢�إå���ƹ��ۤ���			# comment

	if($ENV{SCRIPT_NAME}=~/nph\-/) {
		my $cachecontrol=1;
		$ENV{SERVER_PROTOCOL}="HTTP/1.1" if($ENV{SERVER_PROTOCOL} eq '');
		$nph_http_header_first="$ENV{SERVER_PROTOCOL} 200 OK";
		foreach(split(/\n/,$http_header)) {
			if(/^Status/) {
				s/Status:\s*//g;
				$nph_http_header_first="$ENV{SERVER_PROTOCOL} $_";
				if($_ eq 401) {
					$nph_http_header_first=~s/\n//g;
					$nph_http_header_first.=" Authorization Required\n";
				}
			} elsif(/^Last-Modified|^Cache|^Expire/) {
				$cachecontrol=0;
				$nph_http_header.="$_\n";
			} else {
				$nph_http_header.="$_\n";
			}
		}
		$http_header=$nph_http_header_first . "\n" . $nph_http_header;
		if($cachecontrol eq 1) {
#		#	$http_header.="Cache-Control: max-age=0\n";
			# changed 0.2.0-p4								# comment
			$http_header.=sprintf("Expires: %s\n", &http_date);
			$http_header.=sprintf("Date: %s\n", &http_date);
		}
		$http_header=~s/\n\n/\n/g;
	}

	# ���ԥ����ɤ� CRLF�ˤ���					# comment
	$http_header=~s/\x0D\x0A|\x0D|\x0A/\x0D\x0A/g;
	return "$http_header\x0D\x0A";
}
1;
