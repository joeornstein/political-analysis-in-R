## Practice Quiz 3 (ANSWER KEY)
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
  summarize(birth_rate = sum(births) / total_pop * 100) %>% 
  # pipe it into a ggplot
  ggplot() + 
  # add lines
  geom_line(mapping = aes(x=year, 
                          y=birth_rate, 
                          linetype = country)) + 
  # add labels
  labs(x = 'Year', 
       y = 'Birth Rate (%)',
       linetype = 'Country') +
  # change the theme
  theme_classic()
