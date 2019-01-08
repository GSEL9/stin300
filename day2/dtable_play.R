# -*- coding: utf-8 -*-
# 
# dtable_play.R
# 
#
# Exercise: exploring data tables
# Make a new script where you load the tidyverse. 
# The tibble named mpg should now be available to you.
library(tidyverse)
# How many rows and columns does this table have?
cat(
  'mpg table rows =', nrow(mpg),
  '\nmpg table columns =', ncol(mpg)
)
# What are the data types in each column? 
print(sapply(mpg, class))
# COMMENT: Applies the function `class()` to each column of mpg producing the
# column data type.

# From previously we saw the data.frame named iris. 
# If you do the same in the Console window with this, you immediately see a 
# difference between a tibble and a data.frame. Feed them both as input to the 
# function str(), and observe its output.
str(mpg)
str(iris)
# To get a quick overview of data in all columns, use summary(mpg) 
# directly in the Console.
summary(mpg)
# If a table has numeric columns, or columns that can be converted to numeric, 
# you can also plot the entire table. Try plot(iris) (the mpg has text columns 
# that cannot be plotted (but that is also the case for iris you may say. No. 
# The species column is not text, we will come back to this)).
plot(iris)
# Copy the first column from iris to the object iris.col1 using indexing. 
# Copy the first column of mpg to the object mpg.col1 using indexing. 
# Inspect the resulting objects. 
iris.col1 <- iris[, 1]
print(iris.col1)
#plot(iris.col1)
mpg.col1 <- mpg[, 1]
print(mpg.col1)
#plot(mpg.col1)
# Then, repeat, but use $ and column names. What can you learn from this?
byname.iris.col1 <- iris$Sepal.Length
print(byname.iris.col1)
byname.mpg.col1 <- mpg$manufacturer
print(byname.mpg.col1)
# CONCLUSION: 
# Difference between numerical indexing and indexing by name wrt. mpg tibble: 
# * Numerical indexing returns a <list>, while indexing by name returns a 
#   <character> vector.
# * Numerical indexing returns a 2D tensor (including a single column denoter), while 
#   indexing by name rturns a single vector.