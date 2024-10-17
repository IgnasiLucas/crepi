#!/bin/bash
#SBATCH --job-name=2DSFS
#SBATCH --output=2DSFS.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=1G
#SBATCH --qos=short
#SBATCH --time=02:00:00

module load anaconda
module load angsd
mamba activate bio

cd /scr/joiglu/crepi/2024-10-10

if [ ! -d 2D_SFS ]; then mkdir 2D_SFS; fi
# Not in alphabetic order!
POPS=(Langfjordvatn.f.sp1 Langfjordvatn.m.sp1 Langfjordvatn Suopatjavri.f.sp2 Suopatjavri.m.sp2 Suopatjavri)
for j in $(seq 1 $(( ${#POPS[@]} - 1)) ); do
   for i in $(seq 0 $(( j - 1 )) ); do
      if [ ! -e 2D_SFS/${POPS[i]}.${POPS[j]}.ml ]; then
         /home/joiglu/software/NGSTOOLS/angsd/misc/realSFS -cores 8 \
                 -fold 1 \
                 -nSites 5000000 \
                 SAF/${POPS[i]}.saf.idx \
                 SAF/${POPS[j]}.saf.idx \
                 1> 2D_SFS/${POPS[i]}.${POPS[j]}.ml \
                 2> 2D_SFS/${POPS[i]}.${POPS[j]}.err
      fi
   done
done

if [ ! -d FST ]; then mkdir FST; fi
for j in $(seq 1 $(( ${#POPS[@]} - 1 )) ); do
   for i in $(seq 0 $(( j - 1 )) ); do
      if [ ! -e FST/${POPS[i]}.${POPS[j]}.fst.idx ]; then
         /home/joiglu/software/NGSTOOLS/angsd/misc/realSFS fst index \
                 SAF/${POPS[i]}.saf.idx \
                 SAF/${POPS[j]}.saf.idx \
                 -sfs 2D_SFS/${POPS[i]}.${POPS[j]}.ml \
                 -fstout FST/${POPS[i]}.${POPS[j]} \
                 -whichFst 1 \
                 -cores 8 \
                 1> FST/${POPS[i]}.${POPS[j]}.log \
                 2> FST/${POPS[i]}.${POPS[j]}.err
      fi
   done
done
 
