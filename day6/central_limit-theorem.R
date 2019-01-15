library(tidyverse)

x.uniform <- runif(100)

hist(x.uniform, breaks=25, col='black')

N.sim <- 1000
umeans <- numeric(length=N.sim)
for (i in 1:N.sim) {
  x.uniform <- runif(100)
  umeans[i] <- mean(x.uniform, na.rm=T)
}

hist(umeans, breaks=25, col='black')