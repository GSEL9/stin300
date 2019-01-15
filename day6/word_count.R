library(readr)
library(stringr)
library(tidyverse)


poem.raw <- readLines(
  'http://arken.nmbu.no/~larssn/teach/stin300/poem_unknown.txt'
)
poem.data <- str_split(poem.raw, pattern=" ")

word.count <- numeric(length(poem.data))
for (i in 1:length(poem.data)) {
  word.count[i] <- length(poem.data[[i]])
}