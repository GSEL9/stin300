
n.dice <- 5
curr.value <- 0
target.value <- 0
while (curr.value != target.value) {
  d <- sample(1:6, size = 5, replace = T) 
  freq <- sort(table(d), decreasing = T) 
  largest.freq <- freq[1] 
  if (largest.freq >= 3) {
    target.value <- target.value + as.integer(names(freq[1]))
    n.dice <- n.dice - largest.freq.value
    target.value = 5 * largest.freq.value
  }
}