# Exercise: Rolling dice
# How many times do we have to roll the dice to get five 6’s?
# We start out by rolling all five dice. After each roll, we are allowed to 
# collect some dice, and we will collect 6’s here now. Example:
# * First roll: We roll all five dice. We get the values 1,2,2,4,6. Then we 
#   collect the last die, since this is a 6.
# * Second roll: We continue rolling the remaining 4. We get 2,3,6,6. We 
#   collect the two last, with the value 6.
# * Third roll: We continue rolling the remaining 2. We get 1,5. No six’es to 
#   collect this time.
# * Fourth roll: We continue rolling the remaining 2…and so on until all five
#   dice show a 6.
# How many times do we have to roll before all dice have been collected?

n.dice <- 5; n.trails <- 1
while (n.dice > 0) {
  d <- sample(1:6, size = n.dice, replace = TRUE)
  num.scores = sum(d == 6)
  n.dice <- n.dice - num.scores
  n.trails <- n.trails + 1
}
print(n.trails)