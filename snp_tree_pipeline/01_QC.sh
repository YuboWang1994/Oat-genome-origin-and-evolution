mkdir -p {path}/{sample}/fastq

cd {path}/{sample}/fastq

ln -s {path}/00_data/{sample}.R1.fastq.gz .

ln -s {path}/00_data/{sample}.R2.fastq.gz .

fastp -i {sample}.R1.fastq.gz -o {sample}.clean.R1.fastq.gz -I {sample}.R2.fastq.gz -O {sample}.clean.R2.fastq.gz -j {sample}.qc.json -h {sample}.qc.html -R {sample} -w 4
