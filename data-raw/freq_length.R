library(dplyr)
library(tibble)

set.seed(12)
freq_length <- tibble(log_freq = round(runif(400, 1, 6), 2),
                      length = round(runif(400, 3, 12))) |>
  mutate(lf_c = log_freq - mean(log_freq),
         len_c = length - mean(length),
         rt = round(exp(6.63 - 0.04 * lf_c + 0.018 * len_c - 0.0065 * lf_c * len_c +
                             rnorm(n(), 0, 0.05))))

freq_length <- freq_length |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(freq_length, overwrite = TRUE)
