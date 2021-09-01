

library(tidyverse)
library(socviz)

d <- filter(boomer, country == 'United States')

ggplot(data = d,
       mapping = aes(x=date, y=births)) +
  geom_line()
