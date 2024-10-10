#!/bin/bash
#SBATCH --job-name=angsd1
#SBATCH --output=angsd1.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G
#SBATCH --qos=medium
#SBATCH --time=2-00:00:00

module load anaconda
mamba activate bio
module load angsd

cd /scr/joiglu/crepi/2024-10-05

BAM=BAM
ASM=radloci.fa
EXCLUDE=BadGuys.txt
GOODLOCI=GoodLoci.txt

if [ ! -e ARCTIC.list ]; then
   ls -1 $BAM/*.bam | grep -E "L|S" | grep -v -F -f $EXCLUDE > ARCTIC.list
fi

if [ ! -d Likes1 ]; then mkdir Likes1; fi
for REGION in ARCTIC; do
   MININD=$(( $(cat $REGION.list | wc -l) / 2))
   if [ ! -e Likes1/${REGION}.beagle.gz ]; then
      angsd -bam ${REGION}.list \
            -ref $ASM \
            -rf $GOODLOCI \
            -out Likes1/${REGION} \
            -only_proper_pairs 1 \
            -baq 1 \
            -setMinDepth 20 \
            -minInd $MININD \
            -GL 2 \
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
            2> Likes1/${REGION}.angsd.err &
   fi
done
wait

if [ ! -d Sites ]; then mkdir Sites; fi

for REGION in ARCTIC; do
   if [ ! -e Sites/${REGION}_snp.sites ]; then
      if [ ! -e Sites/${REGION}_snp.ld ]; then
         gunzip -c Likes1/${REGION}.mafs.gz | cut -f 1,2 | tail -n +2 > Sites/posFile.txt
         ngsLD --geno Likes1/${REGION}.beagle.gz \
               --probs \
               --pos Sites/posFile.txt \
               --n_ind $(cat $REGION.list | wc -l) \
               --n_sites $(cat Sites/posFile.txt | wc -l) \
               --n_threads 8 \
               --out Sites/${REGION}_snp.ld 1> Sites/ngsLD.$REGION.log 2> Sites/ngsLD.$REGION.err
         head -n  1 Sites/${REGION}_snp.ld > Sites/${REGION}_snp.ld.header
         tail -n +2 Sites/${REGION}_snp.ld > z
         mv z Sites/${REGION}_snp.ld
         rm Sites/posFile.txt
      fi
      /home/joiglu/software/NGSTOOLS/ngsLD/scripts/prune_ngsLD.py \
         --input  Sites/${REGION}_snp.ld \
         --output Sites/${REGION}_snp.sites \
         --max_dist 100000 \
         --min_weight 0.85 &
   fi
done
wait
