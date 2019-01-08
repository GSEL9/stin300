# -*- coding: utf-8 -*_
#
# beer_can_plot.R
# 

library(tidyverse)

# Exercise: Beer-can plot
# Extend the beer-can exercise by plotting the area against the height, using geom_line().
# Start out by creating a tibble containing only a column with Height:
beercan <- tibble(Height=seq(from=1, to=30, by=0.1))
# Add calculated radiuses to the tibble.
beercan$Radius <- sqrt(500 / (pi * beercan$Height))
# Add calculated areas to the tibble.
beercan$Area <- 2 * pi * beercan$Radius^2 + 2 * pi * beercan$Radius * beercan$Radius

fig <- ggplot(beercan) + geom_line(mapping=aes(x=Area, y=Height))
fig <- fig + labs(title='Beercan heigh vs. area')
print(fig)

can.dense <- ggplot(beercan) + geom_density(mapping=aes(x=Area), fill='blue', alpha=0.3)
can.dense <- can.dense + labs(x='Area', y='Density', title='Beercan area density plot')
print(can.dense)