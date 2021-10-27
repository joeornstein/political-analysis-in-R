# ---
# description: compiles news transcripts into an RData file
# author: Joe Ornstein
# date: 2021-10-26
# version: 0.1
# ---

library(tidyverse)

# maddow show
d <- tibble(date = as.Date('2021-10-22'),
            program = 'The Rachel Maddow Show',
            network = 'MSNBC',
            host = 'Rachel Maddow',
            transcript = read_file('data/text-data/transcripts/maddow-2021-10-22.txt'))

# hayes
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-22'),
           program = 'All In With Chris Hayes',
           network = 'MSNBC',
           host = 'Chris Hayes',
           transcript = read_file('data/text-data/transcripts/hayes-2021-10-22.txt'))
  )

# reidout
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-22'),
           program = 'The ReidOut',
           network = 'MSNBC',
           host = 'Tiffany Cross',
           transcript = read_file('data/text-data/transcripts/reidout-2021-10-22.txt'))
  )

# tucker
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-21'),
           program = 'Tucker Carlson Tonight',
           network = 'Fox News',
           host = 'Tucker Carlson',
           transcript = read_file('data/text-data/transcripts/tucker-2021-10-21.txt'))
  )


# ingraham
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-21'),
           program = 'Ingraham Angle',
           network = 'Fox News',
           host = 'Laura Ingraham',
           transcript = read_file('data/text-data/transcripts/ingraham-2021-10-21.txt'))
  )

# hannity
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-22'),
           program = 'Hannity',
           network = 'Fox News',
           host = 'Sean Hannity',
           transcript = read_file('data/text-data/transcripts/hannity-2021-10-22.txt'))
  )

# cooper
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-22'),
           program = 'Anderson Cooper 360',
           network = 'CNN',
           host = 'Anderson Cooper',
           transcript = read_file('data/text-data/transcripts/cooper-2021-10-22.txt'))
  )

# Amanpour
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-22'),
           program = 'Amanpour',
           network = 'CNN',
           host = 'Christiane Amanpour',
           transcript = read_file('data/text-data/transcripts/amanpour-2021-10-22.txt'))
  )

# Burnett
d <- d %>% 
  bind_rows(
    tibble(date = as.Date('2021-10-22'),
           program = 'Erin Burnett Out Front',
           network = 'CNN',
           host = 'Kate Bolduan',
           transcript = read_file('data/text-data/transcripts/burnett-2021-10-22.txt'))
  )


## write to csv ------

save(d, file = 'data/text-data/cable-news-transcripts.RData')
