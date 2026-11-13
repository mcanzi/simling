library(dplyr)
library(tidyr)
library(tibble)

set.seed(5005)
children <- tibble(child = sprintf("C%02d", 1:60),
                   c0 = rnorm(60, 0, 0.6))
words <- tibble(word = sprintf("w%02d", 1:40),
                category = rep(c("noun", "verb", "other"), c(22, 10, 8)),
                log_freq = round(rnorm(40, 2, 0.7), 2),
                w0 = rnorm(40, 0, 0.4))

months <- 10:24
first_words <- crossing(children, words) |>
  mutate(eta0 = c0 + w0 + 0.6 * (log_freq - 2) +
           c(noun = 0.5, verb = -0.3, other = -0.6)[category]) |>
  rowwise() |>
  mutate(age_first = {
    h <- plogis(-5.2 + 0.28 * (months - 10) + eta0)
    m <- which(runif(length(months)) < h)
    if (length(m)) months[m[1]] else NA_integer_
  }) |>
  ungroup() |>
  mutate(produced = as.integer(!is.na(age_first)),
         age = if_else(produced == 1L, age_first, 24L)) |>
  select(child, word, category, log_freq, age, produced)

first_words <- first_words |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         category = factor(category, levels = c("noun", "verb", "other")),
         across(c(age), as.integer))

usethis::use_data(first_words, overwrite = TRUE)
