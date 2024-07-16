# 2024-07-10
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
