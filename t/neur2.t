#!/usr/bin/perl

use Neuron;
# use Benchmark;

# $| = 1;

print "1..1\n";

my ($i, $k);

my $nn = NNet -> new(64, 5, 1);

$nn -> save("untrained");

# ------------------------------------------------------------------------

my $M = [[
	0, 0, 0, 1, 1, 0, 0, 0, 
	0, 0, 1, 1, 1, 1, 0, 0,
	0, 0, 1, 0, 0, 1, 0, 0, 
	0, 0, 1, 0, 0, 1, 0, 0,
	0, 0, 1, 0, 0, 1, 0, 0, 
	0, 1, 1, 1, 1, 1, 1, 0,
	1, 1, 0, 0, 0, 0, 1, 1, 
	1, 1, 0, 0, 0, 0, 1, 1
],
[
	1, 1, 1, 1, 1, 0, 0, 0, 
	0, 1, 1, 0, 0, 1, 1, 0,
	0, 1, 1, 0, 0, 1, 1, 0, 
	0, 1, 1, 1, 1, 1, 0, 0,
	0, 1, 1, 0, 0, 1, 1, 0, 
	0, 1, 1, 0, 0, 1, 1, 1,
	0, 1, 1, 0, 0, 1, 1, 0, 
	1, 1, 1, 1, 1, 0, 0, 0
]];
my $MT = [[
	0, 0, 0, 1, 1, 0, 0, 1, 
	0, 0, 1, 1, 1, 1, 0, 0,
	0, 0, 1, 0, 0, 1, 0, 0, 
	0, 0, 1, 0, 0, 1, 0, 0,
	0, 0, 1, 0, 0, 1, 0, 0, 
	0, 1, 1, 1, 1, 1, 1, 0,
	0, 1, 0, 0, 0, 0, 1, 0, 
	0, 1, 1, 1, 1, 0, 1, 0
],
[
	0, 1, 1, 1, 1, 0, 0, 0, 
	0, 1, 1, 0, 0, 1, 0, 0,
	0, 1, 1, 0, 0, 1, 1, 1, 
	0, 1, 1, 1, 1, 1, 0, 0,
	0, 1, 1, 0, 0, 1, 0, 0, 
	0, 1, 1, 0, 0, 1, 1, 1,
	0, 1, 1, 0, 0, 1, 0, 0, 
	0, 1, 1, 1, 1, 0, 0, 0
]];

my $D = [[1],[0]];

my $mse = 0.1;
my $cnt;

# $TM1 = new Benchmark;

for($i=0;;$i++) {
	$cnt = 0;
	for($k = 0; $k < 2; $k ++) {
#		$tm0 = new Benchmark;
		$cnt += $nn -> train($mse, 0.3, @{$M->[$k]}, @{$D->[$k]});
#		$tm1 = new Benchmark;
#		print timestr(timediff($tm1, $tm0), "nop"), "\n";
	}
	if($cnt == 0) { $mse /= 10.0;}
#	print "i: $i, Cnt: $cnt, mse: $mse\n";
	last if($mse < 0.001);
}

# $TM2 = new Benchmark;
# print "All: ", timestr(timediff($TM2, $TM1), "nop"), "\n";


# print "R1: ", $nn -> run(@{$MT -> [0]}), "\n";
# print "R2: ", $nn -> run(@{$MT -> [1]}), "\n";


$nn -> save("trained");

print "ok 1\n";

