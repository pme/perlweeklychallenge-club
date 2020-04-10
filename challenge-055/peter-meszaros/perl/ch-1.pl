#!/usr/bin/perl

use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;
use Term::ANSIColor;

my $n = '01100010101010011001001010101';

if ($ARGV[0]) {
    die "Usage: $0 01010101010\n"
        if (grep { $_ ne '0' and $_ ne '1'} split(//, $ARGV[0]));
    $n = $ARGV[0];
}

my $len = length($n) - 1;
my $f = length $len;

my %res;
for my $l (0..$len) {
    for my $r ($l..$len) {
        my $e = $n;
        for my $i ($l..$r) {
            substr($e, $i, 1) = substr($n, $i, 1) eq '1' ? '0' : '1';
            my $k = "$l-$r";
            $res{$k}->{pat} = $e;
            my $v = 0;
            for my $i (0..$len) {
                ++$v if substr($e, $i, 1) eq '1';
            }
            $res{$k}->{val} = $v;
        }
    }
}

my @skey = sort { $res{$b}->{val} <=> $res{$a}->{val} } keys %res;
#say Dumper(\%res, \@skey);

my $max = $res{$skey[0]}->{val};
say "len: $len max: $max";

my $h = ' ' x (2 * $f + 6);
my $r;
for my $i (0..$len) {
    $r .= chr(48 + ($i % 10));
}


say ${h} . $r;
for my $k (@skey) {
    my ($l, $r) = split /-/, $k;
    last if $res{$k}->{val} < $max;
    my $olft = substr($n, 0,  $l);
    my $omid = substr($n, $l, $r+1-$l);
       $omid = colored(['blue on_white'], $omid);
    my $orgt = substr($n, $r+1, $len);

    my $nlft = substr($res{$k}->{pat}, 0,  $l);
    my $nmid = substr($res{$k}->{pat}, $l, $r+1-$l);
       $nmid = colored(['blue on_white'], $nmid);
    my $nrgt = substr($res{$k}->{pat}, $r+1, $len);
    say sprintf("%0${f}d-%0${f}d", $l, $r) . " --> $olft$omid$orgt";
    say "${h}$nlft$nmid$nrgt";
}




