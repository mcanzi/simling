library(dplyr)
library(tidyr)
library(tibble)

set.seed(21)
n_subj <- 20
n_item <- 40

z0 <- rnorm(n_subj)
z1 <- rnorm(n_subj)
participants <- tibble(participant = sprintf("P%02d", 1:n_subj),
                       u0 = 0.11 * z0,
                       u1 = 0.025 * (-0.6 * z0 + sqrt(1 - 0.36) * z1))
words <- tibble(word = sprintf("w%02d", 1:n_item),
                log_freq = round(runif(n_item, 1, 6), 2),
                w0 = rnorm(n_item, 0, 0.045))

lexical_decision <- crossing(participants, words) |>
  mutate(freq_c = log_freq - mean(words$log_freq),
         rt = round(exp(6.47 + u0 + w0 + (-0.045 + u1) * freq_c + rnorm(n(), 0, 0.075)))) |>
  select(participant, word, log_freq, freq_c, rt)

usethis::use_data(lexical_decision, overwrite = TRUE)
