#!/bin/bash

for kc in 2; do
	for k in `seq 70 10 140`; do
		mkdir k${k}-kc${kc}
		abyss-pe -C k${k}-kc${kc} name=farionis B=80G k=$k kc=$kc j=24 \
		in='/nata/mar/crepidostomum2/data/Shotgun_Illumina/TrueSeqCrepi_1.fastq.gz /nata/mar/crepidostomum2/data/Shotgun_Illumina/TrueSeqCrepi_2.fastq.gz'
	
	done
done
abyss-fac k*/farionis-scaffolds.fa
