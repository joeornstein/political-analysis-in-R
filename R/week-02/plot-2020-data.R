# ---
# title: County Presidential Election Results 2020
# author: Joe Ornstein
# date: 2021-08-23
# version: 1.0
# ---

## 1. Load Libraries and Data -------------

library(tidyverse)

# this line reads the cleaned-up county-level data from the web
d <- read_csv('https://raw.githubusercontent.com/joeornstein/political-analysis-in-R/main/data/county-results-2020.csv')

## 2. Plot the Data -------------------

# create a ggplot() object, inputting the dataset named d
p <- ggplot(data = d,
            # map total_votes to the x-axis and percent_biden to the y-axis
            mapping = aes(x=total_votes, y=percent_biden)) +
  # this line add points
  geom_point() +
  # this line puts the x-axis on a logarithmic scale
  scale_x_log10()

# this line calls the object we created, which displays it on the lower right
p

## 3. Make it FANCY ------------------

# this package will help make the labels a bit prettier
library(scales) 

p <- ggplot(data = d,
            # map total_votes to the x-axis and percent_biden to the y-axis
            mapping = aes(x=total_votes, y=percent_biden/100)) +
  # this line add points (alpha = 0.3 makes the points semi-transparent)
  geom_point(alpha = 0.3) +
  # this line puts the x-axis on a logarithmic scale
  scale_x_log10(labels = comma) +
  # this line formats the y-axis labels so they are percentages
  scale_y_continuous(labels = percent) +
  # this line gives the plot a different theme
  theme_bw() +
  # this line makes the labels prettier
  labs(x = 'Total Votes', y = 'Biden Vote Share',
       title = 'County-Level Election Results (2020)',
       caption = 'Fun fact: half of the people who voted in 2020 live in the 152 counties to the right of the dotted line') +
  # this next line adds a vertical dotted line to the plot
  geom_vline(xintercept = 225920, linetype = 'dotted')

p