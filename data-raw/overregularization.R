# overregularization: language acquisition, errors out of attempts
# Past-tense overregularizations ("goed", "holded") of irregular verbs: 24
# children recorded every 6 months from 30 to 60 months. Errors are rare and
# peak around 42 months.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3008)
children <- tibble(child = sprintf("C%02d", 1:24),
                   c0 = rnorm(24, 0, 0.5))

overregularization <- crossing(children, age = seq(30, 60, by = 6)) |>
  mutate(attempts = rpois(n(), 15 + (age - 30)),
         p = plogis(-3 + c0 - 0.006 * (age - 42)^2),
         errors = rbinom(n(), attempts, p)) |>
  select(child, age, attempts, errors)

usethis::use_data(overregularization, overwrite = TRUE)
