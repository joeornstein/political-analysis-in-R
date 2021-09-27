# ---
# title: Clean up the county names so that the election
#        data merges correctly with the map data
# date: 2021-09-27
# ---

library(tidyverse)

# load the county election dataset
load('data/county-results-2020.RData')

counties_2020 <- mutate(counties_2020,
                        county_name = str_to_lower(county_name) %>% 
                          str_replace_all("'", "") %>% 
                          str_replace_all('[.]', '') %>% 
                          str_replace_all(' city', '') %>% 
                          str_replace_all('oglala lakota', 'shannon') %>% 
                          str_replace_all('dewitt', 'de witt') %>% 
                          str_replace_all('dekalb', 'de kalb') %>% 
                          str_replace_all('dupage', 'du page') %>% 
                          str_replace_all('lasalle', 'la salle') %>% 
                          str_replace_all('desoto', 'de soto') %>% 
                          str_replace_all('laporte', 'la porte') %>% 
                          str_replace_all('lamoure', 'la moure') %>% 
                          str_replace_all('district of columbia', 'washington') %>% 
                          str_replace_all('saint louis', 'st louis') %>% 
                          toupper)

# save to data/ folder
save(counties_2020, file = 'data/county-results-2020-for-map.RData')
