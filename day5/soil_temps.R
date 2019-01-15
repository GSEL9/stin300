# Exercise: Soil temperatures
# Make a script where you first load the data from a file on the web by
load(url("http://arken.nmbu.no/~larssn/teach/stin300/soiltemp.RData"))
# The file contains a table with daily measurements of soil temperatures at five 
# different depths through 2017. The integer in the column name indicates the 
# depth, in cm.
# * Make it a tidy data set by gathering temperatures and plot the temperatures 
#   from each depth against Day. Make use of some select-helper function.
soil.new <- (
  soiltemp 
  %>% drop_na(contains('T')) 
  %>% gather(
    key='Type', value='Temp',
    contains('T'), 
    convert=T
  )
  %>% mutate(Type=factor(Type, levels=unique(soil.new$Type)))
  %>% subset(Temp > -5)
)
# * There may be some very strange measured values, try to filter out these as 
#   well. 
type.lbls <- c(
  `T.soil.5`=5, 
  `T.soil.10`=10, 
  `T.soil.20`=20, 
  `T.soil.50`=50, 
  `T.soil.100`=100
)
facets <- facet_wrap(vars(Type), labeller=as_labeller(type.lbls))

fig <- ggplot(soil.new, aes(colour=Type)) + geom_path(
  mapping=aes(x=Day, y=Temp)
)
fig <- fig + facets
print(fig)