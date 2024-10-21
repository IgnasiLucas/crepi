#!/bin/bash
#SBATCH --job-name=angsd2
#SBATCH --output=angsd2.log
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=8
#SBATCH --mem=5G
#SBATCH --qos=short
#SBATCH --time=1-00:00:00

if [ ! $HOSTNAME == thermomix ]; then
   module load anaconda
   mamba activate bio
   module load angsd
fi

cd /scr/joiglu/crepi/2024-10-18

if [ ! -d Likes2 ]; then mkdir Likes2; fi
if [ ! -e Sites.txt.bin ]; then
   angsd sites index Sites.txt 2> Sites.log
fi
if [ ! -e contigs.txt ]; then
   cut -f 1 Sites.txt | sort | uniq > contigs.txt
fi
if [ ! -e Likes2/ARCTIC.beagle.gz ]; then
   angsd -bam ARCTIC.list \
         -ref radloci.fa \
         -sites Sites.txt \
         -rf contigs.txt \
         -out Likes2/ARCTIC \
         -only_proper_pairs 1 \
         -baq 1 \
         -setMinDepth 20 \
         -GL 2 \
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
         1> Likes2/REGION.angsd.log \
         2> Likes2/REGION.angsd.err
fi

if [ ! -d PCangsd ]; then mkdir PCangsd; fi
if [ ! -e PCangsd/ARCTIC.cov ]; then
   pcangsd --beagle Likes2/ARCTIC.beagle.gz \
           --out PCangsd/ARCTIC \
           --threads 8 \
           1> PCangsd/pcangsd.stdout \
           2> PCangsd/pcangsd.stderr
fi

if [ ! -d NGSadmix ]; then mkdir NGSadmix; fi
if [ ! $HOSTNAME == thermomix ]; then
   NGSADMIX=/home/joiglu/software/NGSTOOLS/angsd/misc/NGSadmix
else
   NGSADMIX=$(which NGSadmix)
fi
for K in 2 3; do
   if [ ! -e NGSadmix/K$K.qopt ]; then
      $NGSADMIX -likes Likes2/ARCTIC.beagle.gz \
               -K $K \
               -P 8 \
               -outfiles NGSadmix/K$K \
               -minMaf 0.05 \
               -maxiter 8000 \
               1> NGSadmix/K$K.log \
               2> NGSadmix/K$K.err &
   fi
done
wait

for K in 2 3; do
   if [ ! -e NGSadmix/K$K.eval ]; then
      evalAdmix -beagle Likes2/ARCTIC.beagle.gz \
                -fname NGSadmix/K$K.fopt.gz \
                -qname NGSadmix/K$K.qopt \
                -o NGSadmix/K$K.eval \
                1> NGSadmix/K$K.eval.log \
                2> NGSadmix/K$K.eval.err &
   fi
done
wait
