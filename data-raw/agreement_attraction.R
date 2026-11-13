# agreement_attraction: syntax, eye-tracking while reading
# "The key to the cabinet(s) was/were rusty": grammaticality x attractor number.
# Reading measures on the critical verb. 40 participants, 32 items, 4 lists.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3002)
n_part <- 40
n_item <- 32
conds <- expand_grid(grammaticality = c("grammatical", "ungrammatical"),
                     attractor = c("singular", "plural"))

participants <- tibble(participant = sprintf("P%02d", 1:n_part),
                       list = rep(1:4, length.out = n_part),
                       p0 = rnorm(n_part, 0, 0.15),       # own reading speed (log scale)
                       p_reg = rnorm(n_part, 0, 0.5),     # own tendency to regress
                       p_skip = rnorm(n_part, 0, 0.5))    # own tendency to skip
items <- tibble(item = sprintf("i%02d", 1:n_item),
                i0 = rnorm(n_item, 0, 0.08))

agreement_attraction <- crossing(participants, items) |>
  mutate(cond = (as.integer(substr(item, 2, 3)) + list) %% 4 + 1,
         grammaticality = conds$grammaticality[cond],
         attractor = conds$attractor[cond],
         ungram = grammaticality == "ungrammatical",
         plural = attractor == "plural",
         skipped = rbinom(n(), 1, plogis(-1.8 + p_skip)),
         gaze = exp(5.55 + p0 + i0 + 0.14 * ungram - 0.09 * ungram * plural +
                      rnorm(n(), 0, 0.3)),
         single = rbinom(n(), 1, 0.65),
         first_fixation = if_else(single == 1, gaze, gaze * runif(n(), 0.5, 0.85)),
         regression = rbinom(n(), 1, plogis(-1.9 + p_reg + 0.9 * ungram - 0.5 * ungram * plural)),
         reread = rbinom(n(), 1, plogis(-1 + 0.6 * ungram + 1.5 * regression)),
         rereading = if_else(reread == 1, exp(5.4 + rnorm(n(), 0, 0.4)), 0),
         # skipped words have no first-pass measures, but can be fixated later
         first_fixation = if_else(skipped == 1, NA, round(first_fixation)),
         gaze_duration = if_else(skipped == 1, NA, round(gaze)),
         regression = if_else(skipped == 1, NA, regression),
         total_time = round(if_else(skipped == 1, rereading, gaze + rereading)),
         total_time = if_else(total_time == 0, NA, total_time)) |>
  select(participant, list, item, grammaticality, attractor, skipped,
         first_fixation, gaze_duration, regression, total_time)

usethis::use_data(agreement_attraction, overwrite = TRUE)
