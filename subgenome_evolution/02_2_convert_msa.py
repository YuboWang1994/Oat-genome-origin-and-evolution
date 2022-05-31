#!/usr/bin/env python

import sys,os,glob
from Bio import SeqIO

files=glob.glob('%s/02_Muscle/01_run_muscle/*.msa' % sys.argv[1])
for file in files:
    list=[]
    name=file.split('/')[-1].split('.')[0]
    os.system("echo %s" % name)
    d = {}
    d1 = {}
    with open('%s/01_OrthoFinder/OrthoFinder/*/Single_Copy_Orthologue_Sequences/%s.list' % (sys.argv[1], name)) as f:
        for line in f.readlines():
            l = line.strip().split('\t')
            d[l[0]] = l[1]
    temp_cds=open('%s/02_Muscle/02_pep2cds/%s.temp' % (sys.argv[1], name),'w')
    for record in SeqIO.parse(file, "fasta"):
        id = record.id
        list.append(id)
    for record in SeqIO.parse('%s/00_data/all.cds.fasta' % sys.argv[1], "fasta"):
        gene = record.id
        seq = record.seq
        if gene in d.keys():
            if d[gene] in list:
                temp_cds.write(">" + d[gene] + "\n" + str(seq)+"\n")
    temp_cds.close()
    os.system("perl %s/pal2nal.pl " % sys.argv[1] + file + " 02_pep2cds/%s.temp -output fasta > 02_pep2cds/" % name + name+'.msa\n')
    os.system("rm 02_pep2cds/%s.temp" % name)
