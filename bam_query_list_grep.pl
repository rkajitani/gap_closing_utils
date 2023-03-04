#!/usr/bin/perl

(@ARGV != 2) and die "usage: $0 query_list.txt in.bam\n";

$query_name_file = $ARGV[0];
$bam_name = $ARGV[1];

%query_flag = ();
open(IN, $query_name_file);
while (<IN>) {
	$query_flag{$_} = 1;
}
close(IN);

open(IN, "samtools view -h $bam_name |");
open(OUT, "| samtools view -Sb -");
while (<IN>) {
	if (/^@/ or $query_flag{(split(/\t/, $_))[0]}) {
		print OUT;
	}
}
close(IN);
close(OUT);
