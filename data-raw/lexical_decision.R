# lexical_decision: Statistics, lecture 10 (Mixed models 1)
library(dplyr)
library(tidyr)
library(tibble)

set.seed(21)
n_subj <- 20
n_item <- 40

z0 <- rnorm(n_subj)
z1 <- rnorm(n_subj)
participants <- tibble(participant = sprintf("P%02d", 1:n_subj),
                       u0 = 70 * z0,                                   # own speed
                       u1 = 18 * (-0.6 * z0 + sqrt(1 - 0.36) * z1))    # own frequency effect
words <- tibble(word     = sprintf("w%02d", 1:n_item),
                log_freq = round(runif(n_item, 1, 6), 2),
                w0       = rnorm(n_item, 0, 30))                        # own difficulty

lexical_decision <- crossing(participants, words) |>
  mutate(freq_c = log_freq - mean(words$log_freq),
         rt = round(650 + u0 + w0 + (-30 + u1) * freq_c + rnorm(n(), 0, 50))) |>
  select(participant, word, log_freq, freq_c, rt)

usethis::use_data(lexical_decision, overwrite = TRUE)
