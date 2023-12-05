#!/bin/env perl

use warnings;
use strict;
use warnings FATAL => qw[uninitialized];
use FindBin qw( $RealBin );
use lib $RealBin;

use utils;

my ( $seeds, $maps ) = utils::readInput(shift);

sub findNext {
    my $number = $_[0];
    for my $map ( @{ $_[1] } ) {
        my $diff = $number - $$map{src};

        if ( $diff >= 0 && $diff < $$map{len} ) {
            return $$map{dest} + $diff;
        }
    }
    return $number;
}

sub findLoc {
    my $number = $_[0];

    for my $map (@$maps) {
        $number = findNext( $number, $map );
    }

    return $number;
}

my @locations = map { findLoc($_) } @$seeds;

my $minLoc = utils::min(@locations);
print "$minLoc\n";
