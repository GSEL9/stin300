# -*- coding: utf-8 -*-
# 
# multipanel_plots.R
# 

library(tidyverse)

airq.5 <- subset(airquality, airquality$Month == 5)

# Multi-graph plot
mulp <- ggplot(airq.5, aes(x=Day))
mulp <- mulp + geom_line(aes(y=Temp), color='maroon')
mulp <- mulp + geom_line(aes(y=Wind), color='steelblue')
mulp <- mulp + geom_line(aes(y=Ozone), color='seagreen')
mulp <- mulp + labs(y='', x='Day' )
print(mulp)


# Exercise: Airquality
# From the airquality data set, plot Day (x-axis) against Temp (y-axis) as we did 
# this morning, using geom_path(). Map color to the Month column, but first coerce 
# it to a factor.
airquality$Month = factor(airquality$month)
arq.fig1 <- ggplot(airquality) + geom_path(mapping=aes(x=Day, y=Temp, color=Month))
print(arq.fig1)
# Notice the difference in how the data are organized in the two cases of 
# multi-plots:
# * In the first case from above we plotted several variables, i.e. data were 
#   organized as separate columns.
# * In this exercise we plotted several subsets of the same variable, i.e. data 
#   were stacked into one column, and we used a factor to specify subsets.
# In general, the latter organization is often the best for using ggplot! 

# Facet plot
# Mapping month labels to factor levels.
month_lbls <- c(`5`='May', `6`='June', `7`='July', `8`='August', `9`='September')
facets <- facet_wrap(vars(Month), scale='free', labeller=as_labeller(month_lbls)) 
arq.fig2 <- ggplot(airquality) 
arq.fig2 <- arq.fig2 + geom_path(mapping=aes(x=Day, y=Temp))
arq.fig2 <- arq.fig2 + facets
print(arq.fig2)
# NOTE:
# * scale='free': equiv to not sharing y-axis in subplots.
# * facet_wrap splits a data set into subsets.

# Subplots
#library(cowplot)

bar <- ggplot(mpg) + geom_bar(aes(x = manufacturer)) 
bar <- bar + coord_flip() + labs(x='', y='', title='Bar-chart')

mpg %>% group_by(manufacturer) %>% summarise(Counts = n()) -> mpg.sum

pie <- ggplot(mpg.sum) 
pie <- pie + geom_bar(aes(x='', y=Counts, fill=manufacturer), stat='identity', width=1)
pie <- pie + labs(x='', y='', title='Pie-chart') + coord_polar(theta='y')

cowplot::plot_grid(bar, pie, nrow=1, align='h')
# NOTE: 
# Enables using cowplot plot_grid() function without loading the package. Typically,
# want to avoid loading the cowplot package as it changes some settings in ggplot.

# Exercise: Fuel consumption
# From the mtcars data, plot Mileage per gallon (mpg) versus engine size (disp) 
# as large points (size = 3). 
# * Color by number of cylinders (cyl), but first coerce  this into a factor, 
#   and store it as a new column Cylinders in the table.
# * Split into panels by number of gears (gear). 
# * Add labels to the plot, i.e."Engine size" on the x-axis, 
#  "Mileage per gallon" on the y-axis and "3 gears", 
#  "4 gears" etc, in the panel headers. 
# * Add a linear trend curve to each panel.
mtcars$Cylinders <- factor(mtcars$cyl)
gear_lbls <- c(`3`='3 gears', `4`='4 gears', `5`='5 gears')
facets <- facet_wrap(vars(gear), labeller=as_labeller((gear_lbls)))
fig <- ggplot(mtcars, aes(x=mpg, y=disp))
fig <- fig + geom_point(mapping=aes(size=3, color=Cylinders))
fig <- fig + geom_smooth(method='lm')
fig <- fig + facets
fig <- fig + labs(x='Engine size', y='Mileage per gallon')
print(fig)

# Exercise: Visualize distributions
# Visualize the distribution of the Sepal.Length column in the iris data. 
# Such visualization of continuous data can be done is various ways by ggplot(). 
# * Make first a histogram (geom_histogram()), then a density (geom_density()) 
#   and then with polygons (geom_freqpoly()). 
# * Plot all three plots together using cowplot::plot_grid(). 
# * Experiment with the aesthetics color and fill in the plots.
vec <- iris$Sepal.Length
hist <- ggplot(iris, aes(x=vec)) + geom_histogram(bins=35, fill='maroon')
hist <- hist + labs(x='Sepal Length', title='Histogram')
dense <- ggplot(iris, aes(x=vec)) + geom_density(color='steelblue')
dense <- dense + labs(x='Sepal Lengtht', title='Density')
poly <- ggplot(iris, aes(x=vec)) + geom_freqpoly(bins=35, color='darkblue')
poly <- poly + labs(x='Sepal Length', title='Polygon')
cowplot::plot_grid(hist, dense, poly, nrow=1, align='h')
