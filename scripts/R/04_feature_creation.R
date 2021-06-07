# 04_feature_generation
# 06-07-21

# libraries
library(tidyverse)
library(ngram)

# import data
md_raw <- read_csv(here::here("data/clean_data/diaries.csv"))

#' create salary (target feature), salary high-low, length, num_expenses, expenses section,
#' num_purchases, purchases section features

md_ft <- md_raw |>
  mutate(
    salary = str_extract(text, "\\$+\\d+,+\\d*"),
    salary_hi_low = case_when(
      str_detect(salary, "\\$+\\d{3}+,") ~ "6 figures",
      TRUE ~ "5 figures"
    ),
    word_count = sapply(text, wordcount),
    expenses_section = str_split_fixed(
      str_split_fixed(
        text,
        "was there an expectation for you to attend higher education?",
        n = 2
      )[, 1],
      "monthly expenses",
      n = 2
    )[, 2],
    num_expenses = str_count(expenses_section, "\\$"),
    expenses_words_only = str_remove_all(expenses_section, "[\\d+$*+[:punct:]]"),
    purchases_section = str_split_fixed(text, "day one", n = 2)[, 2],
    num_purchases = str_count(purchases_section, "\\$"),
    purchases_words_only = str_remove_all(purchases_section, "[\\d+$*+[:punct:]]")
  )

write_csv(md_ft, here::here("data/clean_data/md_features.csv"))
