mkdir -p {path}/vcf/D

cd {path}/vcf/D

realpath {path}/*/bam/D/*gvcf > gvcf.list           # Diploid C samples are excluded
realpath {path}/*/D_bam/D/*gvcf >> gvcf.list

gatk --java-options " -Xmx30G -Djava.io.tmpdir=./tmp " CombineGVCFs -V gvcf.list -O D.gvcf -R {path}/00_genome/ACD/D_index/D.fa
gatk --java-options " -Xmx30G -Djava.io.tmpdir=./tmp " GenotypeGVCFs -V C.gvcf -O D.vcf -R {path}/00_genome/ACD/D_index/D.fa

perl {path}/filterSNP.pl D      # change average read depth of each sample at line 16. Read depth can be obtained by 'samtools depth'.

vcftools --gzvcf D.snp.vcf.gz --bed D.exon.bed --recode --recode-INFO-all --out filtered 
bgzip filtered.recode.vcf
python3 {path}/vcf2phylip.py -i filtered.recode.vcf.gz
python3 {path}/ascbias.py  -p filtered.recode.min4.phy -o out.phy
raxml-ng --all --msa out.phy --model GTR+ASC_LEWIS --tree pars{10} --bs-trees 200 --prefix D --threads 30
