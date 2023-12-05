package utils;

use strict;
use warnings;

sub findMin(&@) {
    my $func = \&{shift @_ };
    my $min;
    for my $elem (@_) {
        if(!$min or $func->($elem, $min)) {
            $min = $elem;
        }
    }
    return $min;
}

sub min(@) {
    return findMin {$_[0] < $_[1]} @_;
}

sub max(@) {
    return findMin {$_[0] > $_[1]} @_;
}


sub readInput($) {
    open(FH, '<', $_[0]) or die $!;
    my $seedline = <FH>;
    my @seeds = split(' ', $seedline);
    shift @seeds;

    my @maps;
    my $currentMap;

    while(<FH>) {
        if ($_ =~ /^([^-]*)-to-([^-]*) map:/) {
            $currentMap = $1 . '-' . $2 ;
            push(@maps, [()]);
        }
        if ($_ =~ /^(\d+) (\d+) (\d+)/){
            push @{$maps[$#maps]}, { dest => $1, src => $2, len => $3 };
        }
    }

    return (\@seeds, \@maps);
}
1;
