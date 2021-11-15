## ---
## Compare WVS responses from Chinese and American survey takers
## ---

library(tidyverse)

## Step 1: Load the Data ------------------

# load Wave 7 of the World Values Survey. This is where I downloaded it...
load('data/raw/WVS_Cross-National_Wave_7_R_v2_0.RData')

# only keep the countries we want
wvs <- `WVS_Cross-National_Wave_7_v2_0` %>% 
  filter(C_COW_ALPHA %in% c('CHN', 'USA'))

wvs %>% 
  count(C_COW_ALPHA)

## Step 2: Compare responses ------------------------

# some questions were just not asked in China;
# e.g. "How often do the police/military interfere in private life?"
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q134)

# perceptions of corruption (Q112)
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q112) %>% 
  filter(Q112 > 0) %>%
  mutate(pct = n/sum(n)) %>% 
  ggplot(mapping = aes(Q112, y=pct, fill = C_COW_ALPHA)) + 
  geom_col(position = 'dodge')


# pride in country (Q254)
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q254) %>% 
  filter(Q254 > 0) %>%
  mutate(pct = n/sum(n)) %>% 
  ggplot(mapping = aes(Q254, y=pct, fill = C_COW_ALPHA)) + 
  geom_col(position = 'dodge')

# most people can be trusted (Q57)
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q57) %>% 
  filter(Q57 > 0) %>%
  mutate(pct = n/sum(n)) %>% 
  ggplot(mapping = aes(Q57, y=pct, fill = C_COW_ALPHA)) + 
  geom_col(position = 'dodge')

# trust people of another religion (Q62)
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q62) %>% 
  filter(Q62 > 0) %>%
  mutate(pct = n/sum(n)) %>% 
  ggplot(mapping = aes(Q62, y=pct, fill = C_COW_ALPHA)) + 
  geom_col(position = 'dodge')

# one of my main goals is to make my parents proud (Q27)
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q27) %>% 
  filter(Q27 > 0) %>%
  mutate(pct = n/sum(n)) %>% 
  ggplot(mapping = aes(Q27, y=pct, fill = C_COW_ALPHA)) + 
  geom_col(position = 'dodge')

# incomes should be made more equal (1)
# vs. 
# there should be incentives for greater effort (10)
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q106) %>% 
  filter(Q106 > 0) %>%
  mutate(pct = n/sum(n)) %>% 
  ggplot(mapping = aes(Q106, y=pct, fill = C_COW_ALPHA)) + 
  geom_col(position = 'dodge')

# we depend too much on science and not enough on faith
wvs %>% 
  group_by(C_COW_ALPHA) %>% 
  count(Q160) %>% 
  filter(Q160 > 0) %>%
  mutate(pct = n/sum(n)) %>% 
  ggplot(mapping = aes(Q160, y=pct, fill = C_COW_ALPHA)) + 
  geom_col(position = 'dodge')
