# -*- coding: R Script -*-
#
# cylinder_volume.R
#
# Calculating volume of a cylinder.
#

cylinder_volume <- function(height, radius, print_output=F) {
  # Returns the volume of a cylinder (cm^3). 
  # 
  # Args:
  # - height (cm) 
  # - radius (cm)
  vol <- pi * radius^2 * height
  
  if (print_output) {
    txt = 'Cylinder volume ='
    cat(txt, vol)
  }
  return(vol)
}

height <- 15
radius <- 3

V <- cylinder_volume(height, radius, print_output = T)
#print(V)

