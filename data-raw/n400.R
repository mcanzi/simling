# n400: psycholinguistics, single-trial ERP amplitudes in the N400 window
# German sentences ending in an expected or unexpected word ("Er trinkt
# seinen Kaffee / Schrank"). Mean amplitude 300-500 ms after the final word
# at nine electrodes. The N400 is more negative the less predictable the word
# (lower cloze probability), largest over centro-parietal sites.
# 30 participants, 80 items (40 per condition, two lists).
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4004)
electrodes <- tibble(electrode = c("F3", "Fz", "F4", "C3", "Cz", "C4", "P3", "Pz", "P4"),
                     anteriority = rep(c("frontal", "central", "parietal"), each = 3),
                     laterality = rep(c("left", "midline", "right"), 3),
                     weight = c(0.5, 0.6, 0.5, 0.8, 0.9, 0.8, 0.85, 1, 0.85),
                     e0 = c(0.5, 0.8, 0.5, 0, 0.3, 0, -0.3, 0, -0.3))

participants <- tibble(participant = sprintf("P%02d", 1:30),
                       list = rep(1:2, 15),
                       p0 = rnorm(30, 0, 1.5),
                       p_n400 = rnorm(30, 0, 1))
items <- tibble(item = sprintf("i%02d", 1:80),
                cloze_expected = round(runif(80, 0.5, 0.95), 2),
                cloze_unexpected = round(runif(80, 0, 0.05), 2),
                i0 = rnorm(80, 0, 0.5))

n400 <- crossing(participants, items) |>
  mutate(condition = if_else((as.integer(substr(item, 2, 3)) + list) %% 2 == 0,
                             "expected", "unexpected"),
         cloze = if_else(condition == "expected", cloze_expected, cloze_unexpected),
         trial_noise = rnorm(n(), 0, 4)) |>
  crossing(electrodes) |>
  mutate(amplitude = round(2 + p0 + i0 + e0 + trial_noise +
                             weight * (-4 + p_n400) * (1 - cloze) + rnorm(n(), 0, 3), 2),
         condition = factor(condition, levels = c("expected", "unexpected"))) |>
  select(participant, list, item, condition, cloze, electrode, anteriority,
         laterality, amplitude)

usethis::use_data(n400, overwrite = TRUE)
