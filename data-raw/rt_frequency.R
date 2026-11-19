library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(42)
participants <- tibble(participant = str_c("P", str_pad(1:10, 2, pad = "0")),
                       p0 = rnorm(10, 0, 0.12))
words <- tibble(word = str_c("w", str_pad(1:20, 2, pad = "0")),
                frequency = rep(c("high", "low"), each = 10),
                w0 = rnorm(20, 0, 0.06))

rt_frequency <- crossing(participants, words) |>
  mutate(rt = round(exp(6.38 + p0 + w0 + 0.1 * (frequency == "low") + rnorm(n(), 0, 0.15))),
         correct = rbinom(n(), 1, if_else(frequency == "low", 0.85, 0.95))) |>
  select(participant, word, frequency, rt, correct)

rt_frequency <- rt_frequency |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         frequency = factor(frequency, levels = c("high", "low")))

usethis::use_data(rt_frequency, overwrite = TRUE)
