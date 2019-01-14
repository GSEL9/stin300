data('airquality')
# Exercise: Sunburn
# From the airquality data, how many days have Solar.R (radiation) above 250 
# and at the same time Ozone less than 50? If we also require Wind to be 
# between 5 and 15, how many days are then left? Make a script that computes 
# this, and print the answer.

valid.rad <- !is.na(airquality$Solar.R)
high.rad <- airquality$Solar.R > 250

valid.ozone <- !is.na(airquality$Ozone)
low.ozone <- airquality$Ozone< 50

valid.wind <- !is.na(airquality$Wind)
range.wind <- airquality$Wind > 15 & 5 < airquality$Wind 

print(
  sum(
    valid.rad & high.rad 
    & valid.ozone & low.ozone 
    & valid.wind & range.wind
  )
)
