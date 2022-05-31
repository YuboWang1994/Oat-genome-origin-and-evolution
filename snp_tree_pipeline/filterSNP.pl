use strict;
use warnings;
my $contig=shift;
my $vcfDir="/public/home/User1002/08_reseq/vcf";
my $minDepth=2;
my $maxDepth=50;
my $ind=97;
my $minQual=50;
#my $AllSite="02.AllSite";
#my $SNPSite="02.SNPSite";
#my $IndelSite="02.IndelSite";
#mkdir $AllSite unless(-e $AllSite);
#mkdir $SNPSite unless(-e $SNPSite);
#mkdir $IndelSite unless(-e $IndelSite);

my @data = ("65.5327","3.40389","3.65383","23.4549","25.3714","23.9311","24.8214","26.6718","49.6645","41.6393","18.1171","3.20185","8.88849","18.9567","3.04196","8.23106","29.0947","24.9974","2.57276","14.8274","2.49636","14.1499","2.46068","13.8378","2.75482","15.7686");

open(F,"zcat $contig.vcf.gz |");
open(A," |gzip - >$contig.filtered.vcf.gz");
open(S," |gzip - >$contig.snp.vcf.gz");
open(I," |gzip - >$contig.indel.vcf.gz");
my $indel_pos=0;
while(<F>){
    chomp;
    my $line=$_;
    if($line=~m/^#/){
    print A "$line\n"; print S "$line\n"; print I "$line\n";
    }else{
    next if($line=~m/LowQual/);
    my @line=split(/\s+/,$line);
    my $ref=$line[3];  my $alt=$line[4];
    if($ref=~m/,/ || $alt=~m/,/){#################only keep bi-alleles or nonSNPsites
        next;
    }
    my $SNP=0; my $Indel=0;
    if(length($ref)==1 && length($alt)==1){
        if($alt eq '.'){
        $SNP=0;
        }else{
        $SNP=1;
        }
    }else{
        $SNP=1;
        $Indel=1;
        $indel_pos=$line[1]
    }
    if($SNP==0){
        my $miss=0;
        for(my $i=9;$i<@line;$i++){
        my $GT=$line[$i];
        if($GT=~m/\.\/\./){
            
        }else{
            if($GT=~m/^\d\/\d:(\d+):/){
            if($1<$minDepth || $1>$maxDepth){
                $line[$i]="./.:0:0";################individual site with depth <$minDepth or >$maxDepth was assigned as missing
            }else{
                $miss=1;
            }
            }elsif($GT=~m/0\/0$/){
            $line[$i]="./.:0:0";
}else{
            die "NonSNP individual depth wrong: $line\n";
            }
        }
        }
        if($miss==0){
        next;
        }else{
        print A join("\t",@line),"\n";
        }
    }else{
        my $qual=$line[5];
        $qual=0 if($qual eq ".");
        if($qual>$minQual){#########remove SNP/indel sites with qual < $minQual
        my $INFO=$line[7];
        my $DP=0;my $QD=2;my $FS=60;my $MQ=40;
        if($INFO=~m/DP\=(\d+)/){$DP=$1}else{}
        if($INFO=~m/QD\=(\d+)/){$QD=$1}else{}
        if($INFO=~m/FS\=(\d+)/){$FS=$1}else{}
        if($INFO=~m/MQ\=(\d+)/){$MQ=$1}else{}
        
        if($QD>=2 && $FS<=60 && $MQ>=40){#####remove SNP/indel with DP QD FS MQ
            my $miss=0;
            for(my $i=9;$i<@line;$i++){
            if($line[$i]=~m/\.\/\./){
                
            }else{
                my @tmp=split(/:/,$line[$i]);
                if(scalar @tmp<3){
                $tmp[2]=0;
                }
                my $DP2=$tmp[2];
                
                if($DP2 eq "."){
                $DP2=0;
                }
                $minDepth=$data[$i-9]/3-1;
                $maxDepth=$data[$i-9]*3+1;
                if($DP2>=$minDepth && $DP2<=$maxDepth){
                $miss=1;
                }else{
                if($line[8] eq "GT:AD:DP:GQ:PGT:PID:PL:PS"){
                    $line[$i]="./.:0,0:0:.:.:.:0,0,0";
                }else{
                    $line[$i]="./.:0,0:0:.:0,0,0";
                }
                }
                if($Indel==0 && $line[1]-$indel_pos<=-5){
                    $miss=0;
                }
                if($Indel==0 && $line[1]-$indel_pos<=5){
                    $miss=0;
                }
            }
            }
            if($miss==0){
            next;
            }else{
            if($Indel==0){
                print S join("\t",@line),"\n";
                print A join("\t",@line),"\n";
            }else{
                print I join("\t",@line),"\n";
                print A join("\t",@line),"\n";
            }
            }
        }
        }
    }
    
    
    }
}



close(I);
close(S);
close(A);
close(F);
