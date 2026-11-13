library(dplyr)
library(tibble)

set.seed(3013)
n <- 6000
megastudy <- tibble(word = sprintf("w%04d", 1:n),
                    log_freq = round(rnorm(n, 2.5, 1), 2)) |>
  mutate(length = pmin(pmax(round(8.5 - 0.8 * log_freq + rnorm(n, 0, 1.8)), 2), 16),
         neighbours = rpois(n, exp(3.2 - 0.38 * length)),
         aoa = round(pmin(pmax(11.5 - 1.3 * log_freq + rnorm(n, 0, 1.8), 2), 18), 1),
         concreteness = round(pmin(pmax(3 + 0.1 * log_freq - 0.08 * aoa + rnorm(n, 0, 0.9), 1), 5),
                              2),
         rt = round(720 - 120 * plogis(log_freq - 2.5) + 9 * (length - 7) -
                      2 * neighbours + 10 * (aoa - 7) - 6 * (concreteness - 3) +
                      rnorm(n, 0, 35)),
         accuracy = round(plogis(2.5 + 0.7 * (log_freq - 2.5) - 0.2 * (aoa - 7) +
                                   rnorm(n, 0, 0.5)), 3))

megastudy <- megastudy |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

megastudy <- megastudy |>
  mutate(across(c(length, neighbours), as.integer))

usethis::use_data(megastudy, overwrite = TRUE)
