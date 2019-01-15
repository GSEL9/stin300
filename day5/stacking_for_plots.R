# Make a script that plots the variables Temp, Wind and Ozone against Day 
# as curves in the same panel, and give each variable a separate color. Do 
# this for all Months, but each month should appear in a separate panel, as 
# in the figure below. 
#
# Hint: Gather data such that Ozone, Wind and Temp are stacked before you plot.

air.new <- gather(airquality, key='Type', value='Value', c(1, 3, 4), convert=T)

# Month labels:
month.lbls <- c(`5`='5', `6`='6', `7`='7', `8`='8', `9`='9')
facets <- facet_wrap(vars(Month), labeller=as_labeller(month.lbls))

fig <- ggplot(air.new) + geom_path(mapping=aes(x=Day, y=Value, color=Type))
fig <- fig + facets
print(fig)