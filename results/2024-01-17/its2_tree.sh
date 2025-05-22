#!/usr/bin/bash
FOLDER=RAxML/ITS2_round00
## Finally run a tree Search
raxml-ng --msa $FOLDER/AlignTree_Mafft.alg --model GTR+G --prefix $FOLDER/T2 --threads 48
 
## Compute and map bootstrap support values to the best ML tree (S1.raxml.bestTree)
raxml-ng --bootstrap --msa $FOLDER/AlignTree_Mafft.alg --model GTR+G --prefix $FOLDER/S2_bestTree --tree $FOLDER/T2.raxml.bestTree --threads 48 --bs-trees 10000

# Recompute support values using the Transfer Bootstrap Expectation (TBE) algorithm.
raxml-ng --support --tree $FOLDER/T2.raxml.bestTree --bs-trees $FOLDER/S2_bestTree.raxml.bootstraps --prefix $FOLDER/S2_FBP --threads 48 --bs-metric fbp
raxml-ng --support --tree $FOLDER/T2.raxml.bestTree --bs-trees $FOLDER/S2_bestTree.raxml.bootstraps --prefix $FOLDER/S2_TBE --threads 48 --bs-metric tbe 