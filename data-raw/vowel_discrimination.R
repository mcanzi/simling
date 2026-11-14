# Georgiou & Giannakou (2024), Journal of Psycholinguistic Research 53, 9;
# Macmillan & Creelman (2005), Detection Theory: A User's Guide.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3020)
contrasts <- tibble(contrast = c("FLEECE-KIT", "FLEECE-DRESS", "START-STRUT", "TRAP-START",
                                 "THOUGHT-LOT", "GOOSE-FOOT"),
                    d_L1 = c(4.2, 4.6, 4.0, 4.4, 4.3, 3.9),
                    d_L2 = c(0.9, 2.6, 0.7, 1.3, 2.3, 1.0))

listeners <- tibble(listener = c(sprintf("E%02d", 1:20), sprintf("G%02d", 1:30)),
                    group = rep(c("L1", "L2"), c(20, 30)),
                    skill = rnorm(50, 0, 0.2),
                    criterion = rnorm(50, 2, 0.35))

pairs <- tibble(pair = rep(c("AA", "BB", "AB", "BA"), each = 4),
                trial_type = rep(c("same", "different"), each = 8))

vowel_discrimination <- expand_grid(listeners, contrasts, pairs) |>
  mutate(d = if_else(group == "L1", d_L1, d_L2) * exp(skill),
         x1 = rnorm(n()),
         x2 = rnorm(n()) + d * (trial_type == "different"),
         response = if_else(abs(x2 - x1) > criterion, "different", "same")) |>
  group_by(listener) |>
  mutate(trial = sample(n())) |>
  ungroup() |>
  arrange(listener, trial) |>
  select(listener, group, trial, contrast, pair, trial_type, response)

vowel_discrimination <- vowel_discrimination |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         contrast = factor(contrast, levels = contrasts$contrast),
         trial = as.integer(trial))

usethis::use_data(vowel_discrimination, overwrite = TRUE)
