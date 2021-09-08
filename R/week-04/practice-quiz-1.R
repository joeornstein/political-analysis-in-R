# ---
# title: Practice Quiz (POLS 3230)
# date: 2021-09-08
# ---

# Fix the code below so that it produces the chart at R/week-04/practice-quiz-1.png
# There are eight errors. See if you can find and fix them all!
# HINT: Go line by line. Make sure you know what each line of code is doing and 
# whether all the syntax, spellings, and parentheses are right. 

# load the libraries you need
library(tidyvers)
library(gapminder)
library(scales)

# take the gapminder dataset
gapminder %>% 
  
  # keep only the year 2007
  filter(year = 2007) %>% 
  
  # create a ggplot with that data, mapping GDP per capita to x,
  # life expectancy to y, and continent to color
  ggplot(x = gdpPercap, y = lifeExp, color = contnent) +
  
  # add semi-transparent points
  geom_point(alpha == 0.4)
  
  # create subplots by continent
  facet_wrap(continent) +
  
  # label the axes
  labs(x = 'GDP Per Capita', y = 'Life Expectancy',
       title = 'The Wealth and Health of Nations (2007)' +
  
  # make the x-axis logarithmic
  scale_x_log10(labels = comma) +
  
  # add a minimal theme
  theme_minimal() +
  
  # remove the legend
  guides(color = 'none')