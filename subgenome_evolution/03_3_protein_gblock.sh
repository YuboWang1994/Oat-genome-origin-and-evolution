mkdir -p {path}/03_Gblock/03_pep_gb

cd {path}/03_Gblock/03_pep_gb

ln -s {path}/01_OrthoFinder/OrthoFinder/*/Orthogroups/Orthogroups_SingleCopyOrthologues.txt list

ln -s {path}/02_Muscle/01_run_muscle/*.msa .

cat list | while read i;do echo -ne "Gblocks $i.msa -t=p\n" >> run.sh;done

Parafly -c run.sh -CPU 20
