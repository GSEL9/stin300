# -*- coding: utf-8 -*-
#
# plotting.R
#
# Get info on a data set: ?<dataset>. E.g. ?mpg/?iris.

library(tidyverse)

# Plot the values of the hwy column against the displ column.
# - Create the figure object.
fig <- ggplot(mpg) 
# - Build the figure by including a scatter plot (geom_point()). 
# NOTE: 
# * Functions starting with `geom` (ref. geoms) specify types of plots. 
# * All geoms require a mapping stating which columns from the tibble to plot. 
# * The aes() function sets up the mapping from some aesthetics. Aesthetic mapping: describe 
#   how variables in the data are mapped to visual properties (e.g. positions of markers, 
#   their colors, shapes, sizes etc.).
fig <- fig + geom_point(mapping=aes(x=displ, y=hwy))
print(fig)
# - Add color labelling to each class which automatically adds a legend.
fig <- fig + geom_point(mapping=aes(x=displ, y=hwy, color=class))
print(fig)
# - Color each label.
#fig <- fig + geom_point(mapping = aes(x=displ, y=hwy, color='darkgreen'))
fig <- fig + geom_point(mapping=aes(x=displ, y=hwy), color='darkgreen')
print(fig)

# Exercise: Mapping and setting colors. 
# Producing two plots
fig1 <- ggplot(mpg) + geom_point(mapping=aes(x=hwy, y=displ), color='blue')
print(fig1)
fig2 <- ggplot(mpg) + geom_point(mapping=aes(x=hwy, y=displ, color='blue'))
print(fig2)
# COMMENT: The resulting plots differ because in the latter case (fig2), the aes() 
# function maps the aesthetic arguments to a specific column, while the same aesthetic 
# arguments passed to geom_X() function requires specifying color/size/shape directly.
# 
# Exercise: mapping to other aesthetics
# Color is not the only aesthetic. Try to map the class data to shape and size as well.
aes.setup <- aes(x=hwy, y=displ, color=class, size=class, shape=class)
fig.ext <- ggplot(mpg) + geom_point(mapping=aes.setup)
print(fig.ext)
# NOTE:
# * Using size with discrete variable is not advised.
# * The shape palette can only deal with a maximum of 6 discrete values.
#
# You may also use more than one of these aesthetics in the same plot. Change the plot 
# to map class to color and manufacturer to shape.
aes.setup <- aes(x=hwy, y=displ, color=class, shape=manufacturer)
fig.ext <- ggplot(mpg) + geom_point(mapping=aes.setup)
print(fig.ext)
# The class is a discrete variable, but you may also map aesthetics to columns with continuous 
# data. Try to map color to cty instead. This is city-miles per gallon, and we expect this to be highly 
# correlated with hwy. Is it? 
aes.setup <- aes(x=hwy, y=cty, color=manufacturer)
fig.ext <- ggplot(mpg) + geom_point(mapping=aes.setup)
print(fig.ext)

# Correlation plot by multiple figure configurations.
fig <- ggplot(mpg, aes(x=displ, y=hwy))
fig <- fig + geom_point(mapping=aes(color=class))
fig <- fig + geom_smooth(method='lm')
print(fig)

# Exercise: Histogram
# Make a histogram of the hwy column in the mpg data using ggplot(). Use the Cheatsheet to 
# find out how to code this. Try to add color to this by mapping to class again. 
# Hint: Try fill as an alternative to color.
hist <- ggplot(mpg) + geom_bar(mapping=aes(x=hwy, fill=class))
print(hist)

# Box plot
boxp <- ggplot(mpg) + geom_boxplot(mapping=aes(x=class, y=hwy, colour=class))
print(boxp)

barp <- ggplot(mpg) + geom_bar(mapping=aes(x=class, fill=class))
print(barp)

colp <- ggplot(mpg) + geom_col(mapping=aes(x=class, fill=class))
print(barp)
# NOTE:
# * geom_bar() makes the height of the bar proportional to the number of cases in each 
#   group (counts).
# * geom_col() represents the values in the data by the heights of the bars.

# Exercise: Describing trends
# We saw today that we can easily add a trend-line to a scatter-plot to describe 
# trends in the data, using the function geom_smooth().
# Here is a simple plot of some data from the data set mtcars (always available in R) 
# where we have added a trend-curve. Try to make the code behind this figure before you 
# inspect it here. Hint: Read the Help for geom_smooth().
fig <- ggplot(mtcars, aes(x=wt, y=mpg)) 
fig <- fig + geom_point(mapping=aes(color=cyl))
fig <- fig + geom_smooth(method='loess')
fig <- fig + labs(x='Weight (1000 lbs)', y='Miles per gallon')
print(fig)

