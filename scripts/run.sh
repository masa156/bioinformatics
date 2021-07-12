#!/bin/bash
set -euo pipefail

echo; echo "[$(date)] $0 job has been started."

echo; echo "# Creating directories"
mkdir -p {analysis/$(date +%F),data/$(date +%F),scripts}
cd data/$(date +%F)/

echo; echo "# Downloading data"
# Aedes aegypti
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/204/515/GCA_002204515.1_AaegL5.0/GCA_002204515.1_AaegL5.0_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/204/515/GCA_002204515.1_AaegL5.0/GCA_002204515.1_AaegL5.0_genomic.gff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/204/515/GCA_002204515.1_AaegL5.0/md5checksums.txt

echo; echo "# MD5 checksum"
md5 *.gz
grep "_genomic.fna.gz" *md5checksums.txt
grep "_genomic.gff.gz" *md5checksums.txt

# decompress files with the command gunzip:
gunzip *.gz

# Inspecting and Manipulating Text Data with Unix Tools
date > ../../analysis/$(date +%F)/output.txt

# create a variable and assign it a value with (do not use spaces around the equals sign!):  
FNA=GCA_002204515.1_AaegL5.0_genomic.fna
GFF=GCA_002204515.1_AaegL5.0_genomic.gff

# FASTA header lines begin with the > character.
grep "^>" $FNA >> ../../analysis/$(date +%F)/output.txt

# Using grep, cut, sort, uniq to summarize columns of data
grep -v "^#" $GFF | cut -f3 | sort | uniq -c >> ../../analysis/$(date +%F)/output.txt

echo; echo "# Print operating system characteristics"
uname -a
sw_vers

# Done
echo; echo "[$(date)] $0 has been successfully completed."
