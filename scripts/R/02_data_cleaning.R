# 01_data_cleaning.R
# 06-01-21

# libraries
library(tidyverse)
# install.packages("tidytext")
library(tidytext)
# install.packages("tm")
library(tm)
# install.packages("SnowballC")
library(SnowballC)
# install.packages("ngram")
library(ngram)

# import data
diaries_messy <- map_dfr(fs::dir_ls(here::here("data/raw_data/")), read_file)

names(diaries_messy) <- paste0("diary_",1:30,sep = "")

# clean the data frame
# beginning and ending strings to remove


end <- "Money Diaries are meant to reflect an individual's experience and do not necessarily reflect Refinery29's point of view. Refinery29 in no way encourages illegal activity or harmful behavior.The first step to getting your financial life in order is tracking what you spend — to try on your own, check out our guide to managing your money every day. For more money diaries, click here.Do you have a Money Diary you'd like to share? Submit it with us here.Have questions about how to submit or our publishing process? Read our Money Diaries FAQ doc here or email us here."

diaries <- diaries_messy |>
  pivot_longer(cols = diary_1:diary_30) |>
  rename("diary_number" = name, "text" = value)
  
