# lexical_decision_l2: Advanced Statistics, sessions 1 (Refresher) and 2 (Figures)
library(dplyr)
library(tidyr)
library(tibble)

set.seed(2027)
participants <- tibble(participant = sprintf("P%02d", 1:30),
                       group = rep(c("L1", "L2"), each = 15),
                       p0 = rnorm(30, 0, 60),
                       p1 = rnorm(30, 0, 12))
words <- tibble(word = sprintf("w%02d", 1:40),
                log_freq = runif(40, 1, 6),
                length = pmin(pmax(round(11 - 1.1 * log_freq + rnorm(40, 0, 1.6)), 3), 13),
                w0 = rnorm(40, 0, 30))
lexical_decision_l2 <- crossing(participants, words) |>
  mutate(slope = -25 + p1 + if_else(group == "L2", -25, 0),
         rt = round(700 + p0 + w0 + if_else(group == "L2", 120, 0) +
                    slope * (log_freq - 3.5) + 12 * (length - 7) + rnorm(n(), 0, 70))) |>
  select(participant, group, word, log_freq, length, rt)

usethis::use_data(lexical_decision_l2, overwrite = TRUE)
