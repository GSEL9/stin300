# -*- coding: utf-8 -*-
#
# dtype_coercion
#

library(tidyverse)

# NOTE: Year is a discrete variable with two unique values (1999 and 2008). Coercing
# year interpretaion from <float> to <int> by converting to a factor.
mpg$year <- factor(mpg$year)
fig <- ggplot(mpg) + geom_point(mapping=aes(x = displ, y = hwy, color=year))
print(fig)