#!/usr/bin/bash

FOLDER=RAxML/28S_round03
## Finally run a tree Search
raxml-ng --msa $FOLDER/AlignTree_Mafft.alg --model GTR+G --prefix $FOLDER/T2 --threads 24
 
## Compute and map bootstrap support values to the best ML tree (S1.raxml.bestTree)
raxml-ng --bootstrap --msa $FOLDER/AlignTree_Mafft.alg --model GTR+G --prefix $FOLDER/S2_bestTree --tree $FOLDER/T2.raxml.bestTree --threads 24 --bs-trees 10000

# Recompute support values using the Transfer Bootstrap Expectation (TBE) algorithm. Did this change the support values?
raxml-ng --support --tree $FOLDER/T2.raxml.bestTree --bs-trees $FOLDER/S2_bestTree.raxml.bootstraps --prefix $FOLDER/S2_FBP --threads 24 --bs-metric fbp
raxml-ng --support --tree $FOLDER/T2.raxml.bestTree --bs-trees $FOLDER/S2_bestTree.raxml.bootstraps --prefix $FOLDER/S2_TBE --threads 24 --bs-metric tbe 
