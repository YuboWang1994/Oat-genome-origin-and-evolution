mkdir -p {path}/vcf/A

cd {path}/vcf/A

realpath {path}/*/bam/A/*gvcf > gvcf.list           # Diploid C samples are excluded
realpath {path}/*/A_bam/A/*gvcf >> gvcf.list
realpath {path}/*/D_bam/A/*gvcf >> gvcf.list

gatk --java-options " -Xmx30G -Djava.io.tmpdir=./tmp " CombineGVCFs -V gvcf.list -O A.gvcf -R {path}/00_genome/ACD/A_index/A.fa
gatk --java-options " -Xmx30G -Djava.io.tmpdir=./tmp " GenotypeGVCFs -V A.gvcf -O A.vcf -R {path}/00_genome/ACD/A_index/A.fa

perl {path}/filterSNP.pl A      # change average read depth of each sample at line 16. Read depth can be obtained by 'samtools depth'.

vcftools --gzvcf A.snp.vcf.gz --bed A.exon.bed --recode --recode-INFO-all --out filtered 
bgzip filtered.recode.vcf
python3 {path}/vcf2phylip.py -i filtered.recode.vcf.gz
python3 {path}/ascbias.py  -p filtered.recode.min4.phy -o out.phy
raxml-ng --all --msa out.phy --model GTR+ASC_LEWIS --tree pars{10} --bs-trees 200 --prefix A --threads 30
