# Design and example sentence: Altmann & Kamide (1999), Cognition 73(3), 247-264.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3004)
n_part <- 32
n_item <- 24

participants <- tibble(participant = sprintf("P%02d", 1:n_part),
                       list = rep(1:2, length.out = n_part),
                       p_mid = rnorm(n_part, 0, 80),
                       p_top = rnorm(n_part, 0, 0.3))
items <- tibble(item = sprintf("i%02d", 1:n_item),
                i_mid = rnorm(n_item, 0, 40))

trials <- crossing(participants, items) |>
  mutate(condition = if_else((as.integer(substr(item, 2, 3)) + list) %% 2 == 0,
                             "restrictive", "non-restrictive"),
         mid = if_else(condition == "restrictive", 650, 900) + p_mid + i_mid)

visual_world <- crossing(trials, time = seq(0, 1450, by = 50)) |>
  arrange(participant, item, time) |>
  mutate(logit_p = qlogis(0.25) + (2 + p_top - qlogis(0.25)) * plogis((time - mid) / 90)) |>
  group_by(participant, item) |>
  mutate(logit_p = logit_p + as.numeric(arima.sim(list(ar = 0.9), n = n(), sd = 0.25))) |>
  ungroup() |>
  mutate(samples = 25L,
         target = rbinom(n(), samples, plogis(logit_p)),
         comp_share = 1 / 3 + 0.25 * exp(-((time - 850) / 150)^2),
         competitor = rbinom(n(), samples - target, comp_share),
         distractor_1 = rbinom(n(), samples - target - competitor, 0.5),
         distractor_2 = samples - target - competitor - distractor_1) |>
  select(participant, list, item, condition, time, target, competitor,
         distractor_1, distractor_2, samples)

visual_world <- visual_world |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         condition = factor(condition, levels = c("non-restrictive", "restrictive")))

usethis::use_data(visual_world, overwrite = TRUE)
