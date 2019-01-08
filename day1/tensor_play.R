# -*- coding: utf-8 -*_
#
# tensors.R
# 
# NB: R counting logic starts at one (not zero)!!!

# Defining a vector of characters.
names <- c('Lars', 'Jon Olav', 'Torgeir')
# Defining a vector of integers ranging from a to b.
ints <- 1:10
cat(
  'Data type string tensor', typeof(names), 
  '\nData type numerical tensor', typeof(ints), '\n'
)
# Slicing a vector.
print(ints[1:4])
# Defining a range of floats.
seqs <- seq(from=0.1, to=100, by=0.1)
print(seqs[1:4])

# Concatenating two vectors.
concat = c(ints, seqs)
# Display the integer part.
print(concat[1:4])
# Display the float part.
print(concat[951:991])

# Exercise
# Create a vector x consisting of the integers from 10 to 20. 
x <- 10:20
#print(x)
# Copy elements number 2 to 4 from x to a new vector named y. 
y <- x[2:4]
#print(y)
# Copy elements 10 to 15 from x to another new vector z. 
z <- x[10:15]
print(z)
# NOTE: No error/warning is raised when slicing elements outside
# the size of x. Adds NA to the missing elements.
# Copy and fill in the gaps:

n <- length(x)
print(n)

# NOTE: Dots can be used as in normal name to explain e.g. steps 
# performed in transforming a variable.
vector <- c(1, 2, 5)
# Name the vector elements.
named.vector <- c(Monday = 1, Tuseday = 2, Friday = 5)
print(named.vector)

# Vectorizing
v1 <- c(1, 2, 3)
v2 <- c(3, 2, 1)
vsum <- v1 + v2
print(vsum)


v3 <- 10 + v1
print(v3)
