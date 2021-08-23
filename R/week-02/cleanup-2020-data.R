# ---
# title: Cleanup county-level presidential election data (2020)
# author: Joe Ornstein
# date: 2021-08-23
# version: 1.0
# ---

library(tidyverse)

# load and clean up the data
counties_2020 <- read_csv('data/raw/county-2020/countypres_2000-2020.csv') %>% 
  filter(year == 2020, 
         candidate %in% c('JOSEPH R BIDEN JR', 'DONALD TRUMP', 'DONALD J TRUMP')) %>% 
  select(state, county_name, county_fips, candidate, candidatevotes) %>% 
  # looks like all the 'modes' are mutually exclusive, so we can sum over the candidatevotes, but some counties break it down
  group_by(state, county_name, county_fips, candidate) %>% 
  summarize(total_votes = sum(candidatevotes)) %>% 
  ungroup %>% 
  # convert candidate names to variable names
  mutate(candidate = if_else(candidate == 'JOSEPH R BIDEN JR', 'biden_votes', 'trump_votes')) %>% 
  # make unit of analysis = county, instead of county/candidate
  pivot_wider(id_cols = c('state', 'county_name', 'county_fips'),
              names_from = 'candidate',
              values_from = 'total_votes') %>% 
  # create summary variables
  mutate(total_votes = trump_votes + biden_votes,
         percent_biden = biden_votes / total_votes * 100,
         winner = if_else(biden_votes > trump_votes, 'Biden', 'Trump'))

save(counties_2020, file = 'data/county-results-2020.RData')