#!/bin/bash

ASM=../../data/RefGenomes/farionis-scaffolds.fa
PATHFQ=../2023-05-17/crepi_edits

if [ ! -d BAM ]; then mkdir BAM; fi
if [ ! -e ${ASM}.0123 ]; then
   bwa-mem2 index $ASM
fi

for i in $(ls $PATHFQ/*.trimmed_R1_.fastq.gz); do
   SAMPLE=$(basename $i .trimmed_R1_.fastq.gz)
   if [ ! -e BAM/${SAMPLE}.bam ]; then
      if [ ! -e BAM/${SAMPLE}_on_ref.sam ]; then
         bwa-mem2 mem -t 24 $ASM ${PATHFQ}/${SAMPLE}.trimmed_R1_.fastq.gz \
                                 ${PATHFQ}/${SAMPLE}.trimmed_R2_.fastq.gz \
                 -R "@RG\tID:${SAMPLE}\tSM:${SAMPLE}" > BAM/${SAMPLE}_on_ref.sam
      fi
      samtools sort BAM/${SAMPLE}_on_ref.sam -o BAM/temp_sorted.bam
      samtools view -b -F 4 -q 20 BAM/temp_sorted.bam > BAM/${SAMPLE}.bam
      #rm BAM/temp_sorted.bam
   fi
   if [ ! -e BAM/${SAMPLE}.bam.bai ]; then
      samtools index BAM/${SAMPLE}.bam
   fi
done