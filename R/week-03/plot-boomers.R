# ---
# Plot births over time in the United States
# author: Joe Ornstein
# date: 2021-09-01
# ---

library(tidyverse)
library(socviz)

# keep only the rows with US data
d <- filter(boomer, country == 'United States')

# create ggplot object, mapping the month to x and number of births to y
p <- ggplot(data = d,
       mapping = aes(x=date, y=births)) +
  geom_line() +
  theme_bw() +
  geom_vline(xintercept = as.Date('1945-08-015') + 9*30,
             linetype = 'dashed')

p
