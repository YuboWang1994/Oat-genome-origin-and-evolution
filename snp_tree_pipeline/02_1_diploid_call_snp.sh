mkdir -p {path}/{sample}/bam

cd {path}/{sample}/bam

mkdir -p {path}/{sample}/bam/A
cd {path}/{sample}/bam/A
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/A_index/A.fa {path}/{sample}/fastq/{sample}.R1.fq.gz {path}/{sample}/fastq/{sample}.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/A_index/A.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done

mkdir -p {path}/{sample}/bam/C
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/C_index/C.fa {path}/{sample}/fastq/{sample}.R1.fq.gz {path}/{sample}/fastq/{sample}.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/C_index/C.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done

mkdir -p {path}/{sample}/bam/D
bwa mem -R "@RG\tID:{sample}/\tLB:{sample}/\tPL:ILLUMINA/\tSM:{sample}" -t 10 {path}/00_genome/ACD/D_index/D.fa {path}/{sample}/fastq/{sample}.R1.fq.gz {path}/{sample}/fastq/{sample}.R2.fq.gz -o {sample}.sam && touch Step1_done
samtools view -h {sample}.sam |grep -v 'XA:Z' |grep -v 'SA:Z' |samtools sort -@ 5 -m 10G -o {sample}.bam - && touch Step2_done 
samtools rmdup {sample}.bam {sample}.rmdup.bam && samtools index -c {sample}.rmdup.bam && touch Step3_done
gatk HaplotypeCaller -R {path}/00_genome/ACD/D_index/D.fa -I {sample}.rmdup.bam -O {sample}.rmdup.bam.gvcf -ERC GVCF 1> {sample}.rmdup.bam.gvcf.gz.log 2> {sample}.rmdup.bam.gvcf.gz.err && touch Step4_done
