# freq_length: Statistics, lecture 8 (Interactions)
library(dplyr)
library(tibble)

set.seed(12)
freq_length <- tibble(log_freq = runif(400, 1, 6),
                      length   = round(runif(400, 3, 12))) |>
  mutate(lf_c  = log_freq - mean(log_freq),
         len_c = length - mean(length),
         rt    = 760 - 30 * lf_c + 14 * len_c - 5 * lf_c * len_c + rnorm(400, 0, 40))

usethis::use_data(freq_length, overwrite = TRUE)
