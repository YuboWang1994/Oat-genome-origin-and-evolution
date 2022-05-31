mkdir -p {path}/04_Supergene/03_4DTv

cd {path}/04_Supergene/03_4DTv

mkdir -p 01.4DTVsite 02.4DTVbase

ln -s {path}/01_OrthoFinder/OrthoFinder/*/Orthogroups/Orthogroups_SingleCopyOrthologues.txt list

cat list | while read i;do echo -ne "perl {path}/find4dtvsite.pl {path}/02_Muscle/01_run_muscle/$i.msa ./01.4DTVsite/$i.site && perl {path}/get4dtvbase.pl {path}/02_Muscle/02_pep2cds/$i.msa ./01.4DTVsite/$i.site ./02.4DTVbase/$i.base\n" >> run.sh;done

Parafly -c run.sh -CPU 20

perl {path}/link.base.pl > linked.base.fa

perl {path}/rm.miss.link.base.pl linked.base.fa 4DTv.fa

python {path}/count_length.py 4DTv.fa > length.txt

python {path}/fasta2phylip.py 4DTv.fa {species_number} {4DTv_base_number} > 4DTv.fa.phylip        # 4DTv_base_number can be found in the length.txt file
