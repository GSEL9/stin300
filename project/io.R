# -*- coding: utf-8 -*-
#
# io.py
#
# Handling of reading from and writing to files.
# 
# Author = Severin Langberg
# Concact = Langberg@gmail.com
# 

library(stringr)
library(tidyverse)


ReadFasta <- function(path_to_file) {
  # Enables reading and formatting fasta file.
  # 
  # Args:
  #   path_to_file (character): Disk location of data file.
  # 
  # Returns:
  #   (table): The table formatted fasta data.
  # 
  raw.lines <- readLines(path_to_file)
  header.idx <- which(str_detect(raw.lines, '>'))
  fasta.table <- tibble(
    Header = str_remove(raw.lines[header.idx], '^>'),
    Sequence = rep('', length(header.idx))
  )
  # Add a final value to the index vector.
  header.idx <- c(header.idx, length(raw.lines) + 1)
  for(i in 1:(length(header.idx) - 1)) {
    dna.seq <- raw.lines[(header.idx[i] + 1):(header.idx[i + 1] - 1)]
    # Join multiple strings into a single string combined with `collapse`.
    fasta.table$Sequence[i] <- str_c(dna.seq, collapse="")
  }
  return(fasta.table)
}


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