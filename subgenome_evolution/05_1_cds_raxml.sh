mkdir -p {path}/05_Raxml/01_cds

cd {path}/05_Raxml/01_cds

raxmlHPC-PTHREADS-AVX -s {path}/04_Supergene/01_cds/SingleCopy.groups.CDS.abbr.phylip -n cds -T 48 -m GTRGAMMAI -N 100 -f a -k -d -p 12345 -x 12345
