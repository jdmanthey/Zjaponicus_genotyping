#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter2
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-131

source activate bcftools

# define main working directory
workdir=/lustre/scratch/jmanthey/02_zj

# define variables
region_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/scaffolds.txt | tail -n1 )

# filter for stats (no outgroup)
vcftools --vcf ${workdir}/04_vcf/${region_array}.vcf --keep ingroup.txt \
--max-missing 0.9 --max-alleles 2 --max-maf 0.49 --recode \
--recode-INFO-all --out ${workdir}/06_window/${region_array}

# zip and index
bgzip ${workdir}/06_window/${region_array}.recode.vcf

tabix ${workdir}/06_window/${region_array}.recode.vcf.gz
