#!/usr/bin/perl

use Neuron;

print "1..1\n";

my ($i, $k);

my $nn = NNet -> new(49, 7, 2);

$nn -> save("untrained3");

my $M1 = [[
	0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 1, 0, 0, 0,
	0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 1, 0, 0, 0,
	0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 1, 0, 0, 0
],
[
	0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0,
	1, 1, 1, 1, 1, 1, 1, 
	0, 0, 0, 0, 0, 0, 0,
	0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0
],
[
	1, 0, 0, 0, 0, 0, 0, 
	0, 1, 0, 0, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0,
	0, 0, 0, 1, 0, 0, 0, 
	0, 0, 0, 0, 1, 0, 0,
	0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 0, 0, 1
],
[
	0, 0, 0, 0, 0, 0, 1, 
	0, 0, 0, 0, 0, 1, 0, 
	0, 0, 0, 0, 1, 0, 0,
	0, 0, 0, 1, 0, 0, 0, 
	0, 0, 1, 0, 0, 0, 0,
	0, 1, 0, 0, 0, 0, 0, 
	1, 0, 0, 0, 0, 0, 0
]
];
my $M2 = [
[
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0
],
[
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0
],
[
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0
],
[
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0
]
];

my $MT= [
[
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 1, 0, 1, 0, 0
],
[
	0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 1, 0, 0, 
	1, 1, 1, 1, 1, 1, 1,
	0, 0, 0, 0, 0, 0, 0, 
	1, 1, 1, 1, 1, 1, 1,
	0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 0, 0
],
[
	0, 1, 0, 0, 0, 0, 0, 
	1, 0, 1, 0, 0, 0, 0, 
	0, 1, 0, 1, 0, 0, 0,
	0, 0, 1, 0, 1, 0, 0, 
	0, 0, 0, 1, 0, 1, 0,
	0, 0, 0, 0, 1, 0, 1, 
	0, 0, 0, 0, 0, 1, 0
]
];


my $D = [[1, 0],[0, 1]];

for($i = 0; $i < 50; $i ++) {

	for($k = 0; $k < 4; $k ++) {
		$nn -> train(0.001, 0.3, @{$M1->[$k]}, @{$D->[0]});
		$nn -> train(0.001, 0.3, @{$M2->[$k]}, @{$D->[1]});
	}
	print "Cnt: $i\n";
}

($r1, $r2) = $nn -> run(@{$MT -> [0]});
# printf "%08.6f %08.6f\n", $r1, $r2;
($r1, $r2) = $nn -> run(@{$MT -> [1]});
# printf "%08.6f %08.6f\n", $r1, $r2;
($r1, $r2) = $nn -> run(@{$MT -> [2]});
# printf "%08.6f %08.6f\n", $r1, $r2;


$nn -> save("trained3");

print "ok 1\n";
