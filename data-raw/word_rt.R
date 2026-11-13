# word_rt: Statistics, lecture 6 (Multiple regression)
library(tibble)

set.seed(6)
word_rt <- tibble(
  log_freq  = runif(400, 1, 6),                       # log10 frequency
  length    = pmin(pmax(round(11 - 1.1 * log_freq +   # in letters:
                              rnorm(400, 0, 1.6)), 2), 14),  # frequent words are shorter
  syllables = pmax(round(length / 3 + rnorm(400, 0, 0.35)), 1),
  rt        = 760 - 30 * log_freq + 14 * length + rnorm(400, 0, 45)
)

usethis::use_data(word_rt, overwrite = TRUE)
