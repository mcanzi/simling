# l2_frequency: Statistics, lecture 8 (Interactions)
library(dplyr)
library(tibble)

set.seed(10)
l2_frequency <- tibble(group    = rep(c("L1", "L2"), each = 200),
                       log_freq = runif(400, 1, 6)) |>
  mutate(rt = if_else(group == "L1", 700 - 25 * log_freq,
                                     900 - 55 * log_freq) + rnorm(400, 0, 40))

usethis::use_data(l2_frequency, overwrite = TRUE)
