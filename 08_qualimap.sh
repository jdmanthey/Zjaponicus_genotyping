#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=qualimap
#SBATCH --partition nocona
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --array=1-26

source activate bcftools

bamfile=$( head -n${SLURM_ARRAY_TASK_ID} bam_list.txt | tail -n1 )

qualimap bamqc --java-mem-size=44G -nt 12 -bam ${bamfile}


