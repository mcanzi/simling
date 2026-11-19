library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(1)
n_part <- 30
n_word <- 60

participants <- tibble(participant = str_c("P", str_pad(1:n_part, 2, pad = "0")),
                       u0 = rnorm(n_part, 0, 0.8),
                       u1 = rnorm(n_part, 0, 0.3))
words <- tibble(word = str_c("w", str_pad(1:n_word, 2, pad = "0")),
                log_freq = round(runif(n_word, 1, 6), 2),
                w0 = rnorm(n_word, 0, 0.5)) |>
  mutate(freq_c = log_freq - mean(log_freq))

lexical_accuracy <- crossing(participants, words) |>
  mutate(logit = 1.5 + u0 + w0 + (0.8 + u1) * freq_c,
         correct = rbinom(n(), size = 1, prob = plogis(logit))) |>
  select(participant, word, log_freq, freq_c, correct)

lexical_accuracy <- lexical_accuracy |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(lexical_accuracy, overwrite = TRUE)
