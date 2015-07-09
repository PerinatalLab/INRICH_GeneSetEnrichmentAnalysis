#!/bin/bash

assoc=$1
outroot=$2
top_n=$3
gene_set=$4  #./refs/GO_cleaned/GOterms_allCleaned_geneSets_Entrez.txt #./refs/go.set #./refs/c2.cp.v3.0.entrez.msig.set # ./refs/kegg.set # ./refs/toINRICH_allPubMedGeneSets_EntrezIDs.txt
offset=$5

all_genes=./refs/gene_maps/ucsc_HUGO_ENTREZ_chr1-23_withDescriptions_hg19_PROCESSED.txt
bimfile=~/Desktop/MOBA_2008_QCed-5530/MoBa_5530_EurQC_hg19.bim
bim_digested=./temp/MoBa_5530_hg19_bim_digested.txt
 
clumps=${assoc} # ./assoc/moms_onlyPROM_100topClumps_toINRICH.txt
clumps_digested=./temp/clumps_digested.txt


# extract map file data
gawk 'NR>1{print$1,$4}' ${bimfile} > ${bim_digested}

# extract association regions
gawk 'NR>1 {print $1 "." substr($4, index($4,":")+1)}' ${clumps} | gawk -F. '{print $1,$2,$4}' > ${clumps_digested}

./InRich \
-a ${clumps_digested} \
-m ${bim_digested} \
-g ${all_genes} \
-t ${gene_set} \
-w ${offset} \
-r 50000 \
-q 10000 \
-i 2 \
-j 3000 \
-d 0.1 \
-p 0.1 \
-z 1 \
-n ${top_n} \
-o ${outroot}

rm ${clumps_digested}

