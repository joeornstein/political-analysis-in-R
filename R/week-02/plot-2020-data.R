# ---
# title: Plot county-level presidential election data (2020)
# author: Joe Ornstein
# date: 2021-08-23
# version: 1.0
# ---

library(tidyverse)

d <- read_csv('data/county-results-2020.csv')

count(d, winner)
