library(lubridate)
library(tidyverse)

# Reading Excel-files
library(readxl)

weather <- read_excel('./stin300/data/Daily2017.xlsx')


# Exercise: Stockmarket data.
# Read sheet 3 of Emisjoner_OB_Mars_2018.xlsx into R.

emi.raw <- read_excel(
  './stin300/data/Emisjoner_OB_Mars_2018.xlsx', skip=1
)
colnames(emi.raw) <- str_replace_all(colnames(emi.raw), c(" " = "_" , "," = "" ))
colnames(emi.raw)[1] <- 'Year'
emi <- subset(emi.raw, select=-c(Repair, Stock_dividend))

fig <- ggplot(emi) + geom_point(aes(x=Year, y=Total, color=Employee))
fig <- fig + scale_y_continuous(trans='log2')
fig <- fig + labs(x='Year', y='log Total')
print(fig)


# Reading formatted text files
# * By formatted text we mean text files arranged as columns and rows, with a 
#   separator symbol between each column. You can always save data in a 
#   spreadsheet in this format (e.g. csv or tab-separated text files). 
#   This is a very ‘safe’ format for your data, since such files can always be 
#   read into all kinds of softwares.
# * The readr package in the tidyverse contains some nice functions for reading 
#   such files, but we focus only on read_delim() here. 
# * Text files can easily be read directly from internet, as long as you know 
#   the exact web-address.
library(readr)

bear.data <- read_delim('./stin300/data/bears.txt', delim='\t')

bear.web <- read_delim(
  'http://arken.nmbu.no/~larssn/teach/stin300/bears.txt',
  delim='\t'
)

# Writing a table to a formatted text file:

write_delim(bear.data, path='./stin300/data/bears_test.txt', delim=';')


# Reading text line by line
# * The FASTA format is used for biological sequence data.

lines <- readLines('./stin300/data/DNA.fasta')


# save() and load() functions

save(bear.data, lines, file='./stin300/data/bear_lines_test.RData')

# Produces a compressed file that requiring R for opening. Can be loaded
# with:

load('./stin300/data/bear_lines_test.RData')

# where the saved objects are re-created in your workspace.


# Exercise: Weather data
daily16.raw <- read_delim(
'http://arken.nmbu.no/~larssn/teach/stin300/Daily2016.txt', delim='\t'
)
daily17.raw <- read_delim(
  'http://arken.nmbu.no/~larssn/teach/stin300/Daily2017.txt', delim='\t'
)

old.cols <- c('DATO', 'LT', 'RF', 'VH', 'VR', 'JT10', 'GLOB')
new.cols <- c(
  'Date', 'Air.temp', 'Humidity', 
  'Wind.speed', 'Wind.direction', 
  'Soil.temp.10cm', 'Radiation'
)

daily16 <- daily16.raw %>% select(one_of(old.cols)) 
daily17 <- daily17.raw %>% select(one_of(old.cols)) 

colnames(daily16) <- new.cols
colnames(daily17) <- new.cols

daily <- daily16 %>% bind_rows(daily17) %>% mutate(Date=dmy(Date))
