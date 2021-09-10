# ---
# Plot some CES survey questions
# date: 2021-09-10
# ---

# load libraries
library(tidyverse)

# load data
load('data/ces-2020/cleaned-CES.RData')

## Chart 1: Trump approval by religious importance and education ----

ces %>% 
  # remove observations with missing values
  filter(!is.na(trump_approval),
         !is.na(pew_religimp),
         !is.na(educ)) %>% 
  # reorder the education variable
  mutate(educ = factor(educ,
                       levels = c('No HS', 'High school graduate',
                                  'Some college', '2-year', '4-year',
                                  'Post-grad'))) %>% 
  # count the number of respondents in each group
  group_by(pew_religimp, educ, trump_approval) %>% 
  summarize(N = n()) %>% 
  # compute the percent in each group
  mutate(pct = N / sum(N) * 100) %>% 
  # pipe that data into a ggplot()
  ggplot(mapping = aes(x = pct, y = trump_approval, 
                       fill = pew_religimp)) +
  # make it a column chart
  geom_col() +
  # separate subplots for each religious/education group
  facet_grid(pew_religimp ~ educ) +
  # fancy Economist theme (make sure to install.packages('ggthemes') if you don't have it)
  ggthemes::theme_economist() +
  # clean up the labels
  labs(x = 'Percent of Respondents', y = 'Trump Approval',
       fill = 'Importance of Religion',
       title = 'Trump Approval by Education Level & Importance of Religion',
       caption = 'Data source: Cooperative Election Study 2020')

# save the chart to the plots/ folder
ggsave(filename = 'plots/trump-approval-ces-2020.png',
       height = 10, width = 15)
