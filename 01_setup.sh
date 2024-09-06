# define main working directory
workdir=/lustre/scratch/jmanthey/02_zj/

# make output directories
cd ${workdir}

mkdir 00_fastq
mkdir 01_cleaned
mkdir 01_bam_files
mkdir 02_vcf
mkdir 03_vcf
mkdir 04_vcf
mkdir 05_pca
mkdir 06_window
mkdir 06_window/windows
mkdir 10_filter
mkdir 11_filter_vcf


# index the reference for several programs
interactive -p nocona -c 4 -m 8G

cd references

source activate bcftools

bwa-mem2 index GCA_017612475.1_CCG_JAWE_1.0_genomic.fna

samtools faidx GCA_017612475.1_CCG_JAWE_1.0_genomic.fna

java -jar picard.jar CreateSequenceDictionary \
R=/home/jmanthey/references/GCA_017612475.1_CCG_JAWE_1.0_genomic.fna \
O=/home/jmanthey/references/GCA_017612475.1_CCG_JAWE_1.0_genomic.dict
