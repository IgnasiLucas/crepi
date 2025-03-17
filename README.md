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
Most of the 204618 loci are not covered in more than 80 individuals,
but over 50000 loci are covered by at least one read in more than
80 individuals.

I select a subset of 190266 loci covered in at least 5 individuals
after removing the 6 individuals with less than 100000 loci covered,
which are: N044Cx2, N048Cma, N048Cmb, N048Cmc, S031Cmc, and T165Cxa.

# 2024-10-03
Preparation of ipyrad's results from 2023-05-17b for subsequent use
of the *de novo* assembly. Several goals:

1. Make FASTA files with the alleles output for every locus.
2. Extract a consensus sequence from every locus.

The `consensus.fa` FASTA file contains the consensus sequence of
204618 loci. It is intended to be used as a reference to map ddRADseq
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

# 2024-05-07
Count the number of reads in FASTQ files.

# 2024-04-11
Stairway plot analysis.

# 2024-04-10
Creation of an alignment input for BEAST.

# 2024-03-11b
Another placeholder for the ANGSD analysis of genetic structure. This time, the
`README.Rmd` skips a coverage analyses.

# 2024-03-11
Attempt to determine the genetic structure of the sampels with ANGSD, departing
from the BAM files in `2023-05-18/BAM`, which are mappings to the reference
assembly. Analysis underway.

# 2024-01-20
Phylogenetic reconstruction with the 28S marker.

# 2024-01-19
Phylogenetic reconstruction of the *Crepidostomum* genus from COI sequences,
including best representatives of the haplotypes in our ddRAD samples.

# 2024-01-18
Haplotype network with COI.

# 2024-01-17
Phylogeny of *COI*, *lsrDNA* and *ITS2* genes of all samples.

# 2023-10-19
Attempt to get a mitochondrial contig from the assembly in `2023-05-12/NANO`,
which is not there any more, with `mitoz`.

# 2023-10-02
Extraction of *cox1*, *lsrDNA* and *ITS2* genes from all samples, for
identification of *Crepidostomum sp*.

# 2023-06-22
Extraction of marker genes from an assembly. This needs to be repeated with
the current assembly in `2023-05-15`.

# 2023-05-24
This is a folder added a posteriori in this false cronological position
in order to keep a logical order. The aim of this analysisi is to check
the composition of the reference assembly to help make sense of the
irregularities observed when mapping reads to it. In particular, there
are a couple samples whose reads seem to map to only a fraction of the
contigs, either in the top range of contig lengths or in the bottom one.

A self-blast of all contigs helps confirm that the assembly is not dominated
by duplicated regions. The best local alignments of any contig to any other
one add up to only 6% of the assembly's length. Most alignments are shorter
than 5000 bases, much shorter than the contigs involved, and highly identical.

# 2023-05-23
The variable mapping rate shown in `2023-05-18` has consequences for the
way we determine what samples have or have not enough data. We cannot just
use the number of reads, but we need to compare samples on the grounds of
mapped reads. It is mandatory to explore the VCF generated with GATK in
`2023-05-18` to identify the samples with too much missing data, and to get
an idea of the number of SNPs genotyped in a certain fraction of samples.

As expected, the following samples have much less data than the rest and
must be removed:

N044Cx2
N048Cma
N048Cmb
N048Cmc
S031Cmc
T165Cxa

Most SNPs are at very short distance from others. The thinning filter
removes vasts amounts of data. Keeping SNPs at no less than 200 bases
apart (which is close!) leaves us with only 4902 SNPs gentoyped in
at least 2/3 of the remaining 90 samples.

# 2023-05-18
Mapping of demultiplexed FASTQ reads from `2023-05-17/crepi_edits` to 
the reference genome in `2023-05-15/assembly.fasta`. In addition to the
BAM files, a VCF is now being generated.

The statistics from the BAM files are compared to those from the
demultiplexing (`2023-05-17`), to see what the mapping success was per
individual. Curiously, the mapping success covaries with lake of origin.
The highest mapping rates are observed in samples from Suopatjavri,
suggesting a mostly *pseudofarionis*-like background of the assembly.
They are followed closely by samples from Langfjordvatn, with only
about 20% of reads unmapped. The only sample from Thun has a much lower
mapping rate, near 50%. And the worst mapping rates are those of the
four samples from Bienne, where we loose over 80% of reads. This is
clearly indicating a very divergent nature of the *Crepidostomum*
samples from Bienne, and also (to a lesser extent) from Thun. Are they
a different species? Are they just very contaminated DNA extractions?
Some BLAST searches are needed to determine they reason of low mapping
rate from subalpine samples.

A preliminary filtering of the VCF produced by GATK shows that samples
from Bienne and Thun do not have enough data. Curiously, however, some
samples have genotype data in only a subset of contigs. This is worrisome.

# 2023-05-17b
Ipyrad was run in Garnatxa with different clustering thresholds, between
0.94 and 0.98. I reccommend using results for clustering threshold 0.95.
This is a de novo assembly of ddRAD loci.

# 2023-05-17
Here we run Ipyrad to demultiplex the original FASTQ files from the ddRAD
experiment. The process was tricky because of how messy the sequencing
design was. Unforgivable.

Apparently data came from three sequencing runs, two of them yielding
less than 5% of unassigned reads, but one yielding around 17% of reads
unassigned. The quality control of the demultiplexed reads did not reveal
any apparent reason for such a failure of the third sequencing run, although
the issue was not researched in depth.

Among *Crepidostomum* samples (others were present in the original files)
only one had a much lower yield than the rest: N044Cx2, with just over
one hundred thousand reads. All other samples got between 1 and 3 million
reads if sequenced once, or around 4 million reads in the case of six
samples that got sequenced twice.

# 2023-05-15
We use Illumina shotgun reads and `ntedit` with different values of *k*
to polish the ONT-PB assembly from 2023-05-12 (that is, the one obtained
by using Nanopore data first and PacBio data for polishing). Note that
the polishing removed a few contigs in addition to introducing a lot of
editions. We retain the polishing made with $k=31$ and re-write the polished
assembly in descending length order of the contigs, after removing contigs
suspected to have multiplicities higher than 1. The final, ordered assembly
is saved in `assembly.fasta` and it is 206254914 nucleotides long.

# 2023-05-13
Just a close look at the two assemblies obtained in `2023-05-12`, to try
to understand the reasons why they are so different and why the coverage
per contig is so variable.

The two assemblies (ONT_PB and PB_ONT) start with the same amount of data.
It is only the last, polishing step where they diverge. When using Nanopore
data for polishing, we get higher average coverage, and very few contigs
get filtered out. But when using PacBio data for polishing, the average
coverage is below the coverage threshold, and most contigs get discarded
(I think). 

In any case, the several or the few contigs kept in the assembly have a
bimodal coverage distribution, with peaks at 4 and at 20. Results from
`flye` suggest only contigs with coverage around 4 seem to represents
fractions of the genome present only once (multiplicity 1), while coverage
higher than 10 indicates higher and variable multiplicity. The reason
for the second sharp coverage peak is unknown. I would feel more comfrotable
BLASTing contigs against the *nr* database, to make sure they are neither
vertebrate nor bacterial.

There are some *circular* contigs. I don't remove them. But I do sugges
removal of all contigs with multiplicity larger than 1. They are a small
fraction of the assembly.

# 2023-05-12
Assembly of the reference genome using all available reads, despite of
the fact that different data types (PacBio, NanoPore, Illumina) come from
different individuals, and not all from the same lineage. In previous versions
of this folder, a separate assembly was attempted for the two linages known
to exist, because they have been described in the literature as two different
species. Namely, *Crepidostomum farionis* and *C. pseudofarionis*. However,
our own results showed that the F$_ST$ value between them was in the order of
only 0.12. And several hybrids could be spotted. Thus, the two lineages are
close enough to be considered the same species. Consequently, the assembly is
done again with all available data.

# 2023-04-19
This is the base calling of the Nanopore raw data and the quality control of
the different sequence data files. There is also a Genoscope2 analysis of the
Illumina reads (the other data types do not have enough quality for that analysis).
It suggests a very high heterozygosity (~8%). The fact is that the Illumina
reads come from an individual with admixed ancestry (see 2024-10-18). But 8%
heterozygosity is too much. The analysis also suggests a haploid genome size of
680 million base pairs, with 62% unique sequence.
