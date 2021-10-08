# ---
# title: POLS 3230 Quiz 2 Practice
# author: Joe Ornstein
# date: 2021-10-08
# ---

# There are six errors in the code below. Find them and produce an interesting picture!

## NOTE ##
# This script assumes that you have downloaded the WVS Wave 7 RData file, and it lives in the data/raw/ 
# section of your project folder.


## We're going to draw a map of the world, colored by the percent of World Values Survey respondents
## in each country that reported a belief in some form of eternal spiritual damnation.

library(tidyverse)
library(here)
library(ggthemes)
library(countrycode) # contains a function to convert country names to COW codes and vice versa
# EXTREMELY USEFUL for joining country-level datasets

## STEP 1: Load the data -----------------------------------------

# WVS
load( here('data/raw/WVS_Cross-National_Wave_7_R_v2_0.RData') )
wvs <- `WVS_Cross-National_Wave_7_v2_0`

# world map
world_map <- map_data('world')


## STEP 2: Find and clean the variables we want to visualize --------------------

# select the country code, belief in afterlife and belief in heaven
wvs <- select(wvs,
              C_COW_ALPHA,
              believe_in_afterlife = Q166,
              believe_in_hell = Q167)

# remove missing values
wvs <- filter(wvs,
              !is.na(Q166),
              !is.na(Q167))

# count the number of respondents who believe in the afterlife and hell by country
hell_table <- wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  summarize(afterlife_believers = sum(believe_in_afterlife == 1),
            hell_believers = sum(believe_in_hell == 1),
            total_respondents = n)

# compute percent of respondents who believe in hell
hell_table <- mutate(hell_table,
                     pct_hell_believers = hell_believers / total_respondents * 100)


# remove Iraq and Kyrgyzstan, who seem not to have been asked that question (note the zeroes)
hell_table <- filter(hell_table,
                     afterlife_believers > 0)

## STEP 3: Merge the map data with the survey data ----------------------------

# add COW codes to the world map data using the countrycode() function
world_map <- mutate(world_map,
                    C_COW_ALPHA = countrycode(region, 'country.name', 'cowc'))


d <- left_join(hell_table, world_map, by = 'C_COW_ALPHA')


## STEP 4: Build the map! -----------------------------------

p <- ggplot(data = d, 
       mapping = x=long, 
                     y =lat, 
                     group = group,
                     fill = pct_hell_believers) + 
  geom_polygon(color = 'gray90')  +
  theme_map() +
  scale_fill_gradient(low = 'skyblue',
                      high = 'darkred',
                      mid = 'white',
                      midpoint = 50) +
  labs(fill = '% respondents who believe in hell',
       caption = 'Data from the World Vales Survey Wave 7')

p
