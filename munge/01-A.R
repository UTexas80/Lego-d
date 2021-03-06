# Example preprocessing script.                                                 
# http://tinyurl.com/y2tntdc5                                                   

#####
# Generate LEGO mosaic an image
#####

#Packages Required: dplyr, tidyr, purrrr, ggplot2, readr

#RUN THIS CODE AFTER DOWNLOADING SOURCE FILES
# library(jpeg)
# source("0_Functions.R")

#This will take a few minutes to run
lego_mosaic <- readJPEG("Images/GlenCFalk.jpg") %>% 
  # scale_image(48) %>% #Single value for square,
  scale_image(c(48,  56), brightness = 1.1) %>% # WIDE -  c(W, H) for rectangle
  legoize() %>% 
  collect_bricks() 

lego_mosaic %>% display_set()

#Instruction manual - calculate and graph
lego_mosaic %>% 
  generate_instructions(6) 
  
#Get summary of pieces
pieces <- lego_mosaic %>% table_pieces()

lego_mosaic %>% display_pieces()

#Save it
ggsave("LegoMosaic.png", device = "png", height = 5, width = 5)

#3D with rayshader ----
library(rayshader)

#mosaic_height is the elevation of the mosaic in LEGO plates... 3 plates =  1 LEGO brick
#Set highest_el = "dark" for dark bricks to be tallest... otherwise light bricks are tallest
lego_mosaic %>% 
  collect_3d(mosaic_height = 9, highest_el="dark") %>% 
  display_3d(fov=0,theta=-30,phi=30,windowsize=c(1000,800),zoom=0.75)


#display_3d() takes all inputs of rayshader::plot_3d() EXCEPT hillshade, heightmap, & zscale
# If you want to use plot_3d() instead, use the items 'threed_hillshade' and 'threed_elevation' in the collect_3d() output

# VERSION HISTORY
a01.version = "1.0.0"
a01.ModDate = as.Date("2019-01-01")

# 2019.03.01 - v.1.0.0
#  1st release
