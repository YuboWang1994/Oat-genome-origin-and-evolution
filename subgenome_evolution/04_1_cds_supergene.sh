mkdir -p {path}/04_Supergene/01_cds

cd {path}/04_Supergene/01_cds

realpath {path}/03_Gblock/02_cds_fillgap/*.msa-gb.noSpace.fasta > muscle.list

ln -s {path}/subspecies.list species.txt

python {path}/filter_gblock_by_length.py 300 > filtered.muscle.list

python {path}/combine_gblock.py

cat *.fa > SingleCopy.groups.abbr.fasta

python {path}/count_length.py > length.txt

python {path}/fasta2phylip.py SingleCopy.groups.abbr.fasta {species_number} {base_number} > SingleCopy.groups.CDS.abbr.phylip        # base_number can be found in the length.txt file
