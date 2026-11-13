# rt_frequency: Statistics, lecture 2 (Data wrangling)
library(tibble)

set.seed(42)
rt_frequency <- tibble(
  participant = rep(sprintf("P%02d", 1:10), each = 20),
  word        = rep(sprintf("w%02d", 1:20), times = 10),
  frequency   = rep(rep(c("high", "low"), each = 10), times = 10),
  rt          = round(rnorm(200, mean = 600, sd = 80) +
                        rep(rep(c(0, 60), each = 10), times = 10)),
  accuracy    = rbinom(200, size = 1, prob = 0.9)
)

usethis::use_data(rt_frequency, overwrite = TRUE)
