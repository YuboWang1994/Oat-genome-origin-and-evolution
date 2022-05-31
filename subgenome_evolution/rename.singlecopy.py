#!/usr/bin/env python

from Bio import SeqIO
import sys

with open(sys.argv[1], 'r') as f:
	for line in f.readlines():
		name = line.strip()
		res1 = open('%s.rename.fa' % name, 'w')
		res2 = open('%s.list' % name, 'w')
		for info in SeqIO.parse('%s.fa' % name, 'fasta'):
			name1 = info.id.split('|')[0]
			res1.write('>%s|%s_%s.1\n' % (name1, name, name1))
			res1.write(str(info.seq) + '\n')
			res2.write(info.id + '\t' + '%s|%s_%s.1' % (name1, name, name1) + '\n')
		res1.close()
		res2.close()
