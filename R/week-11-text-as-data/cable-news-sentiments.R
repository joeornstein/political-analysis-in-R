# ---
# description: sentiment analysis of cable news transcripts
# author: Joe Ornstein
# date: 2021-10-27
# ---

library(tidyverse)
library(tidytext)

load('data/text-data/cable-news-transcripts.RData')

# tokenize the text data
tokenized_text <- unnest_tokens(d,
                                input = transcript,
                                output = word)

# merge with a sentiment lexicon
tokenized_text <- left_join(tokenized_text, 
                            get_sentiments('bing'),
                            by = 'word')

# filter out some words whose sentiment score is problematic
tokenized_text <- filter(tokenized_text,
                         word != 'trump',
                         word != 'like',
                         word != 'pretty')


# get sentiment scores by host
tokenized_text %>% 
  filter(!is.na(sentiment)) %>% 
  group_by(host) %>% 
  summarize(positive_words = sum(sentiment == 'positive'),
            negative_words = sum(sentiment == 'negative')) %>% 
  mutate(negativity_ratio = negative_words / (positive_words + negative_words) * 100) %>% 
  arrange(negativity_ratio)

