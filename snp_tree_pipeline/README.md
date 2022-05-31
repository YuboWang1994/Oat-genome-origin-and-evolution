# Snp tree pipeline

For diploid species, the cleaned reads were mapped to the A, C, and D subgenomes of the ‘Sanfensan’ reference genome, and uniquely mapped reads were retained for variant calling. 

For the CD-genome tetraploid and ACD-genome hexaploid accessions, the cleaned reads were first mapped against the tetraploid A. insularis (CD) and hexaploid ‘Sanfensan’ (ACD) reference genomes using the BWA program with the default settings, and the reads that mapped uniquely to each subgenome were retrieved based on the BAM files. These subgenome-specific reads were then re-mapped onto the three ‘Sanfensan’ subgenomes.
