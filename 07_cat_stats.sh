# interactive job

# in windows directory

# combine the output for different analyses into a single file each
# first add a header for each file 
grep 'pop1' JABUOJ010000001.1__10000001__10100000__stats.txt > ../window_heterozygosity.txt
grep 'pop1' JABUOJ010000001.1__10000001__10100000__stats.txt > ../window_pi.txt
grep 'pop1' JABUOJ010000001.1__10000001__10100000__stats.txt > ../window_fst.txt
grep 'pop1' JABUOJ010000001.1__10000001__10100000__stats.txt > ../window_private.txt
grep 'pop1' JABUOJ010000001.1__10000001__10100000__stats.txt > ../window_shared.txt
grep 'pop1' JABUOJ010000001.1__10000001__10100000__stats.txt > ../window_fixed.txt


# add the relevant stats to each file 
for i in $( ls *stats.txt ); do grep 'heterozygosity' $i >> ../window_heterozygosity.txt; done
for i in $( ls *stats.txt ); do grep 'pi' $i >> ../window_pi.txt; done
for i in $( ls *stats.txt ); do grep 'Fst' $i >> ../window_fst.txt; done
for i in $( ls *stats.txt ); do grep 'private' $i >> ../window_private.txt; done
for i in $( ls *stats.txt ); do grep 'shared' $i >> ../window_shared.txt; done
for i in $( ls *stats.txt ); do grep 'fixed' $i >> ../window_fixed.txt; done


