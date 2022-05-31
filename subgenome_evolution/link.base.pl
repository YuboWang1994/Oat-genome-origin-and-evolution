#!/usr/bin/perl  -w
use strict;
use Bio::SeqIO;
use Bio::Seq;

my $outfile=shift;
my $path="./02.4DTVbase";

my @infile=glob("$path/*");
open(O,">$outfile");
my %hash;

foreach my $infile(@infile){
    $infile=~/\/(\d+)\.base/;
    my $num=$1;
    my $fa=Bio::SeqIO->new(-file=>$infile,-format=>'fasta');
    while(my $seq_obj=$fa->next_seq){
	my $id=$seq_obj->id;
	my $seq=$seq_obj->seq;
	if($seq eq ""){
	    print "$num\t$id\n";
	}
	$id=~/([a-zA-Z].+)\|/;
	my $species=$1;
	$hash{$species}{$num}=$seq;
    }
}
print "hash done\n";
foreach my $species(sort keys %hash){
    my $totalseq;
    foreach my $num(sort {$a<=>$b} keys %{$hash{$species}}){
	my $tempseq=$hash{$species}{$num};
	$totalseq.=$tempseq;
    }
    print O  ">$species\n$totalseq\n";
}

close O;
