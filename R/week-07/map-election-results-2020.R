# ---
# title: Map county level presidential election results (2020)
# author: Joe Ornstein
# date: 2021-09-27
# ---

## Step 1: Load and tidy up the data -------------------------

# first, we load the packages we need
library(tidyverse)
library(ggthemes) # for extra ggplot themes

# next, load the county-level data (see R/week-02/cleanup-2020-data.R)
load('data/county-results-2020-for-map.RData')

# get the map data
map_data <- map_data('county') 

# create the upper-case variables we need to merge (state and county_name)
map_data <-  mutate(map_data, 
                    state = toupper(region),
                    county_name = toupper(subregion)) 

# join the map data and the election results data together
d <- left_join(map_data, counties_2020, by = c('state', 'county_name'))


## Step 2: Make the map! -----------------------

# define the hex color codes for Democratic Blue and Republican Red
party_colors <- c("#2E74C0", "#CB454A") 

# here's a basic version without any embellishment
p <- ggplot(data = d,
       mapping = aes(x=long, y=lat, 
                     group = group,
                     fill = percent_biden)) +
  geom_polygon()

p
