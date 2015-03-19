######################################################################
# Diff.pm - This is PyukiWiki, yet another Wiki clone.
# from YukiWiki
#
# $Id$
#
# "Algorithm::Diff" version 1.1901 $$
# Ned Konz, <perl (at) bike-nomad (dot) com>
# Mark-Jason Dominus, <mjd-perl-diff (at) plover (dot) com>
#
# Copyright (C) 2004-2015 by Nekyo.
# Copyright (C) 2006-2015 PyukiWiki Developers Team
# License: GPL v2 or (at your option) any later version
# http://nekyo.qp.land.to/
# http://pyukiwiki.info/
# Based on YukiWiki http://www.hyuki.com/yukiwiki/
# Powerd by PukiWiki http://pyukiwiki.info/
#
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
# Return Code:UNIX=LF/Windows=CR+LF/Mac=CR
# 1TAB=4Spaces English Code=Ascii
######################################################################
package Algorithm::Diff;
use strict;
use vars qw($VERSION @EXPORT_OK @ISA @EXPORT);
use integer;		# see below in _replaceNextLargerWith() for mod to make
					# if you don't use this
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw();
@EXPORT_OK = qw(LCS diff traverse_sequences);
$VERSION = sprintf('%d.%02d', (q$Revision: 1.53 $ =~ /\d+/g));
# McIlroy-Hunt diff algorithm
# Adapted from the Smalltalk code of Mario I. Wolczko, <mario (at) wolczko (dot) com>
# by Ned Konz, perl (at) bike-nomad (dot) com
# Create a hash that maps each element of $aCollection to the set of positions
# it occupies in $aCollection, restricted to the elements within the range of
# indexes specified by $start and $end.
# The fourth parameter is a subroutine reference that will be called to
# generate a string to use as a key.
# Additional parameters, if any, will be passed to this subroutine.
#
# my $hashRef = _withPositionsOfInInterval( \@array, $start, $end, $keyGen );
sub _withPositionsOfInInterval
{
	my $aCollection = shift;	# array ref
	my $start = shift;
	my $end = shift;
	my $keyGen = shift;
	my %d;
	my $index;
	for ( $index = $start; $index <= $end; $index++ )
	{
		my $element = $aCollection->[ $index ];
		my $key = &$keyGen( $element, @_ );
		if ( exists( $d{ $key } ) )
		{
			push( @{ $d{ $key } }, $index );
		}
		else
		{
			$d{ $key } = [ $index ];
		}
	}
	return wantarray ? %d: \%d;
}
# Find the place at which aValue would normally be inserted into the array. If
# that place is already occupied by aValue, do nothing, and return undef. If
# the place does not exist (i.e., it is off the end of the array), add it to
# the end, otherwise replace the element at that point with aValue.
# It is assumed that the array's values are numeric.
# This is where the bulk (75%) of the time is spent in this module, so try to
# make it fast!
sub _replaceNextLargerWith
{
	my ( $array, $aValue, $high ) = @_;
	$high ||= $#$array;
	# off the end?
	if ( $high == -1 || $aValue > $array->[ -1 ] )
	{
		push( @$array, $aValue );
		return $high + 1;
	}
	# binary search for insertion point...
	my $low = 0;
	my $index;
	my $found;
	while ( $low <= $high )
	{
		$index = ( $high + $low ) / 2;
		$found = $array->[ $index ];
		if ( $aValue == $found )
		{
			return undef;
		}
		elsif ( $aValue > $found )
		{
			$low = $index + 1;
		}
		else
		{
			$high = $index - 1;
		}
	}
	# now insertion point is in $low.
	$array->[ $low ] = $aValue;		# overwrite next larger
	return $low;
}
# This method computes the longest common subsequence in $a and $b.
# Result is array or ref, whose contents is such that
# 	$a->[ $i ] = $b->[ $result[ $i ] ]
# foreach $i in ( 0..scalar( @result ) if $result[ $i ] is defined.
# An additional argument may be passed; this is a hash or key generating
# function that should return a string that uniquely identifies the given
# element.  It should be the case that if the key is the same, the elements
# will compare the same. If this parameter is undef or missing, the key
# will be the element as a string.
# By default, comparisons will use "eq" and elements will be turned into keys
# using the default stringizing operator '""'.
# Additional parameters, if any, will be passed to the key generation routine.
sub _longestCommonSubsequence
{
	my $a = shift;	# array ref
	my $b = shift;	# array ref
	my $keyGen = shift;	# code ref
	my $compare;	# code ref
	# set up code refs
	# Note that these are optimized.
	if ( !defined( $keyGen ) )	# optimize for strings
	{
		$keyGen = sub { $_[0] };
		$compare = sub { my ($a, $b) = @_; $a eq $b };
	}
	else
	{
		$compare = sub {
			my $a = shift; my $b = shift;
			&$keyGen( $a, @_ ) eq &$keyGen( $b, @_ )
		};
	}
	my ($aStart, $aFinish, $bStart, $bFinish, $matchVector) = (0, $#$a, 0, $#$b, []);
	# First we prune off any common elements at the beginning
	while ( $aStart <= $aFinish
		and $bStart <= $bFinish
		and &$compare( $a->[ $aStart ], $b->[ $bStart ], @_ ) )
	{
		$matchVector->[ $aStart++ ] = $bStart++;
	}
	# now the end
	while ( $aStart <= $aFinish
		and $bStart <= $bFinish
		and &$compare( $a->[ $aFinish ], $b->[ $bFinish ], @_ ) )
	{
		$matchVector->[ $aFinish-- ] = $bFinish--;
	}
	# Now compute the equivalence classes of positions of elements
	my $bMatches = _withPositionsOfInInterval( $b, $bStart, $bFinish, $keyGen, @_ );
	my $thresh = [];
	my $links = [];
	my ( $i, $ai, $j, $k );
	for ( $i = $aStart; $i <= $aFinish; $i++ )
	{
		$ai = &$keyGen( $a->[ $i ] );
		if ( exists( $bMatches->{ $ai } ) )
		{
			$k = 0;
			for $j ( reverse( @{ $bMatches->{ $ai } } ) )
			{
				# optimization: most of the time this will be true
				if ( $k
					and $thresh->[ $k ] > $j
					and $thresh->[ $k - 1 ] < $j )
				{
					$thresh->[ $k ] = $j;
				}
				else
				{
					$k = _replaceNextLargerWith( $thresh, $j, $k );
				}
				# oddly, it's faster to always test this (CPU cache?).
				if ( defined( $k ) )
				{
					$links->[ $k ] =
						[ ( $k ? $links->[ $k - 1 ] : undef ), $i, $j ];
				}
			}
		}
	}
	if ( @$thresh )
	{
		for ( my $link = $links->[ $#$thresh ]; $link; $link = $link->[ 0 ] )
		{
			$matchVector->[ $link->[ 1 ] ] = $link->[ 2 ];
		}
	}
	return wantarray ? @$matchVector : $matchVector;
}
sub traverse_sequences
{
	my $a = shift;	# array ref
	my $b = shift;	# array ref
	my $callbacks = shift || { };
	my $keyGen = shift;
	my $matchCallback = $callbacks->{'MATCH'} || sub { };
	my $discardACallback = $callbacks->{'DISCARD_A'} || sub { };
	my $discardBCallback = $callbacks->{'DISCARD_B'} || sub { };
	my $matchVector = _longestCommonSubsequence( $a, $b, $keyGen, @_ );
	# Process all the lines in match vector
	my $lastA = $#$a;
	my $lastB = $#$b;
	my $bi = 0;
	my $ai;
	for ( $ai = 0; $ai <= $#$matchVector; $ai++ )
	{
		my $bLine = $matchVector->[ $ai ];
		if ( defined( $bLine ) )
		{
			&$discardBCallback( $ai, $bi++, @_ ) while $bi < $bLine;
			&$matchCallback( $ai, $bi++, @_ );
		}
		else
		{
			&$discardACallback( $ai, $bi, @_ );
		}
	}
	&$discardACallback( $ai++, $bi, @_ ) while ( $ai <= $lastA );
	&$discardBCallback( $ai, $bi++, @_ ) while ( $bi <= $lastB );
	return 1;
}
sub LCS
{
	my $a = shift;	# array ref
	my $matchVector = _longestCommonSubsequence( $a, @_ );
	my @retval;
	my $i;
	for ( $i = 0; $i <= $#$matchVector; $i++ )
	{
		if ( defined( $matchVector->[ $i ] ) )
		{
			push( @retval, $a->[ $i ] );
		}
	}
	return wantarray ? @retval : \@retval;
}
sub diff
{
	my $a = shift;	# array ref
	my $b = shift;	# array ref
	my $retval = [];
	my $hunk = [];
	my $discard = sub { push( @$hunk, [ '-', $_[ 0 ], $a->[ $_[ 0 ] ] ] ) };
	my $add = sub { push( @$hunk, [ '+', $_[ 1 ], $b->[ $_[ 1 ] ] ] ) };
	my $match = sub { push( @$retval, $hunk ) if scalar(@$hunk); $hunk = [] };
	traverse_sequences( $a, $b,
		{ MATCH => $match, DISCARD_A => $discard, DISCARD_B => $add },
		@_ );
	&$match();
	return wantarray ? @$retval : $retval;
}
1;
