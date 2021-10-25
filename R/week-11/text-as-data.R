# ---
# title: Demo some text analysis with the tidytext package
# date: 2021-10-25
# ---

library(tidyverse)
library(tidytext)
library(janitor)

## Step 1: Load the data --------------------

# let's work with the text data we collected our first week from
# from the class survey
raw <- read_csv('data/getting-to-know-you/students.csv') %>% 
  clean_names()

## Step 2: Tokenize the text data -----------------

# to work with text, we typically split it up into "tokens",
# meaningful chunks of text. These are easier to work with than 
# whole sentences/tweets/books/whatever the original format

# this code splits the data into single words
d <- raw %>% 
  select(timestamp, last_name, first_name,
         how_are_you_feeling_about_this_semester) %>% 
  # this is the important function. It will split up the
  # input column you specify into tokens
  unnest_tokens(output = word, 
                input = how_are_you_feeling_about_this_semester)

# this code splits it into bigrams (groups of two words)
d2 <- raw %>% 
  select(timestamp, last_name, first_name,
         how_are_you_feeling_about_this_semester) %>% 
  # this is the important function. It will split up the
  # input column you specify into tokens
  unnest_tokens(output = word, 
                input = how_are_you_feeling_about_this_semester,
                token = 'ngrams',
                n = 2)


## Step 3: Word Counts ----------------

# let's look at which words were the most common.
d %>% 
  # count the number of times each word was used
  count(word) %>% 
  # arrange the new count data by popularity
  arrange(-n)

# some of those common words are kinda obvious/uninteresting,
# like I, to, am, a, be, this
# Those are the so-called "stop words".
get_stopwords()

# Let's remove the stop words before counting
d %>% 
  anti_join(get_stopwords()) %>% 
  count(word) %>% 
  arrange(-n)


## Step 4: Sentiment Analysis ------------------------

# to conduct a sentiment analysis, we merge our tokenized data
# with a sentiment "lexicon", a list of words with associated 
# sentiment scores. Each lexicon looks a bit different:

sentiments <- get_sentiments('bing')

# merge with the tokenized dataset
d <- left_join(d, sentiments, by = 'word')

# scroll through and see if the results make sense to you!


