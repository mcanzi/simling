# Based on Winter (2019), Statistics for Linguists: An Introduction Using R, section 15.2.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(1)
n_speakers <- 16
n_words <- 24

speakers <- tibble(speaker = str_c("S", str_pad(1:n_speakers, 2, pad = "0")),
                   s0 = rnorm(n_speakers, 0, 25),
                   s1 = rnorm(n_speakers, 0, 12))
words <- tibble(word = str_c("w", str_pad(1:n_words, 2, pad = "0")),
                voicing = rep(c("voiceless", "voiced"), each = n_words / 2),
                w0 = rnorm(n_words, 0, 15))

vowel_duration <- crossing(speakers, words) |>
  mutate(duration = round(150 + s0 + w0 +
                          (20 + s1) * (voicing == "voiced") +
                          rnorm(n(), 0, 20))) |>
  select(speaker, word, voicing, duration)

vowel_duration <- vowel_duration |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         voicing = factor(voicing, levels = c("voiceless", "voiced")))

usethis::use_data(vowel_duration, overwrite = TRUE)
