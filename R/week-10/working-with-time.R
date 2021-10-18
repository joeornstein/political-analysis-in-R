## Time series data
## date: 2021-10-18

library(tidyverse)
library(gapminder)

## plot it all
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          size = pop)) +
  geom_point(alpha = 0.5) +
  scale_x_log10(labels = scales::dollar) +
  scale_size_continuous(labels = scales::comma,
                        breaks = c(1e5, 5e5,
                                   1e6, 5e6,
                                   5e7, 2e8,
                                   1e9)) +
  theme_minimal() + 
  labs(x = 'GDP Per Capita',
       y = 'Life Expectancy',
       color = 'Continent',
       size = 'Population',
       title = 'The Health and Wealth of Nations')

p

## Solution 1: Take a cross-section -------------

p <- ggplot(data = filter(gapminder, year == 2007),
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          size = pop)) +
  geom_point(alpha = 0.5) +
  scale_x_log10(labels = scales::dollar) +
  scale_size_continuous(labels = scales::comma,
                        breaks = c(1e5, 5e5,
                                   1e6, 5e6,
                                   5e7, 2e8,
                                   1e9)) +
  theme_minimal() + 
  labs(x = 'GDP Per Capita',
       y = 'Life Expectancy',
       color = 'Continent',
       size = 'Population',
       title = 'The Health and Wealth of Nations (2007)')

p

## Solution 2: Plot a time series -----------

p <- ggplot(data = filter(gapminder, country == 'Cambodia'),
            mapping = aes(x = gdpPercap,
                          y = lifeExp)) +
  geom_text(mapping = aes(label = year)) + 
  geom_path() + 
  scale_x_log10(labels = scales::dollar) +
  scale_size_continuous(labels = scales::comma,
                        breaks = c(1e5, 5e5,
                                   1e6, 5e6,
                                   5e7, 2e8,
                                   1e9)) +
  theme_minimal() + 
  labs(x = 'GDP Per Capita',
       y = 'Life Expectancy',
       color = 'Continent',
       size = 'Population',
       title = 'The Health and Wealth of Nations (Cambodia)')

p

## Solution 3: Facet -------------------

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          size = pop)) +
  geom_point(alpha = 0.5) +
  scale_x_log10(labels = scales::dollar) +
  scale_size_continuous(labels = scales::comma,
                        breaks = c(1e5, 5e5,
                                   1e6, 5e6,
                                   5e7, 2e8,
                                   1e9)) +
  theme_minimal() + 
  labs(x = 'GDP Per Capita',
       y = 'Life Expectancy',
       color = 'Continent',
       size = 'Population',
       title = 'The Health and Wealth of Nations') +
  facet_wrap(~year)

p

## Solution 4: Create a movie ---------------------------

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          size = pop)) +
  geom_point(alpha = 0.5) +
  scale_x_log10(labels = scales::dollar) +
  scale_size_continuous(labels = scales::comma,
                        breaks = c(1e5, 5e5,
                                   1e6, 5e6,
                                   5e7, 2e8,
                                   1e9)) +
  theme_minimal() + 
  labs(x = 'GDP Per Capita',
       y = 'Life Expectancy',
       color = 'Continent',
       size = 'Population',
       title = 'The Health and Wealth of Nations (1952-2007)')


library(gganimate)

p + transition_time(time = year)
