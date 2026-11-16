# Kirby, Cornish & Smith (2008), Proceedings of the National Academy of Sciences 105(31), 10681-10686.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5105)
chains <- tibble(condition = rep(c("no filter", "filter"), each = 4),
                 chain = paste(rep(c("A", "B"), each = 4), 1:4, sep = "")) |>
  mutate(c_err = rnorm(n(), 0, 0.3), c_str = rnorm(n(), 0, 0.15), c_words = rnorm(n(), 0, 0.2))

iterated_learning <- chains |>
  crossing(generation = 1:10) |>
  mutate(filter = condition == "filter",
         error = round(plogis(qlogis(if_else(filter, 0.72, 0.8)) -
                                if_else(filter, 0.2, 0.55) * (generation - 1) + c_err +
                                rnorm(n(), 0, 0.3)), 3),
         structure = round(if_else(filter, 0.75, 0.6) * (generation - 1) * (1 + c_str) +
                             rnorm(n(), 0, 1.2), 2),
         words = pmin(27L, rpois(n(), exp(if_else(filter,
                                                  log(22) - 0.04 * (generation - 1),
                                                  log(20) - 0.18 * (generation - 1)) + c_words)) + 1L)) |>
  select(condition, chain, generation, error, words, structure)

iterated_learning <- iterated_learning |>
  mutate(condition = factor(condition, levels = c("no filter", "filter")),
         chain = factor(chain, levels = sort(unique(chain), method = "radix")),
         generation = as.integer(generation), words = as.integer(words))

usethis::use_data(iterated_learning, overwrite = TRUE)
