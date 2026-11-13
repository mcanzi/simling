library(dplyr)
library(tidyr)
library(tibble)

set.seed(2027)
participants <- tibble(participant = sprintf("P%02d", 1:30),
                       group = rep(c("L1", "L2"), each = 15),
                       p0 = rnorm(30, 0, 0.085),
                       p1 = rnorm(30, 0, 0.015))
words <- tibble(word = sprintf("w%02d", 1:40),
                log_freq = round(runif(40, 1, 6), 2),
                length = pmin(pmax(round(11 - 1.1 * log_freq + rnorm(40, 0, 1.6)), 3), 13),
                w0 = rnorm(40, 0, 0.04))
lexical_decision_l2 <- crossing(participants, words) |>
  mutate(slope = -0.035 + p1 + if_else(group == "L2", -0.03, 0),
         rt = round(exp(6.55 + p0 + w0 + if_else(group == "L2", 0.16, 0) +
                        slope * (log_freq - 3.5) + 0.017 * (length - 7) + rnorm(n(), 0, 0.09)))) |>
  select(participant, group, word, log_freq, length, rt)

lexical_decision_l2 <- lexical_decision_l2 |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         group = factor(group, levels = c("L1", "L2")))

usethis::use_data(lexical_decision_l2, overwrite = TRUE)
