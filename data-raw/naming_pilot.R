library(dplyr)
library(tidyr)
library(tibble)

set.seed(2035)
participants <- tibble(participant = factor(sprintf("P%02d", 1:30)),
                       age_group = rep(c("younger", "older"), 15),
                       group = if_else(age_group == "older", 0.5, -0.5),
                       p0 = rnorm(30, 0, 0.08), p1 = rnorm(30, 0, 0.015))
pictures <- tibble(picture = factor(sprintf("pic%02d", 1:40)),
                   freq_c = round(runif(40, 1, 6) - 3.5, 2), w0 = rnorm(40, 0, 0.04))
naming_pilot <- crossing(participants, pictures) |>
  mutate(latency = round(exp(6.75 + p0 + w0 + 0.15 * group +
                               (-0.04 - 0.02 * group + p1) * freq_c + rnorm(n(), 0, 0.1)))) |>
  select(participant, age_group, group, picture, freq_c, latency)

usethis::use_data(naming_pilot, overwrite = TRUE)
