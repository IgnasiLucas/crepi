#!/bin/bash
PARPATH="/nata/mar/crepidostomum2/data/PARASIT_HiSeq_data_WINDU3"
BARCODEDIR="/nata/mar/proteocephalus/data/data_info/demultiplex"
PROJECTDIR="/nata/mar/crepidostomum2/results/2023-05-17"
for n in $(seq 1 16); do
   ipyrad -n PAR2no${n}
   RAWFASTQPATH="${PARPATH}/PAR2no${n}_*"
   BARCODESPATH="$BARCODEDIR/barcod_PAR2_no${n}.txt"
   sed -i "/## \[1\]/c $PROJECTDIR    ## [1] [project dir]"    params-PAR2no${n}.txt
   sed -i "/## \[2\]/c $RAWFASTQPATH  ## [2] [raw_fastq_path]" params-PAR2no${n}.txt
   sed -i "/## \[3\]/c $BARCODESPATH  ## [3] [barcodes_path]"  params-PAR2no${n}.txt
   sed -i "/## \[7\]/c pairddrad      ## [7] [datatype]"       params-PAR2no${n}.txt
   sed -i "/## \[8\]/c CATG, TAA      ## [8] [restriction_ov]" params-PAR2no${n}.txt
   ipyrad -p params-PAR2no${n}.txt -s 1 -c 24
done
