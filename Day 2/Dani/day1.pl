use strict;
use warnings;

use Path::Tiny;
use autodie;

my $dir = path('Day 2/Dani/');
my $file = $dir->child('input.txt');

my $content = $file->slurp_utf8;
#split content to array
my @rounds = split('\r\n', $content);

my $win = 6;
my $draw = 3;
my $loss = 0;

my $rock1 = "A";
my $paper1 = "B";
my $scissors1 = "C";

my $rock2 = "X";
my $paper2 = "Y";
my $scissors2 = "Z";

my %score = (
    $rock2 => {
        $rock1 => $draw + 1,
        $paper1 => $loss + 1,
        $scissors1 => $win + 1,
    },
    $paper2 => {
        $rock1 => $win + 2,
        $paper1 => $draw + 2,
        $scissors1 => $loss + 2,
    },
    $scissors2 => {
        $rock1 => $loss + 3,
        $paper1 => $win + 3,
        $scissors1 => $draw + 3,
    },
);

my $total = 0;

foreach my $round (@rounds) {
    my ($player1, $player2) = split(' ', $round);
    $total += $score{$player2}{$player1};
}

print "$total\n";


# Part 2

my $winSymbol = "Z";
my $drawSymbol = "Y";
my $lossSymbol = "X";

my %results = (
    $winSymbol => {
        $rock1 => $win + 2,
        $paper1 => $win + 3,
        $scissors1 => $win + 1,
    }, 
    $drawSymbol => {
        $rock1 => $draw + 1,
        $paper1 => $draw + 2,
        $scissors1 => $draw + 3,
    },
    $lossSymbol => {
        $rock1 => $loss + 3,
        $paper1 => $loss + 1,
        $scissors1 => $loss + 2,
    },
);

$total = 0;
foreach my $round (@rounds) {
    my ($player1, $player2) = split(' ', $round);
    $total += $results{$player2}{$player1};
}

print $total;


