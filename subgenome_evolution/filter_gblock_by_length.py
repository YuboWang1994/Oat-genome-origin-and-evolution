#!/usr/bin/env python

from Bio import SeqIO
import sys

with open('muscle.list') as f:
	for line in f.readlines():
		i = line.strip()
		for info in SeqIO.parse(i, 'fasta'):
			l = len(str(info.seq))
			if l >= int(sys.argv[1]):
				print(i)
				break
