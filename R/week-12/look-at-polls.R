# look at at the virginia governor polls


library(tidyverse)


polls <- read_csv('data/polls/governor_polls.csv')


polls <- polls %>% 
  filter(state == 'Virginia') %>% 
  filter(candidate_party %in% c('DEM', 'REP')) %>% 
  select(poll_id, question_id, end_date, fte_grade, candidate_party, pct) %>% 
  mutate(date = as.Date(end_date, "%m/%d/%y"))

# plot that over time
p <- ggplot(data = polls,
            mapping = aes(x = date,
                          y = pct,
                          color = candidate_party)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  scale_color_manual(values = c('blue', 'red'))

p

# keep only the A polls
p <- ggplot(data = polls %>% 
              filter(fte_grade %in% c('A', 'A+', 'A-')),
            mapping = aes(x = date,
                          y = pct,
                          color = candidate_party)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  scale_color_manual(values = c('blue', 'red'))

p
