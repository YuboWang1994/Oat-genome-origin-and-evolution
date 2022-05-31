mkdir -p {path}/05_Raxml/03_4DTv

cd {path}/05_Raxml/03_4DTv

raxmlHPC-PTHREADS-AVX -s {path}/04_Supergene/03_4DTv/4DTv.fa.phylip -n 4D -T 48 -m GTRGAMMAI -N 100 -f a -k -d -p 12345 -x 12345
