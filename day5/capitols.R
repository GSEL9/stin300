# Exercise: European capitols
# From babynames compute how many children have been given names of some 
# european capitols over the years. 
capitols <- c("Oslo", "London", "Paris", "Vienna", "Rome", "Madrid", "Athens")
# Hint1: Use the operator %in% (search internet for help). Next, sum the 
# number of children with each name, and make a plot like above (geom_col()), 
# but with log-transformed y-axis. Also, try to make the capitols appear in 
# ascending order by the number of children. Hint2: Use reoorder() by the sum 
# of children).

library('tidyverse')

data('babynames')

cap.names <- (
  babynames
  %>% filter(name %in% capitols)
  %>% group_by(name)
  %>% summarise(count=n())
  %>% arrange(desc(count))
  %>% mutate(name=factor(name))
)
fig <- ggplot(cap.names) + geom_col(
  aes(x=reorder(name, -log(count)), y=log(count))
)
print(fig)