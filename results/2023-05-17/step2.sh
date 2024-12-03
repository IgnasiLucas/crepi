#!/bin/bash

## Obtain the list of Crepidostomum sample names (abbreviated C or c)
if [ ! -e samples.txt ]; then
   find ./ -name '*_R1_.fastq.gz' | \
   xargs basename -s _R1_.fastq.gz | \
   grep -E ".{4}[Ch].{2}" | sort | uniq > samples.txt
fi

# Merge all assemblies in ONE
if [ ! -e params-PARall.txt ]; then
   ipyrad -m PARall params-PAR*
fi

# Branch to keep only the Crepidostomum samples. Well, we not add the samples
# LR18_06, Mo18_05, FU37, 17_Om07 and 17_Om05, of different host and probably different species.

cat samples.txt | xargs ipyrad -p params-PARall.txt -b crepi

sed -i "/## \[5\]/c reference    ## [5] [assembly_method]"       params-crepi.txt
sed -i "/## \[9\]/c 4            ## [9] [max_low_qual_bases]"    params-crepi.txt
sed -i "/## \[10\]/c 33          ## [10] [phred_Qscore_offset]"  params-crepi.txt
sed -i "/## \[11\]/c 6           ## [11] [mindepth_statistical]" params-crepi.txt
sed -i "/## \[12\]/c 4           ## [12] [mindepth_majrule]"     params-crepi.txt
sed -i "/## \[13\]/c 1000        ## [13] [maxdepth]"             params-crepi.txt
sed -i "/## \[14\]/c 0.93        ## [14] [clust_threshold]"      params-crepi.txt
sed -i "/## \[17\]/c 35          ## [17] [filter_min_trim_len]"  params-crepi.txt
sed -i "/## \[18\]/c 2           ## [18] [max_alleles_consens]"  params-crepi.txt
sed -i "/## \[19\]/c 0.05        ## [19] [max_Ns_consens]"       params-crepi.txt
sed -i "/## \[20\]/c 0.05        ## [20] [max_Hs_consens]"       params-crepi.txt
sed -i "/## \[21\]/c 10          ## [21] [min_samples_locus]"    params-crepi.txt
sed -i "/## \[22\]/c 0.1         ## [22] [max_SNPs_locus]"       params-crepi.txt
sed -i "/## \[23\]/c 8           ## [23] [max_Indels_locus]"     params-crepi.txt
sed -i "/## \[24\]/c 0.5         ## [24] [max_shared_Hs_locus]"  params-crepi.txt
sed -i "/## \[25\]/c 0, 0, 0, 0  ## [25] [trim_reads]"           params-crepi.txt
sed -i "/## \[26\]/c 0, 0, 0, 0  ## [26] [trim_loci]"            params-crepi.txt
sed -i "/## \[27\]/c *           ## [27] [output_formats]"       params-crepi.txt
sed -i "/## \[28\]/c ipopmap.txt ## [28] [pop_assign_file]"      params-crepi.txt


# Creating the popmap file
if [ ! -e ipopmap.txt ]; then
   gawk 'BEGIN{
      LAKE["B"] = "Bri"
      LAKE["N"] = "Bie"
      LAKE["T"] = "Thu"
      LAKE["W"] = "Wal"
      LAKE["S"] = "Suo"
      LAKE["L"] = "Lan"
      LAKE["Z"] = "Zur"
   }{
      for (i = 1; i <= NF; i++) {
         print $i "\t" LAKE[substr($i, 1, 1)]
         F[LAKE[substr($i, 1, 1)]] = 1
      }
   }END{
      S = "# "
      for (f in F) S = S f ":0 "
      print S
   }' samples.txt > ipopmap.txt
fi

ipyrad -p params-crepi.txt -f -s 2 -c 32 1> ipyrad.log 2> ipyrad.err
