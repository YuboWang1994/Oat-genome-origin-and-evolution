cd {path}/01_OrthoFinder/OrthoFinder/*/Single_Copy_Orthologue_Sequences

python {path}/rename.singlecopy.py {path}/01_OrthoFinder/OrthoFinder/*/Orthogroups_SingleCopyOrthologues.txt

mkdir -p {path}/02_Muscle/01_run_muscle

cd {path}/02_Muscle/01_run_muscle

ln -s {path}/01_OrthoFinder/OrthoFinder/*/Orthogroups/Orthogroups_SingleCopyOrthologues.txt list

cat list | while read i;do echo -ne "muscle -in {path}/01_OrthoFinder/OrthoFinder/*/Single_Copy_Orthologue_Sequences/$i.rename.fa -out $i.msa && touch ${i}_done\n" >> run.sh;done

Parafly -c run.sh -CPU 20
