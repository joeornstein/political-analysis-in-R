# ---
# title: Look at the Cooperative Election Study (2020) dataset
# author: Joe Ornstein
# date: 2021-09-03
# version: 1.0
# ---

library(tidyverse)

load('data/ces-2020/cleaned-CES.RData')

ces %>% 
  # filter out the respondents with missing China tariff responses
  filter(!is.na(china_tariffs)) %>% 
  ggplot() +
  # bar plot of support for China tariffs
  geom_bar(mapping = aes(x=china_tariffs)) +
  # subplots for each level of education
  facet_wrap(~educ)
