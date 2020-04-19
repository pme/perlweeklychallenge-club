#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say current_sub/;
use Data::Dumper;
use List::Util qw/sum/;

sub path
{
    my $s = shift;
    my $n = shift;
    my $p = shift;

    return unless defined  $n;

    #say "v: ", $n->{VALUE}, Dumper($p);

    my @p = (@$p, $n->{VALUE});
    my $sum = sum(@p);
    if ($sum == $s and (not defined $n->{LEFT} and
                        not defined $n->{RIGHT})) {
        say "@p";
        return;
    } elsif ($sum >= $s) {
        return;
    }

    __SUB__->($s, $n->{LEFT},  \@p);
    __SUB__->($s, $n->{RIGHT}, \@p);
}

#         5
#        / \
#       4   8
#      /   / \
#     11  13  9
#    /  \      \
#   7    2      1

my $sum = 22;

my $root = {
    VALUE => 5,
    LEFT  => {
        VALUE => 4,
        LEFT  => {
            VALUE => 11,
            LEFT  => {
                VALUE => 7,
                LEFT  => undef,
                RIGHT => undef,
            },
            RIGHT => {
                VALUE => 2,
                LEFT  => undef,
                RIGHT => undef,
            },
        },
        RIGHT => undef,
    },
    RIGHT => {
        VALUE => 8,
        LEFT  => {
            VALUE => 13,
            LEFT  => undef,
            RIGHT => undef,
        },
        RIGHT => {
            VALUE => 9,
            LEFT  => undef,
            RIGHT => {
                VALUE => 1,
                LEFT  => undef,
                RIGHT => undef,

            },
        },
    },
};

say Dumper($root);

path($sum, $root, []);


