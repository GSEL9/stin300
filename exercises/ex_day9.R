library(stringr)

############################
# Part 1a
############################

# Target symbols to count in deriving poem fingerprint info.
load(url("http://arken.nmbu.no/~larssn/teach/stin300/symbols.RData"))

poem <- readLines('./../data/poem_unknown.txt')
char.counts <- (
  poem 
  %>% str_split(pattern='')
  %>% unlist()
  %>% factor(levels=symbols)
  %>% table()
)
fprint <- char.counts / sum(char.counts)

############################
# Part 1b
############################

char_counts <- function(poem, symbols, norm=T) {
  # Takes as input a poem and a set of symbols, and 
  # outputs a numerical fingerprint.
  char.counts <- (
    poem
    %>% str_split(pattern='')
    %>% unlist()
    %>% factor(levels=symbols)
    %>% table()
  )
  
  if (norm) {
    return(char.counts / sum(char.counts))
  }
  return(char.counts)
}

############################
        # Part 1c
############################

# Training data.
load(url("http://arken.nmbu.no/~larssn/teach/stin300/poems.RData"))

n.poems <- nrow(poems)
fprints <- matrix(0, n.poems, length(symbols), dimnames=list(seq(n.poems), symbols))
for (i in 1:n.poems) {
  fprints[i, ] <- char_counts(poems$Poem[[i]], symbols)
}
poems.ext <- bind_cols(poems, as.tibble(fprints))

un.tab <- tibble(Author='Unknown', Poem=list(poem), symbols=list(fprint)
)
un.cmat <- matrix(fprint, nrow=1, dimnames=list(c(1), symbols))
unknown <- bind_cols(un.tab, as_tibble(un.cmat))
poems.data <- bind_rows(poems.ext, unknown)

save(poems.data, file='./../data/poems_data.RData')


########################################################
#          Exercise - anonymous functions
########################################################
poem <- readLines("data/poem_unknown.txt")
pchars <- str_split(poem, pattern='')
last.chars <- sapply(pchars, function(x){return(x[length(x)])})
