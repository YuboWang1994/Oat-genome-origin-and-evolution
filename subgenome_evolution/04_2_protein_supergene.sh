mkdir -p {path}/04_Supergene/02_pep

cd {path}/04_Supergene/02_pep

realpath {path}/03_Gblock/04_pep_fillgap/*.msa-gb.noSpace.fasta > muscle.list

ln -s {path}/subspecies.list species.txt

python {path}/filter_gblock_by_length.py 100 > filtered.muscle.list

python {path}/combine_gblock.py

cat *.fa > SingleCopy.groups.abbr.fasta

python {path}/count_length.py > length.txt

python {path}/fasta2phylip.py SingleCopy.groups.abbr.fasta {species_number} {base_number} > SingleCopy.groups.PEP.abbr.phylip        # base_number can be found in the length.txt file
