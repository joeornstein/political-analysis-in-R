# ---
# title: Plot county-level presidential election data (2020)
# author: Joe Ornstein
# date: 2021-08-23
# version: 1.0
# ---

library(tidyverse)

load('data/county-results-2020.RData')

ggplot(data = counties_2020) +
  geom_point(mapping = aes(x=total_votes, y=percent_biden)) +
  labs(x= 'Total Votes', y = 'Percent Biden')

count(counties_2020, winner)
