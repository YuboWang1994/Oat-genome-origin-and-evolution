mkdir -p {path}/vcf/C

cd {path}/vcf/C

realpath {path}/*/bam/C/*gvcf > gvcf.list           # Diploid A samples are excluded
realpath {path}/*/C_bam/C/*gvcf >> gvcf.list

gatk --java-options " -Xmx30G -Djava.io.tmpdir=./tmp " CombineGVCFs -V gvcf.list -O C.gvcf -R {path}/00_genome/ACD/C_index/C.fa
gatk --java-options " -Xmx30G -Djava.io.tmpdir=./tmp " GenotypeGVCFs -V C.gvcf -O C.vcf -R {path}/00_genome/ACD/C_index/C.fa

perl {path}/filterSNP.pl C      # change average read depth of each sample at line 16. Read depth can be obtained by 'samtools depth'.

vcftools --gzvcf C.snp.vcf.gz --bed C.exon.bed --recode --recode-INFO-all --out filtered 
bgzip filtered.recode.vcf
python3 {path}/vcf2phylip.py -i filtered.recode.vcf.gz
python3 {path}/ascbias.py  -p filtered.recode.min4.phy -o out.phy
raxml-ng --all --msa out.phy --model GTR+ASC_LEWIS --tree pars{10} --bs-trees 200 --prefix C --threads 30
