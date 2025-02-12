#!/usr/bin/bash
fq1="../2023-05-12/NANO/assembly.fasta"

mitoz all --outprefix mito_pseudo \
  --thread_number 32 \
  --profiles_dir mitoz_custom_db/profiles \
  --clade Arthropoda \
  --genetic_code 5 \
  --requiring_taxa Nematoda \
  --fq1 $fq1 \
  --skip_filter 


#Old command, not work
#mitoz all --outprefix mito_pseudo --thread_number 32 --profiles_dir mitoz_custom_db/profiles --clade Arthropoda --genetic_code 21 --requiring_taxa Arthropoda --fq1 ../2023-05-12/NANO/assembly.fasta --assembler megahit --skip_filter --data_size_for_mt_assembly 0,0 --min_abundance 0 --kmers_megahit 99 119 141

