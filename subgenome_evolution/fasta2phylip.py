from Bio import SeqIO
import sys

print(' %s %s' % (sys.argv[1], sys.argv[2]))

for info in SeqIO.parse('SingleCopy.groups.CDS.abbr.fasta', 'fasta'):
	n = len(info.id)
	num_n = 30-n
	print(info.id + ' ' + str(info.seq))


