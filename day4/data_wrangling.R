#
#
#

library('tidyverse')
library('babynames')

data('airquality')

temp <- airquality$Temp

# No piping:
temp.may <- subset(temp, airquality$Month==5)
may.mean <- mean(temp.may)

# Piping:
temp %>% subset(airquality$Month == 5) %>% mean() -> may.mean
# NOTE:
# * The object temp is given as input to the function subset() through the pipe.
# * The output from subset() is a numeric vector, which is a valid input to
#   mean().
# * Assign the result to may.temp using the reversed arrow '->'. The reversed
#   assignement operation is not unique for pipelining, but can also be used 
#   elsewhere.

# Alternative piping:
may.mean <- temp %>% subset(airquality$Month == 5) %>% mean() 

# No piping:
data <- select(babynames, year, name, n)
# Piping:
data <- babynames %>% select(year, name, n) 
# * Pipe the tibble named babynames into select().
# * select() must also have information about which columns to keep.

# Rows subset selection with slicing:
data.subset <- babynames %>% slice(1:10)

# Conditional subset selection with filtering:
data.filtered <- babynames %>% filter(name=='Opal')
# * The first argument to filter() comes through the pipe, while the second 
#   argument must be a logical vector having n() elements indicating which rows 
#   to keep.

name.counts <- (
  babynames 
  %>% group_by(babynames$name) 
  %>% summarise(count=n()) 
)
most.pop <- max(name.counts$count)

# Sorting: Sortins in ascending order by default.
sorted.names <- babynames %>% arrange(name)
sorted.year <- babynames %>% arrange(year)
# Sorting in descending order.
desc.n <- babynames %>% arrange(desc(n))

# Exercise: Babynames
# * From babynames find the names (only) where prop is greater than or equal 
#   to 0.08
point8.prop <- filter(babynames, prop >= 0.08)
prop.names <- point8.prop$name
# point8.prop.names <- filter(babynames, prop >= 0.08)$name
# * From babynames find all cases with the name "Oslo"
from.oslo <- filter(babynames, name == 'Oslo')
# * Make a pipeline that:
# - Filter cases to just girls born in 2015
# - Then select the name and n column
# - Then sort cases such that the most popular (largest n) names are at the top
pop.names <- (
  babynames 
  %>% filter(sex=='M', year==2015)
  %>% select(name, n)
  %>% arrange(desc(n))
)

# Missing data:
vec <- c(1, 2, NA, 3, 4, NA)
where.miss <- is.na(vec)

# Logical operators.
w <- seq(from=0, to=10, by=0.5)
print(0.5 < w & w < 2)
print(w == 1 | w == 2)

# Exercise: Count missing data.
# Import the airquality data set again by data(airquality). Compute the 
# number of missing data in the Ozone column.
num.miss <- sum(is.na(airquality$Ozone))
# The number of data points not missing:
num.not.miss <- sum(! is.na(airquality$Ozon))

# Mutating table by adding extra columns
babynames2 <- (
  babynames %>% mutate(Percent=round(prop * 100, digits=2), sex=factor(sex))
)

# Compute statistics of one or several columns
# * Applied functions must accept a vector and output a scalar:
sum.stats <- babynames %>% summarise(Total=sum(n), Max=max(n))
# * Apply the same function to all columns:
sum.stats.all <- babynames %>% summarise_all(max)
# * Apply multiple functions:
sum.stats2 <- babynames %>% summarise_all(funs(min, max))
# * Perform operations on grouped data.
grp.stats <- babynames %>% group_by(sex) %>% summarise(Total=sum(n), Max=max(n))
grp.stats.all <- babynames %>% group_by(sex) %>% summarise_all(funs(min, max))
five.first <- babynames %>% group_by(name) %>% slice(1:5)
# NOTE: A table remains grouped until ungroup() is applied. Convenient for 
# grouping-ungrouping in a pipeline.

# Exercise: Babies per year.
# Use grouping to calculate and then plot the number of children born each 
# year in the babynames data. The column named n contains the number of 
# children for each name in each year. Use geom_col() when plotting.
births <- (
  babynames 
  %>% group_by(year, name)
  %>% mutate(n=sum(n), year=factor(year))
)
# ERROR:
#fig <- ggplot(births, aes(year, n, fill=name)) 
#fig <- fig + geom_col(stat='identity', position='dodge')
#fig <- fig + labs(x='Year', y='Births')
#print(fig)


# Exercise: Monthly average temperatures.
# From the airquality data, compute the average monthly temperature for all 
# months, and store this as a new table. Next, find the 3 largest 
# temperatures for each month, and store this as a table as well.
avg.temps <- (
  airquality
  %>% group_by(Month) 
  %>% summarise(avg=mean(Temp, na.rm=TRUE))
)
top3.temps <- avg.temps %>% arrange(desc(avg)) %>% slice(1:3)

# Exercise: European capitols
# From babynames compute how many children have been given names of some 
# european capitols over the years. 
# * First, filter cases with names equal to one of
capitols <- c('Oslo', 'London', 'Paris', 'Vienna', 'Rome', 'Madrid', 'Athens')
# * Next, sum the number of children with each name, and make a plot like 
#   above (geom_col()), but with log-transformed y-axis. 
# * Also, try to make the capitols appear in ascending order by the number of 
# children. Hint2: Use reoorder() by the sum of children).
cap.names <- filter(babynames, name %in% capitols)
cap.names.table <- (
  cap.names 
  %>% group_by(name)
  %>% summarise(counts=n())
  %>% mutate(log.names=log(counts))
  %>% arrange(desc(log.names))
)
fig <- ggplot(cap.names.table)
fig <- fig + geom_col(aes(x=reorder(name, -log.names), y=log.names))
fig <- fig + labs(x='Capitol', y='log Counts')
print(fig)


# Exercise: Grouping in ggplot.
# In ggplot there is also a group aesthetic that produces an explicit 
# grouping of the data. Make a boxplot of the airquality temperatures where 
# you group the data by month. Use geom_boxplot() and try to find out how to 
# make this work (read Help-file or Google).
fig <- ggplot(airquality) + geom_boxplot(aes(x=Month, y=Temp, group=Month))
fig <- fig + labs(x='Month', y='Temperatures')
print(fig)

