library(dplyr)
library(tidyr)
library(tibble)

set.seed(1)
n_speakers <- 16
n_words    <- 24

speakers <- tibble(speaker = sprintf("S%02d", 1:n_speakers),
                   s0 = rnorm(n_speakers, 0, 25),
                   s1 = rnorm(n_speakers, 0, 12))
words <- tibble(word = sprintf("w%02d", 1:n_words),
                voicing = rep(c("voiceless", "voiced"), each = n_words / 2),
                w0 = rnorm(n_words, 0, 15))

vowel_duration <- crossing(speakers, words) |>
  mutate(duration = round(150 + s0 + w0 +
                          (20 + s1) * (voicing == "voiced") +
                          rnorm(n(), 0, 20)),
         voicing = factor(voicing, levels = c("voiceless", "voiced"))) |>
  select(speaker, word, voicing, duration)

usethis::use_data(vowel_duration, overwrite = TRUE)
