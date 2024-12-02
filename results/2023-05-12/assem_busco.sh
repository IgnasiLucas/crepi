#!/bin/bash

for kc in 2; do
	for k in `seq 70 10 140`; do
	  if [ ! -d BUSCO ]; then mkdir BUSCO; fi
	  #if [ ! -d BUSCO/k${k}-kc${kc} ]; then mkdir BUSCO/k${k}-kc${kc}; fi
	  if [ ! -e BUSCO/k${k}-kc${kc}/short_summary.specific.metazoa_odb10.k90-kc2.txt ]; then
		  DRAFT=k${k}-kc${kc}/farionis-scaffolds.fa
      busco -i $DRAFT -l metazoa_odb10 -o BUSCO/k${k}-kc${kc}/ -m genome --cpu 12 
    fi
	done
done
