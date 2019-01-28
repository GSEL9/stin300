################################################################
#           Exercises - classification of bacteria 
################################################################

library(MASS)
library(dplyr)
library(readr)
library(ggplot2)
library(tidyverse)

# Part A
phyla.raw <- read_delim('./../data/three_phyla.txt', delim='\t')

fig <- ggplot(phyla.raw) + geom_point(aes(x=Size, y=GC, color=Phylum))
print(fig)


N <- nrow(phyla.raw)
prior.probas <- table(phyla.raw$Phylum) / N
print(prior.probas)


# Part B
test.cases <- sample(1:N, size=1000)

X.train <- as.matrix(subset(phyla.raw, select=-c(Phylum))[-test.cases, ])
X.test <- as.matrix(subset(phyla.raw, select=-c(Phylum))[test.cases, ])

X.train.std <- scale(X.train, center=T, scale=T)
#X.test.std <- scale(
#  X.test, center=attr(X.train.std, 'scaled:center'), scale=attr(X.train.std, 'scaled:scale')
#)
X.train.std <- scale(X.train)
cent <- attr(X.train.std, 'scaled:center')
std <- attr(X.train.std, 'scaled:scale')
X.test.std <- t(X.test) - cent
X.test.std < -X.test.std / std
X.test.std <- t(X.test.std)

y.train <- as.vector(phyla.raw$Phylum)[-test.cases]
y.test <- as.vector(phyla.raw$Phylum)[test.cases]

# Part C
lda.mod <- lda(X.train.std, y.train, prior=c(0.08670415, 0.34681662, 0.56647923 ))
y.pred <- predict(lda.mod, X.test.std)$class
names(y.pred) <- 'pred'

results <- data.frame(test=y.test, pred=y.pred, as.data.frame(X.test.std))

fig <- ggplot(results) + geom_point(aes(x=Size, y=GC, color=pred==test))
print(fig)

cmat <- table(results$test, results$pred)
print(cmat)

acc <- sum(results$test == results$pred) / nrow(results) * 100
print(acc)

knn.mod <- knn(X.train.std, y.train)


