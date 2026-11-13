# zipf_rt: Statistics, lecture 5 (Transformations)
library(dplyr)
library(tibble)

set.seed(5)
zipf_rt <- tibble(rank = 1:2000,
                  freq = round(1e6 / rank)) |>        # Zipf-like frequencies
  mutate(rt = exp(6.75 - 0.06 * log10(freq) + rnorm(n(), 0, 0.18)))

usethis::use_data(zipf_rt, overwrite = TRUE)
