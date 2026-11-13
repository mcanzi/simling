# pilot_rt: Advanced Statistics, session 8 (Power analysis)
library(dplyr)
library(tidyr)
library(tibble)

set.seed(2035)
participants <- tibble(participant = factor(sprintf("P%02d", 1:30)),
                       group = rep(c(-0.5, 0.5), 15),
                       p0 = rnorm(30, 0, 60), p1 = rnorm(30, 0, 12))
words <- tibble(word = factor(sprintf("w%02d", 1:40)),
                freq_c = runif(40, 1, 6) - 3.5, w0 = rnorm(40, 0, 30))
pilot_rt <- crossing(participants, words) |>
  mutate(rt = 750 + p0 + w0 + 120 * group + (-30 - 20 * group + p1) * freq_c + rnorm(n(), 0, 70)) |>
  select(participant, group, word, freq_c, rt)

usethis::use_data(pilot_rt, overwrite = TRUE)
