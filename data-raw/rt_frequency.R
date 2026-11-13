# rt_frequency: psycholinguistics, a small lexical decision task
# 10 participants respond to the same 20 words, 10 of high and 10 of low
# frequency. Used for data wrangling in Statistics, lecture 2.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(42)
participants <- tibble(participant = sprintf("P%02d", 1:10),
                       p0 = rnorm(10, 0, 0.12))                 # own speed (log scale)
words <- tibble(word = sprintf("w%02d", 1:20),
                frequency = rep(c("high", "low"), each = 10),
                w0 = rnorm(20, 0, 0.06))                        # own difficulty

rt_frequency <- crossing(participants, words) |>
  mutate(rt = round(exp(6.38 + p0 + w0 + 0.1 * (frequency == "low") + rnorm(n(), 0, 0.15))),
         accuracy = rbinom(n(), 1, if_else(frequency == "low", 0.85, 0.95))) |>
  select(participant, word, frequency, rt, accuracy)

usethis::use_data(rt_frequency, overwrite = TRUE)
