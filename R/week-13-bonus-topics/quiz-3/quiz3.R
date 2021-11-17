#' ---
#' title: POLS 3230 Quiz 3
#' There are six errors in the code below. 
#' Fix them and submit a revised R script that produces the attached figure.
#' ---

library(tidyverse)
library(lubridate)

# let's take the maunaloa dataset from the socviz package,
# facet by month (to account for within-year variation)
# and plot changes in observed CO2 concentration over time

socviz::maunaloa %>% 
  # get the year and month from the date column
  mutate(year = year(date),
         month = month(date, label = FALSE)) %>% 
  # pipe into a ggplot
  ggplot(mapping = aes(x=year, y=conc,
                       group = month)) %>% 
  # add points and lines
  geom_point() +
  # scale the color so that red is high and blue is low
  scale_color_gradient2(low = 'blue', high = 'red', mid = 'gray', 
                        midpoint = median(socviz::maunaloa$conc)) +
  # remove the superfluous legend
  guides(color = 'none') +
  # change the theme
  theme_minimal() +
  # add labels
  labs(x = 'Year', y = 'Concentration'
       caption = 'Atmospheric CO2 concentration in parts per million, measured on the first day of each month from the Mauna Loa Observatory') +
  # facet by month
  facet_wrap(month)
  
