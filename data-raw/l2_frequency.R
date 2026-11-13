# l2_frequency: psycholinguistics, frequency effects in L1 and L2 speakers
# Statistics, lecture 8 (Interactions)
library(dplyr)
library(tibble)

set.seed(10)
l2_frequency <- tibble(group    = rep(c("L1", "L2"), each = 200),
                       log_freq = round(runif(400, 1, 6), 2)) |>
  mutate(rt = round(exp(if_else(group == "L1", 6.56 - 0.04 * log_freq,
                                               6.85 - 0.07 * log_freq) +
                          rnorm(n(), 0, 0.06))))

usethis::use_data(l2_frequency, overwrite = TRUE)
