# visual_world: psycholinguistics/semantics, visual-world eye tracking
# "The boy will eat/move the cake": a restrictive verb lets listeners look at
# the only edible object before the noun. Four objects on screen; looks to the
# target in 50 ms bins from verb onset. The noun starts at 600 ms.
# 32 participants, 24 items (12 per condition, 2 lists).
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3004)
n_part <- 32
n_item <- 24

participants <- tibble(participant = sprintf("P%02d", 1:n_part),
                       list = rep(1:2, length.out = n_part),
                       p_mid = rnorm(n_part, 0, 80),        # own speed of looking (ms)
                       p_top = rnorm(n_part, 0, 0.3))       # own final looks to target
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
  mutate(samples = 25L,                                     # 50 ms at 500 Hz
         target = rbinom(n(), samples, plogis(logit_p))) |>
  select(participant, list, item, condition, time, target, samples)

usethis::use_data(visual_world, overwrite = TRUE)
