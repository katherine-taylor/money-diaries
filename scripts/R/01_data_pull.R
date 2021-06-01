# 01_data_pull.R
# 05-31-21

# libraries
library(rvest)
library(purrr)
library(tidyr)
library(readr)
library(here)


# now to write ~5 lines of code that take several hours
# get main website
main_page <- rvest::read_html("https://www.refinery29.com/en-us/money-diary")

# get diary urls
diaries <- main_page |>
  html_elements(xpath = "/html/body/div[1]/div/main/div/div/div
                /div[3]/div[1]/div[3]/div/div/div/div/div/div") |>
  html_children() |>
  xml_attr(attr = "href")

# make full URLs
base_url <- "https://www.refinery29.com"
full_urls <- paste0(base_url,diaries, sep = "")

# scrape diary pages
responses <- map(.x = full_urls, ~rvest::read_html(.x))

# clean up responses into .txt files
clean_rep <- function(doc, name) {
  doc |>
  html_elements(xpath = "//*[@id=\"editorial-content\"]") |>
  html_text() |>
  write_file(paste0(here("data/raw_data/"),"diary_",name,".txt",sep = ""))
}
names <- formatC(1:30, flag = "0",digits = 1)

map2(responses, names, ~clean_rep(.x,.y))

