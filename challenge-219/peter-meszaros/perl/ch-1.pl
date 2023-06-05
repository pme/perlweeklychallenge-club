#!/usr/bin/env perl
# You are given a list of numbers.
# 
# Write a script to square each number in the list and return the sorted list, increasing order.
# Example 1
# 
# Input: @list = (-2, -1, 0, 3, 4)
# Output: (0, 1, 4, 9, 16)
# 
# Example 2
# 
# Input: @list = (5, -4, -1, 3, 6)
# Output: (1, 9, 16, 25, 36)

use strict;
use warnings;
use Test::More;

my $cases = [
	[-2, -1, 0, 3, 4],
	[5, -4, -1, 3, 6],
];

sub sorted_squares
{
	my $n = shift;

    return [sort { $a <=> $b } map { $_**2 } @$n];
}

is_deeply(sorted_squares($cases->[0]), [0, 1, 4, 9, 16],   '[-2, -1, 0, 3, 4]');
is_deeply(sorted_squares($cases->[1]), [1, 9, 16, 25, 36], '[5, -4, -1, 3, 6]');
done_testing();

exit 0;
