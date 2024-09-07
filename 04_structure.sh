interactive -p nocona -c 4 -m 8G

source activate bcftools

workdir=/lustre/scratch/jmanthey/02_zj

cd ${workdir}/05_pca


##########################################
##########################################
### cat all individual scaffolds together
##########################################
##########################################

grep "^#" structure_JABUOJ010000351.1.recode.vcf > structure.vcf

for i in $( ls structure_*.recode.vcf ); do grep -v "^#" $i >> structure.vcf; done

grep "^#" phydist_JABUOJ010000351.1.recode.vcf > phydist.vcf

for i in $( ls phydist_*.recode.vcf ); do grep -v "^#" $i >> phydist.vcf; done

##########################################
##########################################
### remove all individual scaffold files
##########################################
##########################################

rm structure_*.recode.vcf

rm phydist_*.recode.vcf

##########################################
##########################################
### thin for 5 kbp separation between SNPs for PCA
##########################################
##########################################

vcftools --vcf structure.vcf --max-missing 1.0 --thin 5000 --recode --recode-INFO-all --out structure

vcftools --vcf phydist.vcf --max-missing 1.0 --thin 5000 --recode --recode-INFO-all --out phydist

##########################################
##########################################
### run plink for pca
### and run ADMIXTURE
##########################################
##########################################

# make chromosome map for this vcf
grep -v "#" structure.recode.vcf | cut -f 1 | uniq | awk '{print $0"\t"$0}' > chrom_map.txt

#plink output format
vcftools --vcf structure.recode.vcf  --plink --chrom-map chrom_map.txt --out structure 

# convert  with plink
plink --file structure --recode12 --allow-extra-chr \
--out structure_plink

# run pca on dataset
plink --file structure_plink --pca --allow-extra-chr \
--out structure_plink_pca

# convert with plink for admixture dataset
plink --file structure --recode12 --allow-extra-chr --out admixture_plink

# run admixture
for K in 1 2 3 4 5; do admixture --cv admixture_plink.ped $K  | tee log_${K}.out; done
