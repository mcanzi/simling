library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(tibble)

set.seed(5005)
children <- tibble(child = str_c("C", str_pad(1:60, 2, pad = "0")),
                   c0 = rnorm(60, 0, 0.6))
words <- tibble(word = str_c("w", str_pad(1:40, 2, pad = "0")),
                category = rep(c("noun", "verb", "other"), c(22, 10, 8)),
                log_freq = round(rnorm(40, 2, 0.7), 2),
                w0 = rnorm(40, 0, 0.4))

months <- 10:24
first_words <- crossing(children, words) |>
  mutate(eta0 = c0 + w0 + 0.6 * (log_freq - 2) +
           case_when(category == "noun" ~ 0.5, category == "verb" ~ -0.3,
                     category == "other" ~ -0.6),
         age_first = map_int(eta0, \(eta) {
           h <- plogis(-5.2 + 0.28 * (months - 10) + eta)
           first(months[runif(length(months)) < h], default = NA_integer_)
         })) |>
  mutate(produced = as.integer(!is.na(age_first)),
         age = if_else(produced == 1L, age_first, 24L)) |>
  select(child, word, category, log_freq, age, produced)

first_words <- first_words |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         category = factor(category, levels = c("noun", "verb", "other")),
         across(c(age), as.integer))

usethis::use_data(first_words, overwrite = TRUE)
