#!/bin/bash
#SBATCH --job-name=denovo95
#SBATCH --output=denovo95.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=10G
#SBATCH --qos=long
#SBATCH --time=15-00:00:00

module load anaconda
mamba activate ipyrad
cd /home/joiglu/crepi/2023-05-17b

ipyrad -p params-crepi95.txt -f -s 34567 -c $SLURM_CPUS_PER_TASK 1> crepi95.log 2> crepi95.err
