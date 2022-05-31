mkdir -p {path}/03_Gblock/02_cds_fillgap

cd {path}/03_Gblock/02_cds_fillgap

ln -s {path}/01_OrthoFinder/OrthoFinder/*/Orthogroups/Orthogroups_SingleCopyOrthologues.txt list

cat list | while read i;do echo -ne "python3 {path}/U2X_fasta.py -b 60 -d 0 -f ../01_cds_gb/$i.msa-gb -r $i.msa-gb.noSpace.fasta\n" >> run.sh;done

Parafly -c run.sh -CPU 20
