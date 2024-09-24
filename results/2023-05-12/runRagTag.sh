#!/bin/bash

if [ ! -d RAGTAG ]; then mkdir RAGTAG; fi
if [ ! -e RAGTAG/ragtag.scaffold.fasta ]; then
   ragtag.py scaffold -u -t 32 \
      -o RAGTAG -f 1000 -w \
      PACBIO/assembly.fasta \
      ABYSS_assembly/k90-kc2/farionis-scaffolds.fa
fi
