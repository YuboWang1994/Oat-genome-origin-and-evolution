## (1) Along.pseudogenes.ppipe.tsv is the results from PseudoPipe using default parameters
## (2) Along.gene.gff3 is the protein-coding genes
grep -v "#" Along.pseudogenes.ppipe.tsv |awk '{print $1"\t"$2-1"\t"$3"\t"$5"\t.\t"$4}' |sort -u >Along.pseudogenes.ppipe.bed
bedtools intersect -s -v -a Along.pseudogenes.ppipe.bed -b <(awk '$3 == "mRNA"' Along.gene.gff3) >Along.pseudogenes.ppipe.rmdup.bed
