# move all fastq to current directory
find . -name '*fastq.gz' -print0 | xargs -0 -I '{}' mv "{}" .

# rename the files
while read -r name1 name2; do
	mv $name1 $name2
done < rename_fq.txt

# make sure the reference genome is indexed
cd /lustre/work/jmanthey/zosterops_genome/
samtools faidx ref.fa
bwa index ref.fa
cd ~
java -jar picard.jar CreateSequenceDictionary R=/lustre/work/jmanthey/zosterops_genome/ref.fa O=/lustre/work/jmanthey/zosterops_genome/ref.dict

