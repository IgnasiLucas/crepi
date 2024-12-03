#!/usr/bin/bash

## Assembly with nanopore data, matched as Crepidostomum pseudofarionis
### Error with the first assembly: nano-raw was for pre-guppy processing, 
### while nano-hq is for post-guppy processing 
NANO='../2023-04-19/CRP/*.fastq'
OUT='NANO'
if [ ! -e ./NANO/assembly.fasta ]; then 
  flye --nano-hq $NANO -o $OUT/ -t 24 --iterations 10 --resume-from polishing
fi 

DRAFT='./NANO/assembly.fasta'
if [ ! -d ./NANO/BUSCO ];then
  busco -i $DRAFT -l metazoa_odb10 --download_path ./BASE_BUSCO -o ./NANO/BUSCO -m genome --cpu 24
fi
