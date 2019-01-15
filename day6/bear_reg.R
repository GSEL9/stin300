# Exercise: Simple linear regression

library(readr)
library(tidyverse)

bear.data <- read_delim(
  'http://arken.nmbu.no/~larssn/teach/stin300/bears.txt', delim='\t'
)

fit.mod <- lm(Weight~Length, data=bear.data)
print(fit.mod$coefficient)

bear.data$Weight.fit <- fit.mod$fitted.values

fig <- ggplot(bear.data, aes(x=Length))
fig <- fig + geom_point(aes(y=Weight), color='brown', size=4)
fig <- fig + geom_line(aes(y=Weight.fit), color='steelblue', size=3, alpha=0.5)
print(fig)