# -*- coding: utf-8 -*-
#
# io.py
#
# Handling of reading from and writing to files.
# 
# Author = Severin Langberg
# Concact = Langberg@gmail.com
# 


library(gtools)
library(tidyverse)

source('./io.R')

# PART1

# Reading and formatting of data.
path_to_file <- './../data/Neuraminidase.fasta'
fasta.table <- PrepFasta(ReadFasta(path_to_file))




# Compute the distance matrix ...
N.counts <- sort(table(fasta.table$N.type), decreasing=T)
H.counts <- sort(table(fasta.table$H.type), decreasing=T)
dist.mat <- outer(N.counts, H.counts, '-')

image(
  1:length(N.counts), 1:length(H.counts), 
  dist.mat, axes=FALSE, xlab="", ylab=""
)



# Produce a matrix representation of detected L-mers relative to the 
# L-mer space. 
L <- 2
all.lmers <- elmers(L=L, iter=1, alphabet=c('A', 'C', 'G', 'T'))
lmer.counts <- elmerCount(fasta.table$Sequence[1], L=L, all.lmers)
mers.M <- elmerMatrix(lmer.counts, all.lmers)

# Convert matrix to table and bind to fasta table.
#mers.table <- as.data.frame(mers.M)
#data.table <- bind_cols(fasta.table, mers.table)

