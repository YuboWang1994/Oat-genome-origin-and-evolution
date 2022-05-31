# Split raw data

cd {path}/{sample}/fastq

bwa mem -R "@RG\tID:{sample}\tLB:{sample}\tPL:ILLUMINA\tSM:{sample}" -t 10 {path}/00_genome/CD/CD_index/CD.fa {sample}.R1.fq.gz {sample}.R2.fq.gz -o {sample}.sam && touch Step1_done

samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |awk '$3!~"chr[0-9]D"'| awk '$3!~"Contig"'|samtools fastq -1 C.R1.fq -2 C.R2.fq -

samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |awk '$3!~"chr[0-9]C"'| awk '$3!~"Contig"'|samtools fastq -1 D.R1.fq -2 D.R2.fq -

seqkit seq -n -i C.R1.fq |sort -T tmp -u > C.R1.fq.list
seqkit seq -n -i C.R2.fq |sort -T tmp -u > C.R2.fq.list

seqkit seq -n -i D.R1.fq |sort -T tmp -u > D.R1.fq.list
seqkit seq -n -i D.R2.fq |sort -T tmp -u > D.R2.fq.list

awk '{if(NR==FNR){a[$1]}else if($1 in a)print $0}' C.R1.fq.list C.R2.fq.list > C.list
awk '{if(NR==FNR){a[$1]}else if($1 in a)print $0}' D.R1.fq.list D.R2.fq.list > D.list

perl {path}/fishInWinter.pl -bf table -ff fq -gene C.list C.R1.fq | gzip > C.R1.fq.gz
perl {path}/fishInWinter.pl -bf table -ff fq -gene C.list C.R2.fq | gzip > C.R2.fq.gz

perl {path}/fishInWinter.pl -bf table -ff fq -gene D.list D.R1.fq | gzip > D.R1.fq.gz
perl {path}/fishInWinter.pl -bf table -ff fq -gene D.list D.R2.fq | gzip > D.R2.fq.gz


# C subgenome data alignment

mkdir -p {path}/{sample}/C_bam/A
cd {path}/{sample}/C_bam/A
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/A_index/A.fa {path}/{sample}/fastq/C.R1.fq.gz {path}/{sample}/fastq/C.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/A_index/A.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done

mkdir -p {path}/{sample}/C_bam/C
cd {path}/{sample}/C_bam/C
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/C_index/C.fa {path}/{sample}/fastq/C.R1.fq.gz {path}/{sample}/fastq/C.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/C_index/C.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done

mkdir -p {path}/{sample}/C_bam/D
cd {path}/{sample}/C_bam/D
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/D_index/D.fa {path}/{sample}/fastq/C.R1.fq.gz {path}/{sample}/fastq/C.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/D_index/D.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done


# D subgenome data alignment
mkdir -p {path}/{sample}/D_bam/A
cd {path}/{sample}/D_bam/A
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/A_index/A.fa {path}/{sample}/fastq/C.R1.fq.gz {path}/{sample}/fastq/C.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/A_index/A.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done

mkdir -p {path}/{sample}/D_bam/C
cd {path}/{sample}/D_bam/C
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/C_index/C.fa {path}/{sample}/fastq/C.R1.fq.gz {path}/{sample}/fastq/C.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/C_index/C.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done

mkdir -p {path}/{sample}/D_bam/D
{path}/{sample}/D_bam/D
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/D_index/D.fa {path}/{sample}/fastq/C.R1.fq.gz {path}/{sample}/fastq/C.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/D_index/D.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done
