#!/bin/bash
# This creates a table comparable to that in 2023-05-18/summary_mapping.txt, and just
# as wrong as that. They are "wrong" because the "TOTAL" number of reads is actually
# the number of read *pairs*, not individual reads. Thus, it should be multiplied by 2.

if [ ! -e summary_mapping.txt ]; then
   echo -e "Sample\tTotal\tMapped" > summary_mapping.txt
   for bam in $(ls -1 BAM/*.bam); do
      SAMPLE=$(basename -s .bam $bam)
      TOTAL=$(grep $SAMPLE ../2023-05-17/crepi_edits/s2_rawedit_stats.txt | gawk '{print $9}')
      MAPPED=$(samtools view -u -q 20 $bam | samtools flagstats - | grep "primary mapped" | cut -d " " -f 1)
      echo -e "$SAMPLE\t$TOTAL\t$MAPPED" >> summary_mapping.txt
   done
fi
