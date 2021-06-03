# 03_data_exploration
# 06-02-21

# libraries
library(tidyverse)
library(tidytext)
# install.packages("wordcloud")
library(wordcloud)


# read in data
md <- read_csv(here::here("data/clean_data/diaries.csv"))

freqs <- md |>
  unnest_tokens(word, text) |>
  anti_join(stop_words) |>
  group_by(word) |>
  summarise(num_words = n()) |>
  arrange(-num_words)

wordcloud(freqs$word,freqs$num_words, min.freq = 50, colors = brewer.pal(8,"Dark2"))
# looks like we need some custom stopwords