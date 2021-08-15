for i in $( ls slurm* ); do
echo $i;
head -n1 $i;
grep "Input:" $i;
grep "Result:" $i
done
