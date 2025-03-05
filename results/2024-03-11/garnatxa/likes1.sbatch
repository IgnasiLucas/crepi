#!/bin/bash
#SBATCH --job-name=likes1
#SBATCH --output=likes1.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --qos=medium
#SBATCH --time=5-00:00:00

module load anaconda
mamba activate bio
module load angsd

cd /scr/joiglu/crepi/results/2024-03-11

BAM=../2023-05-18/BAM
ASM=../2023-05-15/assembly.fasta
EXCLUDE=../2023-05-23/VeryBad.txt
GOODCTG=GoodContigs.txt

if [ ! -e ARCTIC.list ]; then
   ls -1 $BAM/*.bam | \
   grep -E "L|S" | \
   grep -v -F -f $EXCLUDE | \
   grep -v -E 'LR' > ARCTIC.list
fi

if [ ! -d Likes1 ]; then mkdir Likes1; fi
MININD=60
MINDEPTHIND=2
  if [ ! -e Likes1/ARCTIC.beagle.gz ]; then
    angsd -bam ARCTIC.list \
          -ref $ASM \
          -rf $GOODCTG \
          -out Likes1/ARCTIC \
          -only_proper_pairs 0 \
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
          1> Likes1/ARCTIC.angsd.log \
          2> Likes1/ARCTIC.angsd.err
fi
