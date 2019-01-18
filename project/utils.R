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

