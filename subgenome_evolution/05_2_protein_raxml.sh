mkdir -p {path}/05_Raxml/02_pep

cd {path}/05_Raxml/02_pep

raxmlHPC-PTHREADS-AVX -f a -x 12345 -p 12345 -# 1000 -m PROTGAMMALGX -s {path}/04_Supergene/02_pep/SingleCopy.groups.PEP.abbr.phylip -n pep -T 48
