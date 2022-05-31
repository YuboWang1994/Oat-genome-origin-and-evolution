from Bio import SeqIO

for info in SeqIO.parse('SingleCopy.groups.abbr.fasta', 'fasta'):
	print('%s\t%d' % (info.id, len(str(info.seq))))
