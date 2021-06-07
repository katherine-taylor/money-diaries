# 05_feature_exploration
# 06-06-21

# libraries
library(tidyverse)

# import data
md <- read_csv(here::here("data/clean_data/md_features.csv"))

# convert salary to numeric
md <- md |>
  mutate(salary = parse_number(salary)) |>
  filter(diary_number != 24)

# basic plots
# continuous response
md |>
  ggplot(aes(x = num_purchases, y = salary)) +
  geom_point()
# discrete response
md |>
  ggplot(aes(y = word_count, fill = salary_hi_low)) +
  geom_boxplot()

basic_lm <- lm(salary ~ word_count + num_purchases + num_expenses, data = md)

summary(basic_lm)

par(mfrow = c(2,2))
plot(basic_lm)
par(mfrow = c(1,1))

