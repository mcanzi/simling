# Mok, Zuo & Wong (2013), Language Variation and Change 25(3), 341-370.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4005)
speakers <- tibble(speaker = sprintf("S%02d", 1:90),
                   age = round(runif(90, 18, 75)),
                   gender = sample(rep(c("female", "male"), 45))) |>
  mutate(merger = rbinom(n(), 1, 0.65 * plogis((40 - age) / 6)),
         s0 = rnorm(n(), 0, 0.6))
words <- tibble(word = sprintf("w%02d", 1:20),
                tone = rep(c("T2", "T5"), each = 10),
                log_freq = round(runif(20, 1, 5), 2))

cantonese_tone_merger <- crossing(speakers, words) |>
  mutate(target = case_when(merger == 1 ~ 5.2 + if_else(tone == "T2", 0.4, -0.4),
                            tone == "T2" ~ 7,
                            TRUE ~ 3.5),
         rise = round(target + s0 + rnorm(n(), 0, 0.9), 2),
         across(c(speaker, gender, word, tone), factor)) |>
  select(speaker, age, gender, word, tone, log_freq, rise)

usethis::use_data(cantonese_tone_merger, overwrite = TRUE)
