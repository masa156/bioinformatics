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

## プロジェクトの詳細

　私は当初、Ladona_fulvaというトンボの一種のゲノム解析をしていく流れでした。
まずはそのプロジェクトでの一連の流れをご説明します。
大枠は、
興味のある生物をダウンロード、その取得方法の記載(課題５)
→script.shの作成(課題６)
→それらのゲノム解析する為のプロジェクトディレクトリ作成・圧縮(課題７)
→2つ以上のコンピュータ環境で再実行し、再現性を確かめる(相対パスでないと他人の環境で実行できない)(課題８)
→今回でこのようにプロジェクトの詳細を説明し、半年後に見返し忘れていたとしても、あるいは誰が見たとしても、同様に行えるように過程記録を残す。(課題9)

　script.shの作成まではLadona_fulvaで行えたものの、課題7以降では、その生物ゲノムにgffファイルがなく、gbffファイルしかなかったので、利用していたことが原因か、run.shやrun_all.shを実行していく過程で、GBを優に超えるgbffにより出力されるoutput.txtが生まれていた。それにより、うまく最終結果のログが残らず、苦渋を嘗めていたので、方針を転換し、比較的類似した生物である、蚊のゲノムでgffファイルをもつ生物を選択し直した。
それにより、fastaファイルが大きく、run.shで欲しい実行結果以外の出力もされてしまってはいるものの、gffファイルサイズが小さいおかげで、なんとか出力結果にたどり着けた。これらのゲノムの種類数と類似した生物を調べたところ、下記の通り、ミツバチやハバチが該当した。
　またさらに細かくinspectingする為にrun_all.sh等を作成したが、これらはデバッグ作業に時間がかかり、前回の課題ではいったん脇に置いておいた。

(12/29追記)今回行ってみた所、コード順の問題で出力がされなくなっていたことが判明した。echo; echo "* Inspecting and Manipulating Text Data with Unix Tools"　ls -lh と wc -l *よりも先にgrepやawkなどのコマンドを済ませておくことがどうやら出力されなくなる問題を回避できるようだ。
あとgrep "^>" $FNAは尋常じゃない出力を行うので、今回は実行しないのが適切と考えた。トンボもこういうのが原因と思われる。全出力結果はanalysis/outputnew.txtに入れた。
(bash scripts/run_data_inspector_new.sh >> analysis/outputnew.txt     
 bash scripts/run_data_inspector2_new.sh >> analysis/outputnew2.txt)

 　これらのデバッグを踏まえ、トンボの方も行ってみたが、gbffはgffと違って、そもそものゲノム配列の種類分けの仕組みが違うようだ。
 GCA_000376725.2_Lful_2.0_genomic.fnaが1.17GB
 GCA_000376725.2_Lful_2.0_genomic.gbffが1.51GB
 run_new.shで実行したところ、analysis/2020-12-29/output.txtの大きさは1.46GBに達し、まともにファイルを開けず、最後の出力結果を見れない。
 一番核となるコマンドである、grep -v "^#" $GFF | cut -f3 | sort | uniq -c　を行うだけでこれだけの容量の出力結果になってしまう。

 　そこで、Hex Fiendという巨大なtxtファイルを楽に開けるツール(対応する16進数が左に書いてあるので、それを文字変換してるのではと思われる。)を用い、ゲノムをみたが、gffファイルとは全く別の基準で分子?がgbffでは種類分けされており、もはやカオス状態である。ゆえ基準が異なるので、rRNAカウントやCDSの末尾などは全く出力されなかった。
 sortした際のものはスクリーンショットだけ撮影し、それをディレクトリ内に残した。
 他にもHex Fiendなど、あらゆる解析場面での状態をスクリーンショットとして残した。
 また、GBを超える巨大ファイルは圧縮時に除外したので、ディレクトリ下でどうなっていたかもスクリーンショットで残した。(mosquitoも同様の工程を行った)
```
１つの例
ls -lh
total 3705872
drwxr-xr-x  3 masashiwakita  staff    96B Dec 21 23:19 2020-12-19
drwxr-xr-x  2 masashiwakita  staff    64B Dec 22 12:52 2020-12-22
-rw-r--r--  1 masashiwakita  staff   1.8G Jan 10  2018 GCA_002204515.1_AaegL5.0_genomic.fna
-rw-r--r--  1 masashiwakita  staff   2.2M Jul 10  2019 GCA_002204515.1_AaegL5.0_genomic.gff
-rwxr-xr-x  1 masashiwakita  staff   4.1K Mar 25  2020 md5checksums.txt

wc -l *

wc: 2020-12-19: read: Is a directory
wc: 2020-12-22: read: Is a directory(エラー出力はターミナルにのみ出力)
 23393159 GCA_002204515.1_AaegL5.0_genomic.fna
   19684 GCA_002204515.1_AaegL5.0_genomic.gff
      40 md5checksums.txt
 23412883 total
```

```
* Inspecting and Manipulating Text Data with Unix Tools
    9411
       0
LOCUS       KZ308113             2171779 bp    DNA     linear   CON 02-NOV-2017
DEFINITION  Ladona fulva isolate sampled in the wild unplaced genomic scaffold
            scaffold85, whole genome shotgun sequence.

* Only 1,4,5
LOCUS       KZ308113             2171779 bp    DNA     linear   CON 02-NOV-2017
DEFINITION  Ladona fulva isolate sampled in the wild unplaced genomic scaffold
            scaffold85, whole genome shotgun sequence.

中略

* Using grep, cut, sort, uniq to summarize columns of data
9411                                       ATLAS-gapfill v. 2.2; redundans v. 0.12c
4342                      /chromosome="Unknown"
9411                      /collection_date="07-May-2011"
9411                      /country="Germany: Rhineland-Palatinate"
9411                      /db_xref="taxon:123851"
  57                      /estimated_length=10
  25                      /estimated_length=100
  14                      /estimated_length=1000
   1                      /estimated_length=10008
   7                      /estimated_length=1001
   1                      /estimated_length=10019
   7                      /estimated_length=1002
以下略
```
・Windows for linux (WSL)(ubuntu)の苦労
 Sudoでbashファイルを実行すれば、目的のことはできた。
だが、ubuntu(WSLと類似)では読み取り専用になっていたため、それらの解除法を調べ、専用のアプリ(レジストリエディター)に入り、OSの深いレイヤーの所もいじったりしたが、駄目であった。いじりすぎて親のパソコンを駄目にする可能性があった為、中断。chmodを使っても同じエラーしか出なかった(operation not permitted や permission denied)ので、mountコマンドを使ったが、これはOSに大きく影響を与える為、注意が必要なコマンドである。

　実際、windows for Ubuntuのターミナルからopenコマンド(xdg-open)で目的のubuntu下のファイルに飛ぼうとしたが、mountコマンドを用いいじったことが原因なのか、エラーしか出なくなった為、再インストールして復帰させた。
ゆえ、当然nanoやvimでの直接の編集もできず、エラーがある度にMacで編集し直したものをwindowsに送る始末となった。
Ubuntu外であれば、書き込みも可能である為(shはwindowsOSでは操作できないが)、おそらくUbuntuOSの環境設定に何かしら不具合があるが、上記にも掲載したアプリで設定をいじったりしてもうまくいかなかった。

　改めて調べてみた所、この下記サイトのやり方に従えば、解決できそうな気がしました。やはり初期のUbuntu環境(パーミッション設定)が読み取り専用になってしまっているようです。
https://www.it-swarm-ja.tech/ja/ntfs/ubuntu%E3%81%AF%E5%A4%96%E9%83%A8ntfs%E3%83%89%E3%83%A9%E3%82%A4%E3%83%96%E3%82%92%E8%AA%AD%E3%81%BF%E5%8F%96%E3%82%8A%E5%B0%82%E7%94%A8%E3%81%A8%E3%81%97%E3%81%A6%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%88%E3%81%97%E3%81%BE%E3%81%99%E3%81%8B%EF%BC%9F/961116752/


　またmacでしっかりsh認識されていないファイルをwindows側に送ると動かなかった。ファイル名を編集し直したら、sh認識が簡単にされた。(当初set -euoが機能していないとエラーが出た)
　こちらの方が重要であるが、ファイルごと送らないと実行できないことも判明。つまりshとして認識されていたとしても、読み取りは、圧縮されたディレクトリ内のshでないと動かない。圧縮していないとそもそもファイルをメールで送れないが。
　まさかrunlinux.shだとshとして認識されなくて、run_linux.shってやったら認識されてその時はアンダーバーが必要なのかと考えたが、別の件で操作した際にRenameしただけでsh認識されたため、duplicateとかで複製する際に拡張子が一時的にshじゃ無くなることが問題かと思われる。

　Windowsでプロパティの一番上のshを開いたら読み取り専用オンになっているのに、他のファイルを見てみたらオフになっていて、もう一度一番上に戻って表示をみたらオフになった。であるが、なぜか両方ともsh自体はUbuntuで実行できた。Ubuntu内のshファイルのプロパティが2つ目以降を覗くと、読み取り専用の項目もチェックが外れていて、何度チェックしても自動的に外れるのにだ
　あとスマホのテザリングでfasta等をダウンロードしていたら全然進まない為、wifiを使う事

鈴木治夫教授からのアドバイス

3.5　コマンド置換 mkdir $(date +%F) mkdir `date +%F`     
bash以外のコマンドで、こういうふうなくくりにすると上手くいくこともある。
これは WSL下のそのUbuntu下で、Macと同様のコマンドである、(bash scripts/run.sh &) >& log.$(date +%F).txt　を行った際に、dateっていう関数はありませんとエラーメッセージが返って来た。デバッグを行う時間がなかったので、log.txtは残さず、Ubuntuのターミナルで出力されたものをWordにコピペをし、このREADME完成版.mdの下記にそのログ内容を記載した。今後WSLを使う際はここのデバッグ作業もやっていきたい。

これらも、slackに投げると解決するよと、アドバイスを頂いた。

----------

## まとめ　補足事項


　Linuxでmountコマンドを使う際は注意が必要。OSをいじることになるから、かなりリスクのある作業。readonlyすらできなくなったかと思って焦ったが、おそらく、ファイルの中に最初からなかったshはどうやら動かない。動かしたやつは何か、書かれてるコード内容が変わるのか、原因は詳しくはわからないが、全ディレクトリと共に圧縮してガードしとくのが大事。もしかしたらshだけで送る際も圧縮して渡せばうまくいくのかもしれない。今後試す機会があればするべき。

　xdg-openコマンドもできなくなったのはmountコマンドが原因か。再インストールしたら戻ったが。

　あとLinuxはmacのようにmd5コマンドじゃなくてmd5sumコマンドにしないと、動かないことに注意。

　Windowsはグループポリシーとかあって権限の仕組みがややこしい。セキュリティタブが表示されないのもよくわからない。

　mountコマンド(Sudo umount /mnt/c  Sudo mount -t drvfs C: /mnt/c -o metadata)等で、もしかしたらまずい所をいじったかとは思ったが、WindowsOSでは読み書き専用の設定を自由に変えられた為、UbuntuOS内にあるファイルだけでこの環境設定は構成されているはず。
　読み取り専用フォルダは、AdministratorsとかUsersとか　その権限の解除が上記のアプリで行ったが、うまく反映されなかった為、結局編集はmacで行った。

　chmodを使って、Linuxの読み書き制限が数字の1と2と4による足し算で組み立てられていて、sudo chmod 777とかやればいい事を理解し、そういうのを学べたことが卒論でのラズパイでのImageJ構築に活きると思い、為になった。


----------

## project directory structures
```
$find mosquito -type f | sort (今回の詳細版による改定によって)(.DS_StoreはMacOS関係のものである為、気にしなくて良い。WindowsOSに一度移した所から、表示されるようになった。)
mosquito/.DS_Store
mosquito/README.html
mosquito/README.md
mosquito/READMEold.md
mosquito/READMEold.md.html
mosquito/README完成版.html
mosquito/README完成版.md
mosquito/Screen Shot 2020-12-29 at 20.23.42.png
mosquito/analysis/.DS_Store
mosquito/analysis/2020-12-19/output.txt
mosquito/analysis/2020-12-21/output.txt
mosquito/analysis/2020-12-22/output.txt
mosquito/analysis/2020-12-22new/output.txt
mosquito/analysis/output.txt
mosquito/analysis/outputnew1.txt
mosquito/analysis/outputnew2.txt
mosquito/data/.DS_Store
mosquito/data/2020-12-19/.DS_Store
mosquito/data/md5checksums.txt
mosquito/log.2020-12-19.txt
mosquito/log2.2020-12-19.txt
mosquito/scripts/.DS_Store
mosquito/scripts/run.sh
mosquito/scripts/run_all.sh
mosquito/scripts/run_data_downloader.sh
mosquito/scripts/run_data_inspector.sh
mosquito/scripts/run_data_inspector2.sh
mosquito/scripts/run_data_inspector2_new.sh
mosquito/scripts/run_data_inspector_new.sh
mosquito/scripts/run_linux.sh


$find mosquito -type f | sort
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
(訂正:以前の課題7ではREADMEの記載がecoliのままになっていました)

2)windows for ubuntu
find mosquito -type f | sort
mosquito/.DS_Store
mosquito/README.md
mosquito/README.md.html
mosquito/analysis/.DS_Store
mosquito/analysis/2020-12-19/output.txt
mosquito/analysis/2020-12-21/output.txt
mosquito/analysis/2020-12-22/output.txt
mosquito/analysis/2020-12-22new/output.txt
mosquito/analysis/output.txt
mosquito/data/.DS_Store
mosquito/data/2020-12-19/.DS_Store
mosquito/data/README.md
mosquito/data/README.md.html
mosquito/data/md5checksums.txt
mosquito/log.2020-12-19.txt
mosquito/log2.2020-12-19.txt
mosquito/scripts/.DS_Store
mosquito/scripts/run.sh
mosquito/scripts/run_all.sh
mosquito/scripts/run_data_downloader.sh
mosquito/scripts/run_data_inspector.sh
mosquito/scripts/run_data_inspector2.sh
mosquito/scripts/run_linux.sh
```

----------

## scripts

The shell script `scripts/run.sh` `scripts/run_all.sh` automatically carries out the entire steps: creating directories, downloading data, and inspecting data.

Let's run the shell script `scripts/run.sh` `scripts/run_all.sh` in the project's main directory with:
```
1)
(bash scripts/run.sh &) >& log.$(date +%F).txt
(bash scripts/run_all.sh &) >& log.$(date +%F).txt

2)
ubuntu(Linux)では、コマンドが上手く実行できなかったので、そのまま
sudo bash scripts/run_linux.sh を実行して出力されたものをログとしてコピーし、保存しました。
```

----------

## data

Aedes aegypti strain LVP_AGWG mitochondrion, Complete Genome (GCA_002204515.1) data were downloaded on 2020-12-19 & 2020-12-22 into `data/`

### MD5 checksum
```
MD5 (GCA_002204515.1_AaegL5.0_genomic.fna.gz) = 853cb1a819ff62512abface64f61c91a
MD5 (GCA_002204515.1_AaegL5.0_genomic.gff.gz) = 6aa4dc30a05269eda2e9b6ff6c7b213c
```

----------

## analysis

Unix tools (grep, cut, sort and uniq) were used to print FASTA header lines (begin with `>` in .fna) and count how many of each feature (column 3 in .gff).

```
1)my mac
$cat analysis/2020-12-19/output.txt

>MF194022.1 Aedes aegypti strain LVP_AGWG mitochondrion, complete genome
  13 CDS
  25 exon
  13 gene
   2 rRNA
6534 region
  23 tRNA

2) windows for ubuntu
$cat analysis/2020-12-22/output.txt

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
1)my mac
diff analysis/2020-12-19/output.txt analysis/2020-12-21/output.txt

2)windows for ubuntu
diff analysis/2020-12-22/output.txt analysis/2020-12-22new/output.txt
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

uname -a
cat /etc/lsb-release

2)
Linux fyirika 4.4.0-19041-Microsoft #488-Microsoft Mon Sep 01 13:43:00 PST 2020 x86_64 x86_64 x86_64 GNU/Linux
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.1 LTS"



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
