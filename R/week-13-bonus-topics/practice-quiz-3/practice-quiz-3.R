## Practice Quiz 3
## The script below has six errors. 
## Fix them and create a pretty picture (the one in this folder)

library(tidyverse)
library(lubridate)

# we're going to use the 'boomer' dataset from socviz to 
# plot birth rates over time in the US and England/Wales.

socviz::boomer %>% 
  # create the year variable
  mutate(year = year(date)) %>%  
  # compute birth rate by year
  group_by(country, year) %>% 
  mutate(birth_rate = sum(births) / pop * 100) %>% 
  # pipe it into a ggplot
  gplot() + 
  # add lines
  geom_line(mapping = aes(x=year, 
                          y=births, 
                          linetype = country) + 
  # add labels
  labs(x = 'Year', 
       y = 'Birth Rate (%)',
       color = 'Country') +
  # change the theme
  theme_classic()
