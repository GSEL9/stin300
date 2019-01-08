# -*- coding: utf-8 -*_
#
# beer_can.R
# 

# Exercise: beer-can design
# We want to produce an ecological beer-can, using as little 
# aluminium as possible. Each beer-can must have a cylindrical 
# shape, and the volume of the beer-can must always be 0.5 
# litres (500cm3). The amount of aluminium used is proportional 
# to the surface area of the beer-can, i.e. we want a beer-can
# with as little surface area as possible, but still under the
# restriction that it must contain 500cm3.
#
# Make a script where you give a value to the can height (in cm), 
# and then computes the radius of the cylinder from the 
# volume-restriction. The formula for the volume of a 
# cylinger is V=πr2h where r is the radius and h is the height. 
# This means r=√(V/(πh)), and since the volume is always V=500
# you compute the radius for any given height.
#

cylinder_radius <- function(height) {
  # Returns the radius of a cylinder with volume of 500 cm3
  # given the cylinder height.
  # 
  # Args:
  # - height (cm)
  radius = sqrt(500 / (pi * height))
  return(radius)
}

# Then you compute the surface-area of the corresponding beer-can. 
# The formula for the surface area of a cylinder is A=2πr2+2πrh
# where r is the radius and h is the height. The constant π is 
# already defined and is named pi in R.

surface_area <- function(radius, height) {
  # Returns the surface-area  of a cylinder given the cylinder 
  # height and radius.
  # 
  # Args:
  # - radius (cm)
  # - height (cm)
  area = 2 * pi * radius^2 + 2 * pi * radius * height
  return(area)
}

# Make a vector of different heights, and compute a vector of 
# areas. Find approximately the optimal ecological beer-can 
# height by first using the function which.min() on the 
# computed areas, and then use this result to print the 
# optimal height.

# SETUP:
heights <- seq(from=1, to=30, by=.1)
radiuses <- cylinder_radius(heights)
areas <- surface_area(radiuses, heights)
best_setup_idx = which.min(areas)

# RESULTS:
cat(
  #'Candidate areas:', areas,
  '\nOptimal surface-area:', areas[best_setup_idx],
  '\nOptimal height', heights[best_setup_idx],
  '\nOptimal radius', radiuses[best_setup_idx]
)
# CONCLUSION: Optimal setup is given at index 77.