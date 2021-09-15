#' ---
#' title: POLS 3230 Quiz 1
#' There are seven errors in the code below. 
#' Fix them and submit a revised R script that produces the attached figure.
#' ---

library(Tidyverse) # load the tidyverse package

# Note: mtcars is a dataset that comes with R. (Line 14 does not contain an error! Promise!)
# You can view a description of the dataset by typing ?mtcars into the console.

## Step 1: Clean Up The Data -----------------------

d <- mtcars %>% 
  # create a character variable called transmission, denoting whether the
  # car has a manual or automatic transmission
  mutate(transmission == case_when(am == 1 ~ 'Manual', 
                                  am == 0 ~ 'Automatic')) %>% 
  # create a character variable called engine, denoting whether the
  # car has a v-shaped or straight engine
  mutate(engine = case_when(vs == 1 ~ 'Straight',
                            vs = 0 ~ 'V-Shaped'))
  

## Step 2: Plot It ---------------------------------

# create a scatterplot called p with 
# horsepower on the x-axis,
# miles per gallon on the y-axis,
# color by engine type, and
# faceted by transmission

p <- ggplot(data = d,
            mapping = aes(x = hp, y = mpg) ) +
  geom_point(mapping = aes(color = engine,
                           alpha = 0.5) ) +
  facet_wrap(~trasmission) +
  theme_bw()
  labs(x = 'Horsepower', 'y = Miles Per Gallon',
       title = 'Fuel Efficiency and Power (1974 Automobiles)',
       color = 'Engine')
p