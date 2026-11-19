# Kutas & Hillyard (1980), Science 207, 203-205; Kutas & Hillyard (1984), Nature 307, 161-163.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(4004)
electrodes <- tibble(electrode = c("F3", "Fz", "F4", "C3", "Cz", "C4", "P3", "Pz", "P4"),
                     anteriority = rep(c("frontal", "central", "parietal"), each = 3),
                     laterality = rep(c("left", "midline", "right"), 3),
                     weight = c(0.75, 0.85, 0.75, 0.9, 1, 0.9, 0.9, 1, 0.9),
                     e0 = c(0.5, 0.8, 0.5, 0, 0.3, 0, -0.3, 0, -0.3))

participants <- tibble(participant = str_c("P", str_pad(1:30, 2, pad = "0")),
                       list = rep(1:2, 15),
                       p0 = rnorm(30, 0, 1.5),
                       p_n400 = rnorm(30, 0, 1))
items <- tibble(item = str_c("i", str_pad(1:80, 2, pad = "0")),
                cloze_expected = round(runif(80, 0.5, 0.95), 2),
                cloze_unexpected = round(runif(80, 0, 0.05), 2),
                i0 = rnorm(80, 0, 0.5))

n400 <- crossing(participants, items) |>
  mutate(condition = if_else((as.integer(str_sub(item, 2, 3)) + list) %% 2 == 0,
                             "expected", "unexpected"),
         cloze = if_else(condition == "expected", cloze_expected, cloze_unexpected),
         trial_noise = rnorm(n(), 0, 4)) |>
  crossing(electrodes) |>
  mutate(amplitude = round(2 + p0 + i0 + e0 + trial_noise +
                             weight * (-4 + p_n400) * (1 - cloze) + rnorm(n(), 0, 3), 2)) |>
  select(participant, list, item, condition, cloze, electrode, anteriority,
         laterality, amplitude)

n400 <- n400 |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         electrode = factor(electrode, levels = electrodes$electrode),
         anteriority = factor(anteriority, levels = c("frontal", "central", "parietal")),
         laterality = factor(laterality, levels = c("left", "midline", "right")),
         condition = factor(condition, levels = c("expected", "unexpected")))

usethis::use_data(n400, overwrite = TRUE)
