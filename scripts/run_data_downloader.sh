#!/bin/bash
set -e
set -u
set -o pipefail

echo; echo "[$(date)] $0 job has been started."

# Creating directories
# mkdir -p {data/$(date +%F),scripts,analysis}
# cd data/$(date +%F)
cd data/

# Downloading data
# Aedes aegypti
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/204/515/GCA_002204515.1_AaegL5.0/GCA_002204515.1_AaegL5.0_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/204/515/GCA_002204515.1_AaegL5.0/GCA_002204515.1_AaegL5.0_genomic.gff.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/002/204/515/GCA_002204515.1_AaegL5.0/md5checksums.txt
echo; echo "## MD5 checksum"
md5 *.gz
grep "_genomic.fna.gz" *md5checksums.txt
grep "_genomic.gff.gz" *md5checksums.txt

# decompress files with the command gunzip:
gunzip *.gz

# Done
echo; echo "[$(date)] $0 has been successfully completed."
