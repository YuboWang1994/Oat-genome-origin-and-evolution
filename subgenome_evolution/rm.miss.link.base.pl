#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;

my($infile,$outfile)=@ARGV;
die "$0 Usage:<infile><outfie>\n"if(@ARGV!=2);

open(F,"$infile");
open(O,">$outfile");

my %hash;
my %hash2;
my $length;
my $fa=Bio::SeqIO->new(-file=>$infile,-format=>'fasta');
while(my $seq_obj=$fa->next_seq){
    my $id=$seq_obj->id;
    my $seq=$seq_obj->seq;
    @{$hash{$id}}=split//,$seq;
    $length=length($seq);
}

for(my $i=0;$i<$length;$i++){
    my $mark=1;
    foreach my $species(sort keys %hash){
	if(${$hash{$species}}[$i] eq "-"){
	    $mark=0;
	}
    }
    if($mark==1){
	foreach my $speciesid(sort keys %hash){
	    push(@{$hash2{$speciesid}},${$hash{$speciesid}}[$i]);
	}
    }
}

foreach my $id(sort keys %hash2){
    print O ">$id\n";
    foreach my $base(@{$hash2{$id}}){
	print O "$base";
    }
    print O "\n";
}
close F;
close O;

