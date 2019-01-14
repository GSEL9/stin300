#
#
#
# TODO: How to get coordinates on all axes?

# Exercise: Fuel consumption.
# From the mtcars data, plot Mileage per gallon (mpg) versus engine size (disp) 
# as large points (size = 3).  (gear). Add labels to the plot, 
# i.e. "Engine size" on the x-axis, "Mileage per gallon" on the y-axis and 
# "3 gears", "4 gears",…in the panel headers. 
library('tidyverse')

# Coerce cylinders into a factor andstore it as Cylinders in the table.
mtcars$Cylinders <- factor(mtcars$cyl)

# Split the graphs into panels by the number of gears.
gear_lbls <- c(`3`='3 gears', `4`='4 gears', `5`='5 gears')
facets <- facet_wrap(vars(gear), labeller=as_labeller(gear_lbls))

fig <- ggplot(mtcars, aes(x=mpg, y=disp)) 
# Color by the number of cylinders.
fig <- fig + geom_point(mapping=aes(size=3, color=Cylinders))
# Add a linear trend curve to each panel.
fig <- fig + geom_smooth(method='lm')
fig <- fig + facets
fig <- fig + labs(x='Engine size', y='Mileage per gallon')
print(fig)
