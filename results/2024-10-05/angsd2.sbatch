#!/bin/bash
#SBATCH --job-name=angsd2
#SBATCH --output=angsd2.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=13G
#SBATCH --qos=medium
#SBATCH --time=7-00:00:00

module load anaconda
conda deactivate
mamba activate bio
module load angsd

cd /scr/joiglu/crepi/results/2024-10-05

BAM=../2024-10-04/BAM
ASM=../2024-10-04/radloci.fa

if [ ! -d Likes2 ]; then mkdir Likes2; fi
for REGION in ARCTIC; do
   if [ ! -e Sites/${REGION}_snp.sites.bin ]; then
      sed -i 's/:/\t/' Sites/${REGION}_snp.sites
      angsd sites index Sites/${REGION}_snp.sites 2> Sites/${REGION}_snp.sites.log
   fi
   if [ ! -e Sites/${REGION}_contigs.txt ]; then
      cut -f 1 Sites/${REGION}_snp.sites | sort | uniq > Sites/${REGION}_contigs.txt
   fi
   if [ ! -e Likes2/${REGION}.beagle.gz ]; then
      angsd -bam ${REGION}.list \
            -ref $ASM \
            -sites Sites/${REGION}_snp.sites \
            -rf Sites/${REGION}_contigs.txt \
            -out Likes2/${REGION} \
            -only_proper_pairs 1 \
            -baq 1 \
            -setMinDepthInd 2 \
            -GL 1 \
            -doGlf 2 \
            -doIBS 1 \
            -doCounts 1 \
            -doCov 1 \
            -makeMatrix 1 \
            -doMajorMinor 1 \
            -doMaf 1 \
            -SNP_pval 2e-10 \
            -minMapQ 30 \
            -minQ 20 \
            -minMaf 0.05 \
            -nThreads 8 \
            1> Likes2/${REGION}.angsd.log \
            2> Likes2/${REGION}.angsd.err
   fi
done

if [ ! -d PCangsd ]; then mkdir PCangsd; fi
for REGION in ARCTIC; do
   if [ ! -e PCangsd/${REGION}.cov ]; then
      pcangsd --beagle Likes2/${REGION}.beagle.gz \
              --out PCangsd/${REGION} \
              --threads 8 \
              1> PCangsd/${REGION}.stdout \
              2> PCangsd/${REGION}.stderr
   fi
done

if [ ! -d NGSadmix ]; then mkdir NGSadmix; fi
for REGION in ARCTIC; do
   for K in 2 3 4 5 6; do
      if [ ! -e NGSadmix/${REGION}.K${K}.qopt ]; then
         /home/joiglu/software/NGSTOOLS/angsd/misc/NGSadmix -likes Likes2/${REGION}.beagle.gz \
                  -K $K \
                  -P 8 \
                  -outfiles NGSadmix/${REGION}.K${K} \
                  -minMaf 0.05 \
                  -maxiter 8000 \
                  1> NGSadmix/${REGION}.NGSadmix.K${K}.log \
                  2> NGSadmix/${REGION}.NGSadmix.K${K}.err
      fi
   done
done

for REGION in ARCTIC; do
   for K in 2 3 4 5 6; do
      if [ ! -e NGSadmix/${REGION}.K${K}.eval ]; then
         evalAdmix -beagle Likes2/$REGION.beagle.gz \
                   -fname NGSadmix/$REGION.K$K.fopt.gz \
                   -qname NGSadmix/$REGION.K$K.qopt \
                   -o NGSadmix/$REGION.K$K.eval \
                   -P 8 \
                   1> NGSadmix/$REGION.K$K.eval.log \
                   2> NGSadmix/$REGION.K$K.eval.err
      fi
   done
done
