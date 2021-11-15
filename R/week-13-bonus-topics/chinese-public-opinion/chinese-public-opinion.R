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

