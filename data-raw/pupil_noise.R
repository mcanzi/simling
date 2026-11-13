library(dplyr)
library(tidyr)
library(tibble)
library(forcats)

set.seed(2031)
participants <- tibble(participant = sprintf("P%02d", 1:24),
                       p_amp = rnorm(24, 0, 40), p_lat = rnorm(24, 0, 150), p_noise = rnorm(24, 0, 30))
trials <- crossing(participants, condition = c("quiet", "noise"), trial = 1:12) |>
  mutate(trial_id = paste(participant, condition, trial, sep = "."),
         t_amp = rnorm(n(), 0, 40), t0 = rnorm(n(), 0, 15))
pupil_noise <- crossing(trials, time = seq(0, 3000, by = 100)) |>
  arrange(trial_id, time) |>
  mutate(peak = 180 + p_amp + if_else(condition == "noise", 90 + p_noise, 0) + t_amp - 4 * (trial - 6.5),
         latency = 1200 + p_lat + if_else(condition == "noise", 250, 0),
         pupil = t0 + peak * (time / latency)^3 * exp(3 * (1 - time / latency))) |>
  group_by(trial_id) |>
  mutate(pupil = round(pupil + as.numeric(arima.sim(list(ar = 0.8), n = n(), sd = 12)), 1)) |>
  ungroup() |>
  mutate(across(c(participant, condition, trial_id), factor),
         condition = fct_relevel(condition, "quiet")) |>
  select(participant, condition, trial, trial_id, time, pupil)

usethis::use_data(pupil_noise, overwrite = TRUE)
