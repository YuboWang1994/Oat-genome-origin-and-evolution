mkdir -p {path}/03_Gblock/01_cds_gb

cd {path}/03_Gblock/01_cds_gb

ln -s {path}/01_OrthoFinder/OrthoFinder/*/Orthogroups/Orthogroups_SingleCopyOrthologues.txt list

ln -s {path}/02_Muscle/02_pep2cds/*.msa .

cat list | while read i;do echo -ne "Gblocks $i.msa -t=c\n" >> run.sh;done

Parafly -c run.sh -CPU 20
