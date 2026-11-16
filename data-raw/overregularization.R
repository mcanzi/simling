# Marcus et al. (1992), Monographs of the Society for Research in Child Development 57(4).
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3008)
children <- tibble(child = sprintf("C%02d", 1:24),
                   c0 = rnorm(24, 0, 0.9))

overregularization <- crossing(children, age = seq(30, 60, by = 6)) |>
  mutate(attempts = rpois(n(), 15 + (age - 30)),
         p = plogis(-3.66 + c0),
         errors = rbinom(n(), attempts, p)) |>
  select(child, age, attempts, errors)

overregularization <- overregularization |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         across(c(age, attempts, errors), as.integer))

usethis::use_data(overregularization, overwrite = TRUE)
