# -*- coding: utf-8 -*-
# 
# airquality.R
# 

library(tidyverse)

# Exercise: Plotting airquality
# The data set airquality is in the dataset package that always accompanies R. 
# Load it by data(airquality). Make a plot of column Temp against column Day, and use geom_line(). Try also geom_path(), and find out what is the difference between these two geoms.
# This plot was not very pretty. We will see later how we can improve on this.

fig <- ggplot(airquality) + geom_line(mapping=aes(x=Temp, y=Day))
print(fig)

fig2 <- ggplot(airquality) + geom_path(mapping=aes(x=Temp, y=Day))
print(fig2)

# NOTE scale_ functions: Scaling aesthetics e.g. scale the axis or map to some other colors.

# Exercise: Scaling colors manually.
cols <- c('red', 'green', 'blue', 'cyan', 'orange', 'black', 'yellow')
fig.scale <- ggplot(mpg) + geom_point(mapping=aes(x = displ, y = hwy, color=class))
fig.scale <- fig.scale + scale_discrete_manual('colour', values=cols)
fig.scale <- fig.scale + labs(x='displ', y='hwy')
print(fig.scale)