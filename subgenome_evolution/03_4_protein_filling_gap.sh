mkdir -p {path}/03_Gblock/04_pep_fillgap

cd {path}/03_Gblock/04_pep_fillgap

ln -s {path}/01_OrthoFinder/OrthoFinder/*/Orthogroups/Orthogroups_SingleCopyOrthologues.txt list

cat list | while read i;do echo -ne "python3 {path}/U2X_fasta.py -b 60 -d 0 -f ../03_pep_gb/$i.msa-gb -r $i.msa-gb.noSpace.fasta\n" >> run.sh;done

Parafly -c run.sh -CPU 20
