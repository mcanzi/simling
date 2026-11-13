library(dplyr)
library(tibble)

set.seed(6)
word_rt <- tibble(
  log_freq = round(runif(400, 1, 6), 2),
  length = pmin(pmax(round(11 - 1.1 * log_freq + rnorm(400, 0, 1.6)), 2), 14),
  syllables = pmax(round(length / 3 + rnorm(400, 0, 0.35)), 1)
) |>
  mutate(rt = round(exp(6.62 - 0.04 * (log_freq - 3.5) + 0.0186 * (length - 7) +
                          rnorm(n(), 0, 0.06))))

usethis::use_data(word_rt, overwrite = TRUE)
