#!/usr/bin/perl

use v5.28;
use strict;
use warnings;
use Scalar::Util qw/looks_like_number/;
use Data::Dumper;

my %seq;
sub makewave
{
    my ($wave, $arr) = @_;
    if (@$arr == 0) {
        #say "@$wave";
        $seq{"@$wave"}++;
        return;
    }
    my $n = 0;
    for (@$arr) {
        my @a = @$arr;
        my @w = @$wave;
        my $e = splice @a, $n++, 1;
        if (((@w % 2) == 1 and $e <= $w[-1]) or
            ((@w % 2) == 0 and $e >= $w[-1])) {
            push @w, $e;
            __SUB__->(\@w, \@a);
        }
    }
}

my @arr = qw/8 2 2 3/;

if (@ARGV) {
    die "Usage: $0 4 5 3 7 8 9\n"
        if (grep { !looks_like_number($_) } @ARGV);
    @arr = @ARGV;
}

my $n = 0;
for (@arr) {
    my @a = @arr;
    my @wave = splice @a, $n++, 1;
    my $waves = makewave(\@wave, \@a);
}

my $i = 0;
for my $k (sort keys %seq) {
    printf "%2d -- %s\n", ++$i, $k;
}


