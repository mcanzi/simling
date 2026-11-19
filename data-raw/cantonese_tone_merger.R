# Mok, Zuo & Wong (2013), Language Variation and Change 25(3), 341-370.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(4006)
speakers <- tibble(speaker = str_c("S", str_pad(1:90, 2, pad = "0")),
                   age = round(c(runif(45, 18, 25.5), runif(45, 25.5, 74.5))),
                   gender = sample(rep(c("female", "male"), 45))) |>
  mutate(merger = rbinom(n(), 1, 0.22 * plogis((30 - age) / 4)),
         s0 = rnorm(n(), 0, 0.6))
words <- tibble(word = str_c("w", str_pad(1:20, 2, pad = "0")),
                tone = rep(c("T2", "T5"), each = 10),
                log_freq = round(runif(20, 1, 5), 2))

cantonese_tone_merger <- crossing(speakers, words) |>
  mutate(target = case_when(merger == 1 ~ 5.2 + if_else(tone == "T2", 0.2, -0.2),
                            tone == "T2" ~ 7,
                            TRUE ~ 3.5),
         rise = round(target + s0 + rnorm(n(), 0, 0.9), 2)) |>
  select(speaker, age, gender, word, tone, log_freq, rise)

cantonese_tone_merger <- cantonese_tone_merger |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         across(c(age), as.integer))

usethis::use_data(cantonese_tone_merger, overwrite = TRUE)
