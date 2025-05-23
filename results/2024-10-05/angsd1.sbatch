#!/bin/bash
#SBATCH --job-name=angsd1
#SBATCH --output=angsd1.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=15G
#SBATCH --qos=medium
#SBATCH --time=7-00:00:00

module load anaconda
mamba activate bio
module load angsd

cd /scr/joiglu/crepi/results/2024-10-05

BAM=../2024-10-04/BAM
ASM=../2024-10-04/radloci.fa
EXCLUDE=../2024-10-04/BadGuys.txt
GOODLOCI=../2024-10-04/GoodLoci.txt

if [ ! -e ARCTIC.list ]; then
   ls -1 $BAM/*.bam | grep -E "L|S" | grep -v -F -f $EXCLUDE > ARCTIC.list
fi

if [ ! -d Likes1 ]; then mkdir Likes1; fi
MININD=60
MINDEPTHIND=2
for REGION in ARCTIC; do
   if [ ! -e Likes1/${REGION}.beagle.gz ]; then
      angsd -bam ${REGION}.list \
            -ref $ASM \
            -rf $GOODLOCI \
            -out Likes1/${REGION} \
            -only_proper_pairs 1 \
            -baq 1 \
            -setMinDepthInd $MINDEPTHIND \
            -minInd $MININD \
            -GL 1 \
            -doGlf 2 \
            -doIBS 1 \
            -doCounts 1 \
            -doCov 1 \
            -makeMatrix 1 \
            -doMajorMinor 1 \
            -doMaf 1 \
            -SNP_pval 1e-6 \
            -minMapQ 30 \
            -minQ 20 \
            -minMaf 0.05 \
            -nThreads 8 \
            1> Likes1/${REGION}.angsd.log \
            2> Likes1/${REGION}.angsd.err
   fi
done
