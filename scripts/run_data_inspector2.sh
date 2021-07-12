#!/bin/bash
set -e
set -u
#set -o pipefail

cd data/

echo; echo "* Inspecting and Manipulating Text Data with Unix Tools"

# create a variable and assign it a value with (do not use spaces around the equals sign!):  
FNA=GCA_002204515.1_AaegL5.0_genomic.fna
GFF=GCA_002204515.1_AaegL5.0_genomic.gff

echo; echo "* FASTA header lines begin with the > character."
grep "^>" $FNA

echo; echo "* Inspecting Data with Head and Tail"
head -n 10 $GFF
tail -n 3 $GFF

echo; echo "* Using grep, cut, sort, uniq to summarize columns of data"
#grep -v "^#" $GFF | cut -f3 | sort | uniq -c
# pipe these results to sort -rn to show these counts in order from most frequent to least
grep -v "^#" $GFF | cut -f3 | sort | uniq -c | sort -rn
