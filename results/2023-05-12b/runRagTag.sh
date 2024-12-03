#!/bin/bash

if [ ! -d RAGTAG ]; then mkdir RAGTAG; fi
if [ ! -e RAGTAG/all/ragtag.scaffold.fasta ]; then
   ragtag.py scaffold -u -t 32 \
      -o RAGTAG/all/ -f 1000 -w \
      PACBIO/assembly.fasta \
      ABYSS_assembly/k90-kc2/farionis-scaffolds.fa
fi
