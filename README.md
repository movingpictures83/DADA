# DADA
# Language: R
# Input: TXT
# Output: PREFIX
# Tested with: PluMA 1.1, R 4.0.0
# dada2_1.18.0

Divisive Amplicon Denoising Algorithm (Rosen et al, 2012), taking into
account sequences and error rates.

The plugin accepts as input a TXT file of parameters, represented as keyword-value
pairs:
FASTQ: Prefix for sequences
errors: Prefix for error rates

The FASTQ prefix is for forward and reverse sequences; there should be two
R objects (type derep-class, package dada2) in prefix.forward.rds and prefix.reverse.rds

The prefix is used in a similar way for the forward and reverse error rates.
