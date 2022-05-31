from Bio import SeqIO

with open('species.txt') as f:
	for line in f.readlines():
		sn = line.strip()
		s = ''
		res = open('%s.fa' % sn, 'w')
		with open('filtered.muscle.list') as f1:
			for line1 in f1.readlines():
				i = line1.strip()
				for info in SeqIO.parse(i, 'fasta'):
					if sn in info.id:
						s += str(info.seq)
						break
					else:
						continue
		res.write('>%s\n' % sn)
		res.write('%s\n' % s)
		res.close()

