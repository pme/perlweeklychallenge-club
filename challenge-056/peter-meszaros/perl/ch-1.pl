#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my @N = (2, 4, 5, 6, 7, 9);
my $k = 2;

my $c;
my %h = map { $_, $c++ } @N;

my $p = 0;
for my $i (sort { $a <=> $b } keys %h) {
    my $j = $h{$i+$k};
    say "$p,$j" if defined $j;
    ++$p;
}

exit 0;
