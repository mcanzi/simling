# lexical_accuracy: psycholinguistics, accuracy in an Italian lexical decision task
# Statistics, lecture 12 (Mixed logistic regression)
library(dplyr)
library(tidyr)
library(tibble)

set.seed(1)
n_part <- 30
n_word <- 60

participants <- tibble(participant = sprintf("P%02d", 1:n_part),
                       u0 = rnorm(n_part, 0, 0.8),     # own accuracy
                       u1 = rnorm(n_part, 0, 0.3))     # own frequency effect
words <- tibble(word     = sprintf("w%02d", 1:n_word),
                log_freq = round(runif(n_word, 1, 6), 2),
                w0       = rnorm(n_word, 0, 0.5))      # own difficulty

lexical_accuracy <- crossing(participants, words) |>
  mutate(freq_c  = log_freq - mean(words$log_freq),
         logit   = 1.5 + u0 + w0 + (0.8 + u1) * freq_c,
         correct = rbinom(n(), size = 1, prob = plogis(logit))) |>
  select(participant, word, log_freq, freq_c, correct)

usethis::use_data(lexical_accuracy, overwrite = TRUE)
