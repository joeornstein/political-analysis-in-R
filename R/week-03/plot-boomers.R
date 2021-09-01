# ---
# Plot births over time in the United States
# author: Joe Ornstein
# date: 2021-09-01
# ---

library(tidyverse)
library(socviz)

# keep only the rows with US data
boomer %>% 
  filter(country == 'United States') %>%
  ggplot(mapping = aes(x=date, y=births)) +
  geom_line() +
  theme_bw() +
  geom_vline(xintercept = as.Date('1945-08-15') + 9*30,
             linetype = 'dashed')
  

# create ggplot object, mapping the month to x and number of births to y


p
