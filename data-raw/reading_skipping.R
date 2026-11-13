# Rayner, Slattery, Drieghe & Liversedge (2011), Journal of Experimental Psychology: Human Perception and Performance 37(2), 514-528.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5103)
cells <- tribble(~length, ~predictability, ~skip, ~ffd, ~gd,
  "short", "predictable", 0.36, 205, 211, "short", "unpredictable", 0.28, 209, 222,
  "medium", "predictable", 0.22, 193, 213, "medium", "unpredictable", 0.18, 204, 231,
  "long", "predictable", 0.18, 195, 222, "long", "unpredictable", 0.10, 211, 246)

items <- tibble(item = sprintf("I%02d", 1:54),
                length = rep(c("short", "medium", "long"), each = 18)) |>
  mutate(letters = case_when(length == "short" ~ sample(4:6, n(), TRUE),
                             length == "medium" ~ sample(7:9, n(), TRUE),
                             TRUE ~ sample(10:12, n(), TRUE)),
         i_skip = rnorm(n(), 0, 0.4), i_t = rnorm(n(), 0, 0.06))

readers <- tibble(reader = sprintf("R%02d", 1:28),
                  r_skip = rnorm(28, 0, 0.6), r_t = rnorm(28, 0, 0.12))

reading_skipping <- crossing(readers, items) |>
  mutate(predictability = if_else((as.integer(factor(reader)) + as.integer(factor(item))) %% 2 == 0,
                                  "predictable", "unpredictable")) |>
  left_join(cells, by = c("length", "predictability")) |>
  mutate(cloze = round(pmin(pmax(if_else(predictability == "predictable",
                                          rnorm(n(), 0.74, 0.12), rnorm(n(), 0.15, 0.08)),
                                  0), 1), 2),
         skipped = rbinom(n(), 1, plogis(qlogis(skip) + 0.12 + r_skip + i_skip)),
         refix = rbinom(n(), 1, (gd - ffd) / 180),
         first_fixation = round(exp(log(ffd) + r_t + i_t + rnorm(n(), 0, 0.25))),
         gaze_duration = round(first_fixation + refix * exp(log(180) - 0.045 + rnorm(n(), 0, 0.3)))) |>
  mutate(first_fixation = if_else(skipped == 1L, NA_real_, first_fixation),
         gaze_duration = if_else(skipped == 1L, NA_real_, gaze_duration)) |>
  select(reader, item, length, letters, predictability, cloze, skipped, first_fixation,
         gaze_duration)

reading_skipping <- reading_skipping |>
  mutate(reader = factor(reader, levels = sort(unique(reader), method = "radix")),
         item = factor(item, levels = sort(unique(item), method = "radix")),
         length = factor(length, levels = c("short", "medium", "long")),
         predictability = factor(predictability, levels = c("unpredictable", "predictable")),
         across(c(letters, skipped, first_fixation, gaze_duration), as.integer))

usethis::use_data(reading_skipping, overwrite = TRUE)
