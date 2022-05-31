mkdir -p {path}/01_OrthoFinder

cd {path}/01_OrthoFinder

cat {path}/subspecies.list |while read i;do ln -s $i.pep.fa $i.fa;done

python {path}/rename_genome_protein.py {path}/subspecies.list {path}/00_data

orthofinder -t 30 -f {path}/01_OrthoFinder
