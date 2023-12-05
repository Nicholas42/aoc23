#!/bin/env perl

use warnings;
use strict;
use warnings FATAL => qw[uninitialized];
use FindBin qw( $RealBin );
use lib $RealBin;

use utils;

my ( $seeds_raw, $maps ) = utils::readInput(shift);
my @seeds;

while ( $#$seeds_raw > 0 ) {
    my $low = shift @$seeds_raw;
    push( @seeds, { low => $low, high => $low + shift @$seeds_raw } );
}

for my $map (@$maps) {
    @$map = sort { $$a{src} <=> $$b{src} } @$map;
}

sub findNext {
    my $interval = $_[0];
    my @resulting_intervals;

    for my $map ( @{ $_[1] } ) {
        my $src_high = $$map{src} + $$map{len};
        if ( $src_high < $$interval{low} || $$map{src} > $$interval{high} ) {
            next;
        }

        my $low  = utils::max( $$interval{low}, $$map{src} );
        my $high = utils::min( $$interval{high}, $src_high );
        my $diff = $low - $$map{src};

        if ( $low > $$interval{low} ) {
            push( @resulting_intervals, {%$interval} );
            $$interval{low} = $low;
        }

        my $new_low  = $$map{dest} + $diff;
        my $new_high = ( $high - $low ) + $new_low;

        push( @resulting_intervals, { low => $new_low, high => $new_high } );

        $$interval{low} = $high;
    }
    if ( $$interval{low} < $$interval{high} ) {
        push( @resulting_intervals, $interval );
    }
    return \@resulting_intervals;
}

sub findLoc {
    my @intervals = ( $_[0] );
    for my $mapping (@$maps) {
        my @new_intervals;
        for my $interval (@intervals) {
            my $remapped = findNext( $interval, $mapping );
            push( @new_intervals, @$remapped );
        }
        @intervals = @new_intervals;
    }

    my $min = utils::findMin { $_[0]->{low} < $_[1]->{low} } @intervals;

    return $min->{low};
}

my @locations = map { findLoc($_) } @seeds;
my $min       = utils::min @locations;
print("$min\n");
