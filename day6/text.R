# Exercise: Finding L-mers
# A popular way of describing how a DNA sequence look like, is to count how 
# many times we observe all overlapping ‘words’ of a certain length in the 
# sequence. Such ‘words’ of length L are called L-mers. Here is a DNA sequence:
#   'ATGCCTAGGTCCATGGTACAACCCTACGCATGCACGATTCATTTTAAAGAC'
# If we want to find all 2-mers, we start at the first letter, and the first 
# 2-mer is "AT", then we jump 1 position, and the next is "TG". Then we jump 
# 1 position again, and find "GC", and so on until the end of the sequence. 
# Notice that such L-mers overlap each other, and if the DNA sequence has N 
# characters, there are always N-L+1 K-mers.

s <- c('ATGCCTAGGTCCATGGTACAACCCTACGCATGCACGATTCATTTTAAAGAC')

L <- 3
mers <- c()
n_iter <- str_length(s) - L + 1
for (i in 1:n_iter) {
  mers[i] <- str_sub(s, start=i, end=i + L - 1)
}


# Exercise: Weather data again
# In the weather data table from above, several columns contain numeric data, 
# but was read as texts because the decimal symbol is a comma instead of a dot.
# Let us fix this now.
daily16.raw <- read_delim(
  'http://arken.nmbu.no/~larssn/teach/stin300/Daily2016.txt', delim='\t'
)
daily17.raw <- read_delim(
  'http://arken.nmbu.no/~larssn/teach/stin300/Daily2017.txt', delim='\t'
)
old.cols <- c('DATO', 'LT', 'RF', 'VH', 'VR', 'JT10', 'GLOB')
new.cols <- c(
  'Date', 'Air.temp', 'Humidity', 'Wind.speed', 'Wind.direction', 
  'Soil.temp.10cm', 'Radiation'
)
daily16 <- daily16.raw %>% select(one_of(old.cols)) 
daily17 <- daily17.raw %>% select(one_of(old.cols)) 

colnames(daily16) <- new.cols
colnames(daily17) <- new.cols

daily <- daily16 %>% bind_rows(daily17) %>% mutate(Date=dmy(Date))

# Use str_replace() to replace all "," (comma) with "." (dot), and then coerce 
# to numeric. This should be done for columns 
# * Air.temp
# * Wind.speed
# * Soil.temp.10cm 
# * Radiation

daily <- (
  daily 
  %>% mutate(
    Air.temp=as.numeric(str_replace(Air.temp, ',', '.')),
    Wind.speed=as.numeric(str_replace(Wind.speed, ',', '.')),
    Soil.temp.10cm=as.numeric(str_replace(Soil.temp.10cm, ',', '.')),
    Radiation=as.numeric(str_replace(Radiation, ',', '.'))
  )
  %>% mutate(
    Wind.direction=str_replace(Wind.direction, '[^SNV]', 'E')
  )
  %>% mutate(
    Wind.direction=str_replace(Wind.direction, '[^SNE]', 'W')
  )
)


fig <- ggplot(daily) + geom_bar(aes(x=Wind.direction))
print(fig)


