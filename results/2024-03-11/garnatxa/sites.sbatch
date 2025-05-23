#!/bin/bash
#SBATCH --job-name=sites
#SBATCH --output=sites.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=5G
#SBATCH --qos=short
#SBATCH --time=05:00:00

module load anaconda
mamba activate bio
module load angsd

cd /scr/joiglu/crepi/results/2024-03-11

ASM=../2023-05-15/assembly.fasta
MININD=60
MINDEPTHIND=2

if [ ! -d Likes2 ]; then mkdir Likes2; fi
if [ ! -d Sites ]; then mkdir Sites; fi

if [ ! -e Likes2/ARCTIC.beagle.gz ]; then
   if [ ! -e Sites/ARCTIC_snp.sites ]; then
      if [ ! -e Sites/ARCTIC_snp.ld ]; then
         gunzip -c Likes1/ARCTIC.mafs.gz | \
         cut -f 1,2 | \
         tail -n +2 > Sites/posFile.txt
         ngsLD --geno Likes1/ARCTIC.beagle.gz \
               --probs \
               --pos Sites/posFile.txt \
               --n_ind $(cat ARCTIC.list | wc -l) \
               --n_sites $(cat Sites/posFile.txt | wc -l) \
               --n_threads 8 \
               --out Sites/ARCTIC_snp.ld \
               1> Sites/ngsLD.ARCTIC.log \
               2> Sites/ngsLD.ARCTIC.err
         head -n 1 Sites/ARCTIC_snp.ld > Sites/ARCTIC_snp.ld.header
         tail -n +2 Sites/ARCTIC_snp.ld > z
         mv z Sites/ARCTIC_snp.ld
         rm Sites/posFile.txt
      fi
      ~/software/NGSTOOLS/ngsLD/scripts/prune_ngsLD.py \
                     --input Sites/ARCTIC_snp.ld \
                     --output Sites/ARCTIC_snp.sites \
                     --max_dist 100000 \
                     --min_weight 0.85
   fi
   if [ ! -e Sites/ARCTIC_snp.sites.bin ]; then
      sed -i 's/:/\t/' Sites/ARCTIC_snp.sites
      angsd sites index Sites/ARCTIC_snp.sites 2> Sites/ARCTIC_snp.sites.log
   fi
   angsd -bam ARCTIC.list \
         -ref $ASM \
         -sites Sites/ARCTIC_snp.sites \
         -out Likes2/ARCTIC \
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
         -SNP_pval 1.0e-6 \
         -minMapQ 30 \
         -minQ 20 \
         -minMaf 0.05 \
         -nThreads 8 \
         1> Likes2/ARCTIC.angsd.log \
         2> Likes2/ARCTIC.angsd.err
fi
