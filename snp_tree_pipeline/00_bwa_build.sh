# Each subgenome of hexaploid oat

mkdir -p {path}/00_genome/ACD/A_index
cd {path}/00_genome/ACD/A_index
ln -s {path}/genome/ACD/A.fa
bwa index A.fa

mkdir -p {path}/00_genome/ACD/C_index
cd {path}/00_genome/ACD/C_index
ln -s {path}/genome/ACD/C.fa .
bwa index C.fa

mkdir -p {path}/00_genome/ACD/D_index
cd {path}/00_genome/ACD/D_index
ln -s {path}/genome/ACD/D.fa .
bwa index D.fa


# The whole hexaploid oat

mkdir -p {path}/00_genome/ACD/ACD_index
cd {path}/00_genome/ACD/ACD_index
ln -s {path}/genome/ACD/ACD.fa .
bwa index ACD.fa


# Each subgenome of tetraploid oat

mkdir -p {path}/00_genome/CD/C_index
cd {path}/00_genome/CD/C_index
ln -s {path}/genome/CD/C.fa .
bwa index C.fa

mkdir -p {path}/00_genome/CD/D_index
cd {path}/00_genome/CD/D_index
ln -s {path}/genome/CD/D.fa .
bwa index D.fa


# The whole tetraploid oat

mkdir -p {path}/00_genome/CD/CD_index
cd {path}/00_genome/CD/CD_index
ln -s {path}/genome/CD/CD.fa .
bwa index CD.fa
