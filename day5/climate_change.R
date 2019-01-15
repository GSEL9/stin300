# Exercise: Climate change
# Here is Norways longest series of monthly temperatures, measured at our 
# University since 1874:
load(url("http://arken.nmbu.no/~larssn/teach/stin300/aas.monthly.RData"))
# This data set ends in 2012. Your job is to add more data to this table. 
# Here are daily temperature data from 1988 to 2017:
load(url("http://arken.nmbu.no/~larssn/teach/stin300/daily.RData"))
# From the latter, add the data for 2013-2017 to the first table. 
# The table aas.monthly is perhaps not a tidy data set? Fix this, and make a 
# graphical display to indicate if we can see any sign of a warmer climate 
# here at Ås.

# Here is an updates version of the solution we started, and almost finised, 
# in our Friday-session:

daily.to.month <- (
  daily
  %>% subset(Year >= 2013)
  %>% group_by(Year, Month)
  %>% summarize(Temp.avg=mean(Temp, na.rm=T))
  %>% spread(key=Month, value=Temp.avg)
)
colnames(daily.to.month) <- colnames(aas.monthly)                
aas.monthly <- bind_rows(aas.monthly, daily.to.month)              

month.lbls <- colnames(aas.monthly)[-1]  
cpal <- colorRampPalette(
  c('blue', 'cyan', 'green1', 'green3', 'red', 'orange', 'purple')
)

temp.data <- (
  aas.monthly 
  %>% gather(
    key='month', value='temp', which(!'year'==colnames(aas.monthly)), convert=T
  )
  %>% mutate(month=factor(month, levels=colnames(aas.monthly)[-1] ))
)
fig <- ggplot(temp.data, aes(x=year, y=temp)) 
fig <- fig + geom_point(aes(color=month))
fig <- fig + geom_smooth(method='lm')
fig <- fig + scale_color_manual(values=cpal(12))
print(fig)


