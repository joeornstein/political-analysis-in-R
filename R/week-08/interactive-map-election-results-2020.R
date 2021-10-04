# ---
# title: Interactive map of county level presidential election results (2020)
# author: Joe Ornstein
# date: 2021-10-04
# ---

## Step 1: Load and tidy up the data -------------------------

# first, we load the packages we need
library(tidyverse)
library(sf) # functions for working with spatial data
library(tigris) # for map data from the US Census
library(leaflet) # for interactive maps

# next, load the county-level data (see R/week-02/cleanup-2020-data.R)
load('data/county-results-2020-for-map.RData')

# get the map data from the tigris package (sf format)
county_map <- counties('Georgia')

# we're going to merge by fips code, so 
# make sure that the fips code in each dataset
# is named the same thing and is in the same format
county_map <- mutate(county_map, 
                     fips = as.numeric(GEOID))

counties_2020 <- mutate(counties_2020,
                        fips = as.numeric(county_fips))

# join the map data and the election results data together
d <- left_join(county_map, counties_2020, by = 'fips')


## Step 2: Make the map! -----------------------

# define the hex color codes for Democratic Blue and Republican Red
party_colors <- c("#CB454A", 'gray', "#2E74C0") 

# here's a basic leaflet without embellishment
# (notice pipes between layers instead of ggplot's plus signs)
p <- leaflet(data = d) %>% 
  addPolygons()

p

# add fill color (https://rstudio.github.io/leaflet/choropleths.html#adding-some-color)
pal <- colorNumeric(
  palette = party_colors,
  domain = d$percent_biden)

p <- leaflet(data = d) %>% 
  addPolygons(fillColor = ~pal(percent_biden),
              weight = 1,
              opacity = 1,
              color = 'white',
              fillOpacity = 0.7,
              label = d$NAME)
p

# add basemap and a legend
# here's the complete set of basemaps: http://leaflet-extras.github.io/leaflet-providers/preview/index.html
p %>% 
  addProviderTiles(providers$Esri.WorldGrayCanvas) %>% 
  addLegend(pal = pal, values = ~percent_biden,
            opacity = 0.7, title = NULL,
            position = 'bottomright')
