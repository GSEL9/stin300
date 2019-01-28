#######################################################
#             Exercise - plot residuals
#######################################################

library(readr)
library(tidyverse)


bear.data <- read_delim("./../data/bears.txt", delim="\t")

lm.mod <- lm(Weight~Length, data=bear.data)
(
  bear.data 
  %>% mutate(Residuals=lm.mod$residuals)
  %>% ggplot(aes(x=Length, y=Residuals)) + geom_point() + geom_smooth(method="loess")
)



#######################################################
#             Exercise - moving average
#######################################################

bear.data <- read_delim("./../data/bears.txt", delim="\t")

y.train <- bear.data$Weight
X.train <- as.matrix(bear.data$Length)

y.test <- rep(0, nrow(X.test))
X.test <- matrix(90:190, ncol=1)

K <- 30
for(i in 1:length(y.test)){
  d <- as.vector(abs(X.test[i,] - X.train))
  idx <- order(d)
  y.test[i] <- mean(y.train[idx[1:K]], na.rm=T)
}
tb.test <- tibble(Weight.pred=y.test, Length=as.vector(X.test))

jpeg('underfitting.jpg')
fig <- ggplot(bear.data) + geom_point(aes(x=Length, y=Weight), alpha=0.3, size=3) 
fig <- fig + geom_line(aes(x=Length, y=Weight.pred), data=tb.test)
print(fig)
dev.off()


#######################################################
#             Exercise - distances
#######################################################


distMinkowski <- function(x, y, p=1) {

  return(sum((x - y)^p)^(1/p))
}


distEuq <- function(x, y) {
  return(distMinkowski(x, y, p=2))
}


distMax <-  function(x, y) {
  return(distMinkowski(x, y, p=1000))
}
 
 
X.test <- matrix(c(0.0, 0.1), nrow = 1)
X.train <- matrix(c(1.0, 1.1, 0.4, 1.2, 0.0, 1.5), nrow=3, byrow=T)

d <- matrix(0, nrow(X.train), 2)
for (i in 1:nrow(X.train)) {
  d[i, 1] <- distEuq(X.train[i, ], X.test)
  d[i, 2] <- distMax(X.train[i, ], X.test)
}
colnames(d) <- c('Euq', 'Max')

#fig <- ggplot(d)
#fig <- fig + geom_point(aes(y=Euq)) 
#fig <- fig + geom_point(aes(y=Max))
#print(fig)


# TODO: https://nmbu.instructure.com/courses/3916/files?preview=576094