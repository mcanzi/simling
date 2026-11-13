library(dplyr)
library(tibble)

set.seed(10)
l2_frequency <- tibble(group = rep(c("L1", "L2"), each = 200),
                       log_freq = round(runif(400, 1, 6), 2)) |>
  mutate(rt = round(exp(if_else(group == "L1", 6.56 - 0.04 * log_freq,
                                               6.85 - 0.07 * log_freq) +
                          rnorm(n(), 0, 0.06))))

l2_frequency <- l2_frequency |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         group = factor(group, levels = c("L1", "L2")))

usethis::use_data(l2_frequency, overwrite = TRUE)
