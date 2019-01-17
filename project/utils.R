# -*- coding: utf-8 -*-
#
# utils.py
#
# Auxillary functions.
# 
# Author = Severin Langberg
# Concact = Langberg@gmail.com
# 


PrepFasta <- function(fasta.table, add_serotype=T) {
  # Format a FASTA table. 
  # 
  # Args:
  #   fasta.table (table):
  #
  # Kwargs:
  #   add_serotype (bool): 
  # 
  if (add_serotype) {
    fasta.table <- (
      fasta.table
      %>% mutate(
        Serotype=str_extract(
          fasta.table$Header, pattern='H[0-9]{1,2}N[0-9]{1,2}'
        ),
        H.type=str_extract(fasta.table$Header, pattern='H[0-9]{1,2}'),
        N.type=str_extract(fasta.table$Header, pattern='N[0-9]{1,2}')
      )
      %>% drop_na(Var=Serotype)
    )
  }
  return (fasta.table)
}


elmers <- function(L, iter=1, alphabet=c("A","C","G","T")) {
  # Produces all possible L-mers in sorted order.
  # 
  # Args:
  #   L (int): 
  # 
  # Kwargs:
  #   iter (int):
  #   alphabet (vector):
  # 
  require(stringr)
  
  if(iter < L){
    w <- elmers(L, iter + 1, alphabet)
    w <- str_c(
      rep(w, each = length(alphabet)),
      rep(alphabet, times = length(alphabet))
    )
  } else {
    w <- alphabet
  }
  return(sort(w))
}


elmerCount <- function(dna.seq, all.lmers, L) {
  # Inputs a DNA sequence and an integer value L. 
  # Returns a vector of L-mer counts.
  #
  # Args:
  # dna.seq (character):
  # all.mers ():
  # L (int):
  #
  lmer.counts <- numeric(length(all.lmers))
  
  n.splits <- str_length(dna.seq) - L + 1
  for (i in 1:n.splits) {
    lmer <- substr(dna.seq, start=i, stop=i + L - 1)
    idx <- match(lmer, all.lmers)
    lmer.counts[idx] <- lmer.counts[idx] + 1
  }
  return(lmer.counts)
}


elmerMatrix <- function(lmer.counts, all.lmers) {
  #
  #
  #
  #
  #
  obs.lmers <- all.lmers[which(lmer.counts != 0)]
  M <- matrix(
    0, 
    nrow=length(obs.lmers), ncol=length(all.lmers),
    dimnames=list(obs.lmers, all.lmers)
  )
  # Fill in matrix values.
  n.mers <- length(obs.lmers)
  for (i in 1:n.mers) {
    row.idx <- match(obs.lmers[i], obs.lmers)
    col.idx <- match(obs.lmers[i], all.lmers)
    M[row.idx, col.idx] <- lmer.counts[col.idx]
  }
  # Scale each row by row sum. 
  return(M / rowSums(M, na.rm=T))
}
