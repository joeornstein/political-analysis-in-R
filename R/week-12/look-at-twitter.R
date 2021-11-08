# ---
# Pull tweets from the Twitter API
# and conduct a sentiment analysis
#
# author: Joe Ornstein
# date: 2021-11-03
# ---

library(tidyverse)
library(tidytext)
library(rtweet)

# Step 1: Create a token -------------------------

# this is where you input your API keys 
# (i.e. giant password strings)
# from the Twitter developer dashboard to prove to Twitter 
# that you have permission to be snooping around

create_token(
  app = "",
  consumer_key = "",
  consumer_secret = "",
  access_token = "",
  access_secret = ""
)

## Step 2: Download some tweets ----------------------

tweets <- search_tweets(
  "@terrymcauliffe", n = 200, include_rts = FALSE
)

# save your tweets if you want
# save(tweets, file = 'data/raw/terrymcauliffe_tweets.RData')

## Step 3: Text analysis! -----------------

tidy_tweets <- tweets %>% 
  select(created_at, screen_name, text) %>% 
  unnest_tokens(word, text)

most_common_words <- tidy_tweets %>% 
  anti_join(stop_words) %>% 
  count(word) %>% 
  arrange(-n)

# create a word cloud
library(wordcloud2)

most_common_words %>% 
  # I'll just keep the words associated with a sentiment
  inner_join(get_sentiments('bing')) %>% 
  # wordcloud2 needs a column called 'freq' or it will freak out
  rename(freq = n) %>% 
  wordcloud2(color = 'random-dark', size = 0.35)


# merge with sentiment lexicon
tweet_sentiments <- tidy_tweets %>%
  left_join(get_sentiments('bing'))

tweet_sentiments %>% 
  count(sentiment)
