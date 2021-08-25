
library(babynames)
library(tidyverse)

# these next two lines create two objects called my_name and my_sex
my_name <- "Joseph"
my_sex <- "M"
my_birthyear <- 1987
# note: characters must be surrounded by quotation marks
# numbers don't need quotes


# this line of code creates a smaller dataset 
# with the filter() function, picking out the rows
# where the name equals my_name and the sex equals my_sex
my_babyname <- filter(babynames,
                      name == my_name,
                      sex == my_sex)

# create a plot
p <- ggplot(data = my_babyname) + geom_line(mapping = aes(x = year, y = n)) +  labs(y = 'number of babies', title = my_name)

p


