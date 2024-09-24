#!/usr/bin/bash

## Assembly with nanopore data, matched as Crepidostomum pseudofarionis
### Error with the first assembly: nano-raw was for pre-guppy processing,
### while nano-hq is for post-guppy processing
PACBIO='../../data/PacBio/fastqs/demultiplex.bc1018_BAK8B_OA--bc1018_BAK8B_OA.hifi_reads.fastq'
OUT='PACBIO'
if [ ! -e ./PACBIO/assembly.fasta ]; then
  flye --pacbio-hifi $PACBIO -o $OUT/ -t 24 --iterations 10
fi

DRAFT='./PACBIO/assembly.fasta'
if [ ! -d ./PACBIO/BUSCO ];then
  busco -i $DRAFT -l metazoa_odb10 --download_path ./BASE_BUSCO -o ./PACBIO/BUSCO -m genome --cpu 24
fi
