#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1 --ntasks=1
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-120

# define input files from helper file during genotyping
input_array=$( head -n${SLURM_ARRAY_TASK_ID} helper6.txt | tail -n1 )

# define main working directory
workdir=/lustre/scratch/jmanthey/38_zjaponicus

# run vcftools with SNP output spaced 1kbp
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf --remove-indv Zosterops_japonicus_Guizhou_11220 --max-missing 1.0 --minQ 20 --minGQ 20 --minDP 6 --max-meanDP 50 --min-alleles 2 --max-alleles 2 --mac 1 --thin 1000 --max-maf 0.49 --remove-indels --recode --recode-INFO-all --out ${workdir}/04_filtered_vcf_1kbp/${input_array}
