# PART 2
#
# Modelling DNA sequence data and counting L-mers.
#

library(tidyverse)
library(MASS)

source('~/Desktop/stin300/project/io.R', local=T)
source('~/Desktop/stin300/project/utils.R', local=T)

# Load the formatted data table.
path_to_file <- '~/Desktop/stin300/data/Neuraminidase.fasta'
fasta.table <- ReadFasta(path_to_file)
fasta.table <- PrepFasta(fasta.table)


elmers <- function(L, iter=1, alphabet=c("A","C","G","T")) {
  # Produces all possible L-mers from a sequence and return them 
  # in sorted order.
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


elmerCounts <- function(seq.str, elmers, L) {
  # Count the number of L-mers extracted from a character 
  # sequence.
  
  # Counting across the complete L-mer space.
  lmer.counts <- numeric(length(elmers))
  
  # The total number of sequence divisions.
  n.splits <- str_length(seq.str) - L + 1
  for (i in 1:n.splits) {
    # Extract the L-mer sequence and determine its position
    # relative to the complete L-mer space.
    lmer <- substr(seq.str, start=i, stop=i + L - 1)
    idx <- match(lmer, all.lmers)
    # Update the count for each encountered L-mer.
    lmer.counts[idx] <- lmer.counts[idx] + 1
  }
  return(lmer.counts)
}


# Produce a matrix representation of detected L-mers relative to the 
# L-mer space. Pass through each sequence (each row in fasta.table$Sequence), 
# compute the counts and store the results in matrix.
L <- 2
n.seqs <- length(fasta.table$Sequence)

all.lmers <- elmers(L=L, iter=1, alphabet=c('A', 'C', 'G', 'T'))

M <- matrix(0, nrow=n.seqs, ncol=length(all.lmers))
colnames(M) <- all.lmers
for (i in 1:n.seqs) {
  # Extract a sequence from the data set, create a  vector with 
  # counts of each encountered L-mer and store the result.
  lmer.counts <- elmerCounts(fasta.table$Sequence[i], all.lmers, L=L)
  M[i, ] <- lmer.counts
}
# Scale rows to unit length. 
M <- as.data.frame(M / rowSums(M, na.rm=T))
# Bind to original data table and save data to disk for later access.
fasta.ext <- bind_cols(fasta.table, M)
write_delim(
  subset(fasta.ext, select=-c(Header, Sequence, Serotype, H.type)), 
  path='~/Desktop/stin300/data/Lmers_data.txt', delim=';'
)

# Fit an LDA-model to these data, using the N-types as response (class-labels). Make a plot of the 
# cases as points in the space of linear discriminants (we did this in week 2-3). Map colors to the 
# N-types.

# Select only the cases for N-types N1, N3 and N6. 
idx <- which(fasta.ext$N.type %in% c('N1', 'N3', 'N6'))
# Skip `Header` as a feature and convert categorical variables into factors.
X <- (
  fasta.ext[idx, ]
  %>% subset(select=-c(Header, Sequence, Serotype, H.type))
  #%>% mutate(Sequence=factor(Sequence), Serotype=factor(Serotype), H.type=factor(H.type))
)
# Set selected the N-types as response labels.
y <- factor(fasta.ext$N.type[idx], levels=unique(fasta.ext$N.type))
# Traing an LDA model.
lda.mod <- lda(N.type ~ ., data=X)

