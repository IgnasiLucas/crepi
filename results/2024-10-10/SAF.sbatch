#!/bin/bash
#SBATCH --job-name=SFS
#SBATCH --output=SFS.log
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=4
#SBATCH --mem=15G
#SBATCH --qos=medium
#SBATCH --time=5-00:00:00

module load anaconda
module load angsd
mamba activate bio

cd /scr/joiglu/crepi/results/2024-10-10

ASM=../2024-10-04/radloci.fa

if [ ! -d SAF ]; then mkdir SAF; fi
for pop in $(ls -1 *.list); do
   NUMIND=$(cat $pop | wc -l)
   NAME=$(basename -s .list $pop)
   if [ ! -e SAF/$NAME.saf.idx ]; then
      angsd -b $pop \
            -anc $ASM \
            -ref $ASM \
            -out SAF/$NAME \
            -doSaf 1 \
            -gl 1 \
            -minMapQ 30 \
            -minQ 20 \
            -only_proper_pairs 1 \
            -baq 1 \
            -minInd $NUMIND \
            -setMinDepthInd 1 \
            -nThreads 4 1> SAF/$NAME.log 2> SAF/$NAME.err &
   fi
done
wait

if [ ! -d SFS ]; then mkdir SFS; fi
for pop in $(ls -1 *.list); do
   NAME=$(basename -s .list $pop)
   if [ ! -e SFS/$NAME.sfs ]; then
      /home/joiglu/software/NGSTOOLS/angsd/misc/realSFS \
              -fold 1 \
              -nSites 5000000 \
              SAF/$NAME.saf.idx 1> SFS/$NAME.sfs 2> SFS/$NAME.log &
   fi
done
wait

for pop in $(ls -1 *.list); do
   if [ $(cat SFS/$NAME.sfs | wc -l) -gt 1 ]; then
      mv SFS/$NAME.sfs SFS/$NAME.sfs_multiple
      tail -n 1 SFS/$NAME.sfs_multiple > SFS/$NAME.sfs
   fi
done

