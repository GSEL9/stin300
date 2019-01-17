#
#
#

load(url("http://arken.nmbu.no/~larssn/teach/stin300/languages.RData"))


lDist <- function(x, y, na.rm=FALSE){
  # Compute the distance between two character vectors.
  
  rel <- list(c('f', 'v'), c('d', 't'))
  
  n.elems <- length(x)
  distance <- numeric(n.elems)
  for (i in 1:n.elems) {
    if (x[i] != y[i]) {
      if (x[i] %in% rel[[1]] & y[i] %in% rel[[1]]) {
        distance[i] = 0.5
      }
      else if (x[i] %in% rel[[2]] & y[i] %in% rel[[2]]) {
        distance[i] = 0.5
      }
      else {
        distance[i] = 1.0
      }
    }
  }
  return(sum(distance))
}



n.lingo <- ncol(languages)
M <- matrix(
  0, 
  nrow=n.lingo, ncol=n.lingo, 
  dimnames=list(colnames(languages), colnames(languages))
)
for (i in 1:n.lingo ) {
  x <- languages[, i]
  for (j in 1:n.lingo) {
    y <- languages[, j]
    M[i, j] <- lDist(x, y)
  }
}


tree <- hclust(as.dist(M))
par(mar = c(3, 1, 1, 10))
plot(as.dendrogram(tree), horiz=T)