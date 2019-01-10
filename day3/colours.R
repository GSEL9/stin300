# -*- coding: utf-8 -*-
#
# colours.R
#

library(tidyverse)

# Exercise: The RGB-colors.
clrs <- rgb(red=0.2, green=0.4, blue=0.4)
fig <- ggplot(tibble(1)) + geom_point(mapping=aes(x=1, y=1), size=100, colour=clrs)
print(fig)


# Exercise: Colors as hexadecimal strings.
# rgb(0.1, .2, .3) => "#1A334D" where
# * `#` denotes a hexadecimal number follows
# * red = 0.1 = 1A, blue = 0.2 = 33, green = 0.3 = 4D
# Also, rgb(0, 0, 0) => #000000, rgb(1, 1, 1) => #FFFFFF. Thus, 
# #88A50F gives
# * red = 8 * 16^1 + 8 * 16^0
# * blue = 10 * 16^1 + 5 * 16^0
# * green = 0 * 16^1 + 15 * 16^0
clrs <- rgb(red=136/317, green=165/317, blue=16/317)
fig <- ggplot(tibble(1)) + geom_point(mapping=aes(x=1, y=1), size=100, colour=clrs)
print(fig)


# Exercise: Vector of colors.
# Earlier today we made a plot of some data from the mpg data set, and 
# added manual colors. Instead of naming a set of 7 colors, use the rgb() 
# function to create colors where green and blue are fixed at 0.5, and where 
# red varies from 0 to 1, over 7 equally spaced values. 
# HINT: Use the seq() function to create a vector of equally spaced values.
from=0; to = 1; n=7
reds <- seq(from=from, to=to, by=(to - from) / (n - 1))
colours <- rgb(red=reds, green=0.5, blue=0.5)

fig <- ggplot(mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=class))
fig <- fig + scale_discrete_manual('colour', values=colours)
print(fig)

# Exercise: Color palettes.
# A color palette is a function that produces a set of colors given some 
# input. Here is an example of a built-in palette: cols <- rainbow(8). The 
# function rainbow() will produce a range of colors, and the input 8 means 
# it creates eight different colors this time. These will be stored as a 
# vector of colors in the object cols. We can now use this vector when we plot.
# Different palettes produce different colors. W
# e typically use palettes when we want the colors to change gradually, 
# e.g. when mapping color to some continuous variable.  
# The ggplot tends to interpret numeric variables as continuous. The 
# column cty is numeric, hence, colors vary gradually according to some 
# palette, here from black to blue.
# Make the same plot as above, but use the rainbow() palette instead. 
# HINT: Add a layer of scale by scale_color_gradientn(), and use ranibow() 
# to specify its colours.
fig <- ggplot(mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=cty)) 
fig <- fig + scale_color_gradientn(colors=rainbow(10))
print(fig)
# NOTE: ggplot tends to interpret numeric variables as continuous.

# Exercise: Making your own palette.
# You can easily create your own palette function! Let us replace rainbow() 
# by a function that interpolates between the colors green-yellow-orange-red. 
# We use the function colorRampPalette() to make the palette, i.e. this 
# function builds another function! The function colorRampPalette should be
# given a vector of named colors green-yellow-orange-red, and will construct a
# function that interpolates between these. Store the result in my.palette. 
# Thus, my.palette is now a function, not an object.
clrs <- c(
    'yellowgreen', 'red', 'blue', 'orange', 'pink', 'royalblue'
)
custom.palette <- colorRampPalette(clrs)
fig <- ggplot(mpg) + geom_point(mapping=aes(x=displ, y=hwy, color=cty))
fig <- fig + scale_color_gradientn(colors=custom.palette(10))
print(fig)