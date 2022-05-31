#!/usr/bin/perl -w
#此脚本根据上一步找出的具有4Dtv属性的位点，提取比对好的cds序列中的相应位点
#4DTV:亮L，缬V，丝S，脯P，苏T，丙A，精R，甘G
use strict;
use Bio::SeqIO;
use Bio::Seq;

my($genome,$infile,$outfile)=@ARGV;
die"$0 Usage:<pal2naloutput><sitefile><outname>\n"if(@ARGV!=3);
open(F,"$infile");
open(O,">$outfile");

my %hash;
my $fa=Bio::SeqIO->new(-file=>$genome,-format=>'fasta');
while(my $seq_obj=$fa->next_seq){
    my $id=$seq_obj->id;
    my $seq=$seq_obj->seq;
    $hash{$id}=$seq;
}

my @array;
<F>;
while(my $site=<F>){
    chomp $site;
    push(@array,$site);
}
foreach my $species(sort keys %hash){
    print O ">$species\n";
    foreach my $proteinsite(@array){
	my $basesite=$proteinsite*3+2;
	my $base=substr($hash{$species},$basesite,1);
	print O "$base";
    }
    print O "\n";
}
close F;
close O;
