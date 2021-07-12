Masashi Wakita  
Last Update: 2020-12-19

---

# *Aedes aegypti* (yellow fever mosquito) genome project
Project started 2020-12-19.  

A complete genome of *Aedes aegypti* K-12 was retrieved from the NCBI FTP site. Unix tools (grep, cut, sort and uniq) were used to assess genome sequence features.

- [project directory structures](#project-directory-structures)
- [scripts](#scripts)
- [data](#data)
- [analysis](#analysis)
- [reproducibility](#reproducibility)
- [references](#references)

----------

## project directory structures
```
$find ecoli -type f | sort
mosquito/README.md
mosquito/README.md.html
mosquito/analysis/2020-12-19/output.txt
mosquito/analysis/output.txt
mosquito/data/README.md
mosquito/data/README.md.html
mosquito/data/md5checksums.txt
mosquito/log.2020-12-19.txt
mosquito/log2.2020-12-19.txt
mosquito/scripts/run.sh
mosquito/scripts/run_all.sh
mosquito/scripts/run_data_downloader.sh
mosquito/scripts/run_data_inspector.sh
mosquito/scripts/run_data_inspector2.sh
```

----------

## scripts

The shell script `scripts/run.sh` `scripts/run_all.sh` automatically carries out the entire steps: creating directories, downloading data, and inspecting data.

Let's run the shell script `scripts/run.sh` `scripts/run_all.sh` in the project's main directory with:
```
(bash scripts/run.sh &) >& log.$(date +%F).txt
(bash scripts/run_all.sh &) >& log.$(date +%F).txt
```

----------

## data

Aedes aegypti strain LVP_AGWG mitochondrion, Complete Genome (GCA_002204515.1) data were downloaded on 2020-12-19 into `data/`

### MD5 checksum
```
MD5 (GCA_002204515.1_AaegL5.0_genomic.fna.gz) = 853cb1a819ff62512abface64f61c91a
MD5 (GCA_002204515.1_AaegL5.0_genomic.gff.gz) = 6aa4dc30a05269eda2e9b6ff6c7b213c
```

----------

## analysis

Unix tools (grep, cut, sort and uniq) were used to print FASTA header lines (begin with `>` in .fna) and count how many of each feature (column 3 in .gff).

```
$cat analysis/2020-12-19/output.txt

>MF194022.1 Aedes aegypti strain LVP_AGWG mitochondrion, complete genome
  13 CDS
  25 exon
  13 gene
   2 rRNA
6534 region
  23 tRNA
```

There were 13 CDS, 2 tRNA and 23 rRNA genes in Aedes aegypti strain LVP_AGWG mitochondrion, complete genome.
Similar results were reported by
[高橋純一 et al. (2017)](https://core.ac.uk/reader/230834810).
[Arge bella Wei et al. (2018)](https://peerj.com/articles/6131/graphical-abstract.pdf) stated that "species exposed to selection for rapid growth have more rRNA operons, more tRNA genes and more strongly selected codon usage bias."
ニホンミツバチやミフシハバチのゲノムが類似していると判明した。これは複眼を持つ蚊とハチの生物種的に家系図が近接していることが考えられる。

----------

## reproducibility

This workflow is fully reproducible.
I confirmed that this workflow run on different machines yielded the same outcome using:
```
diff analysis/2020-12-19/output.txt analysis/2020-12-21/output.txt
```

### environments

Print operating system characteristics using:
```
uname -a
sw_vers

1)
Darwin masa.local 18.7.0 Darwin Kernel Version 18.7.0: Mon Aug 31 20:53:32 PDT 2020; root:xnu-4903.278.44~1/RELEASE_X86_64 x86_64
ProductName:	Mac OS X
ProductVersion:	10.14.6
BuildVersion:	18G6032


```

----------

## references
- [DATA SCIENCE FOR BIOINFORMATICS [DS2] 2020](https://github.com/haruosuz/introBI/tree/master/2020)
  - [NCBI Genome List](https://github.com/haruosuz/introBI/blob/master/2020/CaseStudy.md#ncbi-genome-list)
  - [Using Pandoc to Render Markdown to HTML](https://github.com/haruosuz/introBI/tree/master/2020#using-pandoc-to-render-markdown-to-html)

		FILE=README.md
		pandoc --from markdown --to html ${FILE} > ${FILE}.html

- [高橋純一 et al. (2017) ニホンミツバチの遺伝子](https://core.ac.uk/reader/230834810)
  - [Arge bella Wei et al. (2018) ミフシハバチの遺伝子](https://peerj.com/articles/6131/graphical-abstract.pdf)
