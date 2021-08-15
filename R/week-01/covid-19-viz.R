# ---
# title: Plot reported COVID-19 cases in Clarke County
# author: Joe Ornstein
# date: 2021-08-15
# version: 1.0
# ---

## 1. Load Packages ----------

library(tidyverse)

## 2. Get Data ---------

# read data from the NYT repository
d <- read_csv('https://github.com/nytimes/covid-19-data/raw/master/us-counties.csv')

# clean up data
d <- d %>% 
  # keep Clarke county
  filter(county == 'Clarke', state == 'Georgia') %>% 
  # create new_cases variable (total cases minus the number of cases from the day before)
  arrange(date) %>% 
  mutate(new_cases = cases - lag(cases))

## 3. Plot cases over time ----------------------

d %>% 
  # keep only the weekdays (counting is inconsistent on the weekends)
  filter(!(weekdays(date) %in% c('Saturday', 'Sunday'))) %>% 
  # plot new cases over time
  ggplot(mapping = aes(x = date,
                       y = new_cases)) +
  # semi-transparent points
  geom_point(alpha = 0.5) +
  # minimal theme
  theme_minimal() +
  # label the axes and add a title
  labs(x = 'Date', y = 'New Cases',
       title = 'Athens-Clarke County, GA') +
  # format the x-axis so it displays pretty dates
  scale_x_date(date_labels = '%B %Y')
