library('tidyverse')
library('nycflights13')

data(flights)
data(airlines)

band <- tribble(
  ~name,  ~band,  
  "Mick", "Stones",
  "John", "Beatles",
  "Paul", "Beatles"
)
artist <- tribble(
  ~plays,
  "vocals",
  "guitar",
  "bass"
)
# Concat on columns.
comb <- bind_cols(artist, band)


band2 <- tribble(
  ~band,     ~name,   
  "Stones",  "Keith",
  "Beatles", "Ringo"
)
rbound <- bind_rows(band, band2)
# Concat on rows.


# Add a row to an existing table:
band.ext <- band %>% add_row(name='Charlie', band='Stones', .before=1)
# NOTE: The option .before may be used to indicate where to input the new row.


# Merging partly different tables.
instrument <- tribble(
  ~name,  ~plays,
  "John", "guitar",
  "Paul", "bass",
  "Keith","guitar"
)
# Determine the rows int he joined table by the left input.
left_merge <- left_join(band, instrument, by='name')
# Determnie the rows in the joined table by the right input.
right_merge <- right_join(band, instrument, by='name')
# Use use full_join() to avoid loosing any rows (results in NA).
full_merge <- full_join(band, instrument, by='name')
# Only join rows who are complete across both tables (no NA).
inner_merge = inner_join(band, instrument, by='name')

# Exercise: Flight delays.
# The package nycflights13 (part of the tidyverse installation) contains a 
# tibble named flights and one named airlines. Let us use these data to find:
# Which airline company has the largest arrival delays at these New York 
# airports. In flights there is a column arr_delay with arrival delay times, 
# but there is no information about airline company. But, in airlines we have 
# this, togheter with a column of carrier data. The same carrier data are also 
# in flights!
delays <- (
  flights %>% 
  inner_join(airlines, by='carrier')
  %>% group_by(carrier) 
  # Compute average delay per airline company.
  %>% summarise(avg.delay=mean(arr_delay, na.rm=TRUE))
  # Sort with largest first
  %>% arrange(desc(avg.delay))
)

# Stacking table rows:
cases <- tribble(
  ~Country, ~"2011", ~"2012", ~"2013",
  "FR",    7000,    6900,    7000,
  "DE",    5800,    6000,    6200,
  "US",   15000,   14000,   13000
)
new.cases <- gather(
  cases, key = "Year", value = "Counts", c(2,3,4), convert = T
)
# * key (str): Name of the column created by stacking the column names.
# * value (str): Name of the column created by stacking the table values.
#
# Revert back to original format.
old.cases <- spread(new.cases, key=Year, value=Counts)
# * key (object): Specifies an existing column to spread a new column names.
# * value (object) Specifies an existing column to spread as values.


# Exercise: Gather and spread.
# The tibble named table2 is included in tidyverse. Spread this table into the 
# four columns: country, year, case and population. 
new.table2 <- spread(table2, key=type, value=count)
# Spreading count values by type renders two columns.
# 
# The tibble named table4a is included in tidyverse. Gather this table into 
# the three columns country, year, cases. 
new.table4a <- gather(table4a, key='year', value='cases', c(2, 3), convert=T)
# Do similar for table4b, gather into country, year, population. 
new.table4b <- gather(table4b, key='year', value='cases', c(2, 3), convert=T)
# Join the two tables by both country and year. The result should again be 
# identical to table1.
merge.table4 <- inner_join(
  new.table4a, new.table4b, by=c('country', 'year')
)


# Filtering missing data
pollution <- tribble(
  ~City,        ~Size, ~Amount, 
 "New York", "large",      23,
 "New York", "small",      14,
 "London",   "large",      22,
 "London",   "small",      16,
 "Beijing",  "large",      121,
 "Beijing",  "small",      56  
)
# Add a missing value
pollution$Amount[4] <- NA
# Filter out the row with drop_na() function:
poll.new <- pollution %>% drop_na(Amount)
# Manually:
poll.new2 <- pollution %>% filter(!is.na(Amount))
# NOTE: Several columns can be listed in drop_na().


# Unique observations
unique.cities <- pollution %>% distinct(City)
# Retaining original columns:
unique.cities2 <- pollution %>% distinct(City, .keep_all = T)

# Multiple-column handling:
# The `select_helpers` functions enables quickly naming multiple columns.
# Applying operations to multiple columns:
poll.new3 <- pollution %>% drop_na(starts_with('A')) 
a.cols <- pollution %>% select(starts_with('A'))
# See also:
# * ends_with() 
# * contains()

feat.max <- iris %>% summarise_at(vars(contains('Width')), max)