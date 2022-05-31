#!/usr/bin/env python

import sys
from Bio import SeqIO

with open(sys.argv[1], 'r') as f:
    res = open('%s.fa' % sys.argv[1], 'w')
    for line in f.readlines():
        species_name = line.strip()
        for info in SeqIO.parse('%s/%s.pep.fa' % (sys.argv[2], sys.argv[1]), 'fasta'):
            res.write('>%s|%s\n' % (sys.argv[1], info.id))
            res.write(str(info.seq) + '\n')
        res.close()
