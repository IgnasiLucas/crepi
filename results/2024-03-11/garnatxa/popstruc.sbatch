#!/bin/bash
#SBATCH --job-name=popstruc
#SBATCH --output=popstruc.log
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

if [ ! -d PCangsd ]; then mkdir PCangsd; fi
if [ ! -e PCangsd/ARCTIC.cov ]; then
   pcangsd --beagle Likes2/ARCTIC.beagle.gz \
           --out PCangsd/ARCTIC \
           --threads 8 \
           1> PCangsd/ARCTIC.stdout \
           2> PCangsd/ARCTIC.stderr
fi

if [ ! -d NGSadmix ]; then mkdir NGSadmix; fi
for K in 2 3 4 5; do
   if [ ! -e NGSadmix/ARCTIC.K${K}.qopt ]; then
      ~/software/NGSTOOLS/angsd/misc/NGSadmix \
               -likes Likes2/ARCTIC.beagle.gz \
               -K $K \
               -P 8 \
               -outfiles NGSadmix/ARCTIC.K${K} \
               -minMaf 0.05 \
               -maxiter 8000 \
               1> NGSadmix/ARCTIC.NGSadmix.K${K}.log \
               2> NGSadmix/ARCTIC.NGSadmix.K${K}.err
   fi
done

for K in 2 3 4 5; do
   if [ ! -e NGSadmix/ARCTIC.K${K}.eval ]; then
      evalAdmix -beagle Likes2/ARCTIC.beagle.gz \
                -fname NGSadmix/ARCTIC.K${K}.fopt.gz \
                -qname NGSadmix/ARCTIC.K${K}.qopt \
                -o NGSadmix/ARCTIC.K${K}.eval &
   fi
done
