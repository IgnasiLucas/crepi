#!/usr/bin/bash
PATHFQ=/nata/joiglu/crepidostomum2/results/2023-05-17/crepi_edits

for REF in COI_MW_Cfar COI_OL_Cfar COI_Cfar COI_Cpse lsrDNA_MT_Cfar lsrDNA_MW_Cfar lsrDNA_OP_Cpse lsrDNA_MT_Cpse ITS2_MT_Cfar ITS2_MT_Cpse; do
  if [ ! -d BAM_$REF ]; then mkdir BAM_$REF; fi
  if [ ! -e markers/$REF.0123 ]; then
     bwa-mem2 index markers/${REF}.fa
  fi

  #bwa-mem2 index $COX
  for i in $(ls $PATHFQ/*.trimmed_R1_.fastq.gz); do
     SAMPLE=$(basename $i .trimmed_R1_.fastq.gz)
     if [ ! -e BAM_$REF/${SAMPLE}.bam ]; then
        if [ ! -e BAM_$REF/${SAMPLE}.sam ]; then
           # I skip "pairing" (-P) and avoid "mate rescue" (-S), to map forward
           # and reverse reads independently.
           bwa-mem2 mem -t 24 -P -S markers/${REF}.fa ${PATHFQ}/${SAMPLE}.trimmed_R1_.fastq.gz \
                                   ${PATHFQ}/${SAMPLE}.trimmed_R2_.fastq.gz \
                        -R "@RG\tID:${SAMPLE}\tSM:${SAMPLE}" > BAM_$REF/${SAMPLE}.sam &
        fi
        wait
        # We expect very few reads to map on cox1 or lsrDNA, and don't need to
        # save the rest in the bam. Thus, I filter the umapped reads.
        samtools view -q 20 -F 4 -u BAM_$REF/${SAMPLE}.sam | \
        samtools sort > BAM_$REF/${SAMPLE}.bam
        samtools index BAM_$REF/${SAMPLE}.bam
        rm BAM_$REF/${SAMPLE}.sam
     fi
  done
done
