library(dplyr)
library(tidyr)
library(tibble)

set.seed(4003)
regions <- tibble(position = 1:12,
                  region = c("det", "noun", "rel_pronoun", "rc_det", "rc_noun",
                             "rc_participle", "rc_auxiliary", "main_verb",
                             "spillover_1", "spillover_2", "spillover_3", "final"),
                  orc_cost = c(0, 0, 0.01, 0.02, 0.03, 0.06, 0.08, 0.05, 0.02, 0, 0, 0))

participants <- tibble(participant = sprintf("P%02d", 1:48),
                       list = rep(1:2, 24),
                       p0 = rnorm(48, 0, 0.2),
                       p_orc = rnorm(48, 0, 0.03))
items <- tibble(item = sprintf("i%02d", 1:24),
                i0 = rnorm(24, 0, 0.04))

german_relatives <- crossing(participants, items, regions) |>
  mutate(condition = if_else((as.integer(substr(item, 2, 3)) + list) %% 2 == 0,
                             "subject", "object"),
         length = case_when(region %in% c("det", "rel_pronoun", "rc_det") ~ 3,
                            region == "rc_auxiliary" ~ 3,
                            TRUE ~ pmax(2, round(rnorm(n(), 6, 2)))),
         rt = round(exp(5.85 + p0 + i0 + 0.012 * (length - 5) - 0.008 * position +
                          (condition == "object") * (orc_cost + p_orc * (orc_cost > 0)) +
                          rnorm(n(), 0, 0.2))),
         condition = factor(condition, levels = c("subject", "object"))) |>
  select(participant, list, item, condition, position, region, length, rt)

german_relatives <- german_relatives |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         region = factor(region, levels = regions$region))

german_relatives <- german_relatives |>
  mutate(across(c(length), as.integer))

usethis::use_data(german_relatives, overwrite = TRUE)
