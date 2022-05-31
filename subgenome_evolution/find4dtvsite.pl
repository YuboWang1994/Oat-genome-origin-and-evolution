#!/usr/bin/perl -w
#此脚本用来查找哪些氨基酸位点是具备4DTV属性(要求每个物种上面的同一个位置的蛋白必须是一样的)
#4DTV:亮L，缬V，丝S，脯P，苏T，丙A，精R，甘G
use strict;
use Bio::SeqIO;
use Bio::Seq;

my($infile,$outfile)=@ARGV;
die"$0 Usage:<muscleoutput><outname>\n"if(@ARGV!=2);

open(O,">$outfile");

my %hash;
my $seqlength;
my $fa=Bio::SeqIO->new(-file=>$infile,-format=>'fasta');
while(my $seq_obj=$fa->next_seq){
    my $id=$seq_obj->id;
    my $seq=$seq_obj->seq;
    @{$hash{$id}}=split//,$seq;
    $seqlength=length($seq);
}
print O "Site\n";
for(my $i=0;$i<$seqlength;$i++){
    my %hash1;
    my @sitearray;
    foreach my $id(sort keys %hash){
	push(@sitearray,${$hash{$id}}[$i]);
    }
    foreach my $sitearray(@sitearray){
	$hash1{$sitearray}++;
    }
    my @protein=keys %hash1;
    if(scalar(@protein)==1 && $protein[0] ne "-"){#是同一种蛋白
	if($protein[0] eq "L" ||$protein[0] eq "V"||$protein[0] eq "S"||$protein[0] eq "P"||$protein[0] eq "T"||$protein[0] eq "A"||$protein[0] eq "R"||$protein[0] eq "G"){
	    print O "$i\n";
	}
    }
    elsif(scalar(@protein)==2){#存在两种元素
	if($protein[0] ne "-" && $protein[1] eq "-" ){
	    if($protein[0] eq "L" ||$protein[0] eq "V"||$protein[0] eq "S"||$protein[0] eq "P"||$protein[0] eq "T"||$protein[0] eq "A"||$protein[0] eq "R"||$protein[0]eq "G"){
		print O "$i\n";
	    }
	}
	elsif($protein[0] eq "-" &&  $protein[1] ne "-"){
	    if($protein[1] eq "L" ||$protein[1] eq "V"||$protein[1] eq "S"||$protein[1] eq "P"||$protein[1] eq "T"||$protein[1] eq "A"||$protein[1] eq "R"||$protein[1] eq "G"){
		print O "$i\n";
	    }
	}
    }
}

close O;
