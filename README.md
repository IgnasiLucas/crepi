(Note the inverse chronological order: more recent first)

# 2024-10-18
Mar suspects the individual from which the Illumina reads were
sequenced for the assembly of the reference genome could be
hybrid. One straight-forward way to check is to map those reads
to the RAD loci and repeat the whole analysis with that additional
individual. I will call that individual E716xxx.

The analysis suggests this individual is 90% *C. farionis*, but
nearly 10% *C. pseudofarionis*. 

# 2024-10-10
Estimation of SFS and FSTs. Because we only have samples from
the two Arctic lakes, the only interesting FST is between
lakes. And since most individuals in a lake are from the
same species, I estimated the FST between species, using
for each species individuals from the same lake.

The FST (weighted) between C. farionis and C. pseudofarionis
is 0.1217.

# 2024-10-05
Here, I run ANGSD on the BAM files resulting from mapping the
reads back to the RAD loci assembled with those reads. Because
loci are short, there is no point in estimating linkage
disequilibrium among SNPs within a locus, and we do not have
information on the genetic distance among loci. Thus, the best
we can do is to select one random SNP from every locus. But,
because coverage is variable within loci, I made the choice
among the SNPs with the most coverage in the locus.

In all, 42810 SNPs are selected (it seems many loci were
monomorphic, likely due to their low coverage). A second run
of likelihood estimation on only those sites applied some filters,
resulting in 40991 sites retained.

NGSadmix suggests *K=2* as a good fit to the genetic structure.
It reveals the existence of the two species, that we think are
*Crepidostomum farionis*, which predominates in Langfjordvatn,
and *Crepidostomum pseudofarionis*, which predominates in
Suopatjavri. Only 3 admixed individuals and one immigrant are
observed in Langfjordvatn; and 4 immigrants and 1 admixed
individual in Suopatjavri:

| **Individual** | **Why it's special**    |
| -------------- | ----------------------- |
| L019Cxa        | Admixed (62% C.p.)      |
| L019Cxb        | Admixed (63% C.p.)      |
| L088Cma        | Admixed (64% C.p.)      |
| L131Cmb        | Immigrant (100% C.p.)   |
| S004Cma        | Immigrant (100% C.f.)   |
| S004Cmb        | Immigrant (100% C.f.)   |
| S023Cxd        | Admixed (36% C.p.)      |
| S061Cma        | Immigrant (100% C.f)    |
| S061Cmb        | Immigrant (100% C.f)    |

Table `summary.txt` shows the predicted ancestry composition of
every individual with *K=2*.

PCangsd identifies one main component with 18% of variation that
separates the two species and leaves the four admixed individuals
near the middle. The second principal component only accounts for
1.3% of variation. Suopatjavri seems to be more diverse.



# 2024-10-04
The `consensus.fa` from `2024-10-03` is renamed to `radloci.fa`,
indexed and used as a reference to map the ddRAD-seq reads. The
BAM files are all in `BAM` subfolder.

Upon inspection of mapping results, an improvement of coverage
with respect to `ipyrad`'s results is clear, as expected from the
usage of `mindepth_majrule` 4 in `ipyrad`'s run in `2023-05-17b`.
Most of the 76850 loci are not covered in more than 60 individuals,
but over 20000 loci are covered by at least one read in more than
80 individuals.

I select a subset of 70721 loci covered in at least 5 individuals
after removing the 6 individuals with less than 30000 loci covered,
which are: N044Cx2, N048Cma, N048Cmb, N048Cmc, S031Cmc, and T165Cxa.

# 2024-10-03
Preparation of ipyrad's results from 2023-05-17b for subsequent use
of the *de novo* assembly. Several goals:

1. Make FASTA files with the alleles output for every locus.
2. Extract a consensus sequence from every locus.

The `consensus.fa` FASTA file contains the consensus sequence of
76850 loci. It is intended to be used as a reference to map ddRADseq
reads. The reason for this double use of the FASTQ files is that
`ipyrad` was run with `mindepth_majrule` set to 4, which was
necessary to focus on reliable sites but wasted many reads that
could contribute to low-coverage genotypes. The next mapping of
the reads will contribute the quality information to BAM files,
which is necessary in ANGSD.

# 2024-07-10
Deprecated. It was run with an untrusted assembly from two different
species.

Any genome assembly is bound to assembly errors, which can bias the
assessment of genetic variation. One common error is the collapsing
of two or more paralogous regions into the same contig. Such erroneous
contigs are expected to receive higher coverage than the average,
because reads originating in two or more genomic regions will be
mapped to the same contig. Thus, the goal of this folder was to
inspect the distribution of depth of coverage across contigs, and
try to identify suspicious contigs with higher than expected coverage
across all samples.

In previous versions, we used a VCF from GATK to retrieve average
depth of coverage *per covered site* (that is: we only consider sites
covered at least once in at least one sample, because ddRAD-seq data
is not random along the genome). But GATK takes too long, and
`samtools` can generate a matrix of coverage depths per sample in
a matter of hours.

Unfortunately, the distribution of coverage is very continuous, and
widespread: there is no way to spot outliers. The only recommendable
filter at this point is to remove a few contigs from the end of the
coverage distribution, quite arbitrarily. The file `BadContigs.txt`
contains the identifiers of the 503 (of over 3 million) contigs with
the highest coverage.

# 2023-10-02
Extraction of *cox1* and *lsrDNA* genes from all samples.

# 2023-05-17b
Ipyrad was run in Garnatxa with different clustering thresholds, between
0.94 and 0.98. I reccommend using results for clustering threshold 0.95.

# 2023-05-17
This is the `ipyrad` run to demultiplex the FASTQ files.

# 2023-05-12b
[Note: this folder depends on previous folder `2023-04-19`, which is not in the
current repository!]
This seems to be a new hybrid assembly, after deciding that, after all, the two
presumed species may actually be the same one. 

# 2023-05-12
This is the attempt to assemble the reference genome of *Crepidostomum farionis*.
After realizing the Nanopore data came from *C. pseudofarionis*,
Mar had to repeat the assembly with only Illumina and PacBio data.

It seems to be work in progress. Not sure if it is reproducible from the
`README.Rmd`. 

