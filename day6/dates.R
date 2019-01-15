
library(lubridate)


today <- as.Date('14.01.19', format = '%d.%m.%y')
exam <- as.Date('2019/01/29', format = '%Y/%m/%d')
print(exam - today)

# The Date type is just a thin extension of a more basic data type known as 
# POSIXct.

now <- as.POSIXct('14-01-19 08:33:10', format = '%d-%m-%y %H:%M:%S')
exam <- as.POSIXct('2019.01.29 09:00:00', format = '%Y.%m.%d %H:%M:%S')
print(difftime(exam, right.now, units='hours'))
print(difftime(exam, right.now, units='days'))

# Specify a date with the ymd() function.

easter.sunday <- ymd('2019-04-21')
midsummer <- dmy('23/06-19')
exam <- ymd(2019291)
print(midsummer - easter.sunday)

# Extract components from a Date object:

year <- year(easter.sunday)
month <- month(easter.sunday)
day <- day(easter.sunday)
cat('year: ', year, '\nmonth:', month, '\nday:', day)


# Exercise: dates.
# Make a vector of dates, containing the 14th of each month this year. 
# Then, find the weekdays of these dates. 

dates <- c(
  dmy('14/1-2019'), dmy('14/2-2019'), dmy('14/3-2019'), dmy('14/4-2019'), 
  dmy('14/5-2019'), dmy('14/6-2019'), dmy('14/7-2019'), dmy('14/8-2019'), 
  dmy('14/9-2019'), dmy('14/10-2019'), dmy('14/11-2019'), dmy('14/12-2019')
)
weekdays(dates)