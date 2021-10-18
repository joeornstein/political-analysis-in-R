# ---
# title: POLS 3230 Quiz 2
# author: Joe Ornstein
# date: 2021-10-13
# ---

# Find and fix 7 errors in the code below, and the script 
# will produce the map shown in quiz-2-target.png

## Step 1: Load Libraries ------------------------------

library(tidyverse)
library(ggthemes) # map themes

## Step 2: Import Data -------------------------------

# Data on median income and rent by state come packaged 
# with the tidyverse. It's called us_rent_income.
us_rent_income

# Next, we'll load the state-level map data from the map_data() function
state_map <- map_data('state')

## Step 3: Tidy the rent and income data ----------------

# First, we'll pivot the data so that rent and income are in 
# separate columns, and each row is a state.
d <- pivot_wider(data = us_rent_income,
                 id_cols = c('GEOID', 'NAME'),
                 names_from = 'variable',
                 values_from = 'estimate')

# Next, we'll create a new column, the median rent as a percent of median income
d <- mutate(d, pct_rent = rent / income * 100)

## Step 4: Join the map data and the rent-to-income data -------------------

# Next, we'll make sure the key variable has the same name 
# and format in each dataset
state_map <- mutate(state_map, state_name = region)
d <- mutate(d, state_name = tolower(NAME))

# join them together
m <- left_join(state_map, d,
               by = 'state_name')

## Step 5: Make the map --------------------------

p <- ggplot(data = m,
            mapping = aes(x = long, 
                          y = lat,
                          group = group, 
                          fill = pct_rent)) +
  geom_polygon(color = 'gray50') +
  theme_map() +
  scale_fill_gradient(low = 'white',
                       high = '#F73718') +
  labs(title = 'The Hottest Housing Markets',
       subtitle = 'Median Rent as a Percent of Median Income',
       caption = 'Data from the 2017 American Community Survey',
       fill = NULL) +
  coord_map(projection = 'albers',
            lat0 = 39, lat1 = 45)

p