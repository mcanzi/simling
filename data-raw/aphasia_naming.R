# Best, Greenwood, Grassly, Herbert, Hickin & Howard (2013), Cortex 49(9), 2345-2357.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5111)
participants <- tibble(participant = sprintf("P%02d", 1:16),
                       profile = rep(c("phonological", "other"), c(5, 11)),
                       p0 = rnorm(16, -0.45, 0.9),
                       gain = rnorm(16, 1, 0.35),
                       spread = rnorm(16, 0, 0.1))

items <- participants |>
  crossing(item_no = 1:120) |>
  mutate(item = sprintf("%s_%03d", participant, item_no),
         set = if_else(item_no <= 60, "treated", "untreated"),
         i0 = rnorm(n(), 0, 1.2))

aphasia_naming <- items |>
  crossing(session = c("baseline 1", "baseline 2", "post-therapy")) |>
  mutate(post = session == "post-therapy",
         untreated_gain = if_else(profile == "phonological", 0.7, 0.05) + spread,
         eta = p0 + i0 + post * if_else(set == "treated", gain, untreated_gain),
         correct = rbinom(n(), 1, plogis(eta))) |>
  select(participant, profile, item, set, session, correct)

aphasia_naming <- aphasia_naming |>
  mutate(participant = factor(participant, levels = sort(unique(participant), method = "radix")),
         profile = factor(profile, levels = c("other", "phonological")),
         item = factor(item, levels = sort(unique(item), method = "radix")),
         set = factor(set, levels = c("untreated", "treated")),
         session = factor(session, levels = c("baseline 1", "baseline 2", "post-therapy")),
         correct = as.integer(correct)) |>
  arrange(participant, item, session)

usethis::use_data(aphasia_naming, overwrite = TRUE)
