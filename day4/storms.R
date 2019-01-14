data('storms')

storms.stat <- (
  storms 
  %>% group_by(category)
  %>% summarise(max_wind=max(wind), min_wind=min(wind))
)

storms.cases <- (
  storms
  %>% group_by(name)
  %>% summarise(counts=n())
  %>% arrange(desc(counts))
)
cases.hist <- ggplot(storms.cases) 
cases.hist <- cases.hist + geom_histogram(
  mapping=aes(x=counts), bins=101
)
cases.hist <- cases.hist + labs(x='Name', y='Counts')

sel.stat <- (
  storms
  %>% group_by(name)
  %>% summarise(
    wind.mean=mean(wind), wind.std=sd(wind), counts=n()
  )
  %>% arrange(desc(counts))
  %>% subset(counts > 40)
)
# TODO:
# Make plots of both mean wind and its standard deviation against this 
# duration, to see if longer storms have stronger wind and/or more variable 
# wind. Add trend curves to both plots, and put them into the same figure
fig <- ggplot(sel.stat) + geom_point(aes(x=count))
fig <- fig + facet_grid(rows=vars(wind.mean))
fig <- fig + facet_grid(cols=vars(wind.std))
print(fig)


pal <- colorRampPalette(
  c('yellowgreen', 'blue', 'orange', 'pink', 'plum4', 'darksalmon')
)
fig <- ggplot(storms)
fig <- fig + geom_point(
  aes(x=lat, y=long, color=wind, size=1, alpha=0.1), 
  shape=15
)
fig <- fig + scale_color_gradientn(colors=pal(50))
print(fig)