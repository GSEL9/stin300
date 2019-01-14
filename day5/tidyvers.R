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