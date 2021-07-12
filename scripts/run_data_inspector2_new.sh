#!/bin/bash
set -e
set -u
#set -o pipefail

cd data/

echo; echo "* Inspecting and Manipulating Text Data with Unix Tools"

# create a variable and assign it a value with (do not use spaces around the equals sign!):  
FNA=GCA_002204515.1_AaegL5.0_genomic.fna
GFF=GCA_002204515.1_AaegL5.0_genomic.gff

grep "^>" $FNA | wc -l
grep "^#" $GFF | wc -l

grep -v "^#" $GFF | head -n 3
echo; echo "* Only 1,4,5"
grep -v "^#" $GFF | cut -f1,4,5 | head -n 3
echo; echo "* rRNAカウント"
awk -F"\t" '$3 ~ /rRNA/ { print $0 }' $GFF | grep -E -o 'product=.+' | sort | uniq -c
echo; echo "* CDSの末尾"
awk -F"\t" '$3 ~ /CDS/ { print $5 - $4 "\t" $0 }' $GFF | sort -k1,1n | tail -n 1


#echo; echo "* FASTA header lines begin with the > character."
#grep "^>" $FNA

echo; echo "* Using grep, cut, sort, uniq to summarize columns of data"
#grep -v "^#" $GFF | cut -f3 | sort | uniq -c
# pipe these results to sort -rn to show these counts in order from most frequent to least
grep -v "^#" $GFF | cut -f3 | sort | uniq -c | sort -rn
echo; echo "* Inspecting Data with Head and Tail"
head -n 10 $GFF
tail -n 3 $GFF
echo; echo "* Inspecting and Manipulating Text Data with Unix Tools"
ls -lh
wc -l *
