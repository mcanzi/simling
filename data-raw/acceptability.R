# Design: Sprouse, Wagers & Phillips (2012), Language 88(1), 82-123.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3001)
n_part <- 48
n_item <- 32
conds <- expand_grid(length = c("short", "long"), structure = c("non-island", "island"))

participants <- tibble(participant = sprintf("P%02d", 1:n_part),
                       list = rep(1:4, length.out = n_part),
                       p0 = rnorm(n_part, 0, 0.8),
                       p_int = rnorm(n_part, 0, 0.3))
items <- tibble(item = sprintf("i%02d", 1:n_item),
                i0 = rnorm(n_item, 0, 0.4))

acceptability <- crossing(participants, items) |>
  mutate(cond = (as.integer(substr(item, 2, 3)) + list) %% 4 + 1,
         length = conds$length[cond],
         structure = conds$structure[cond],
         long = length == "long", island = structure == "island",
         latent = 1.5 + p0 + i0 - 0.6 * long - 0.4 * island +
           (-0.9 + p_int) * long * island + rlogis(n()),
         rating = as.integer(cut(latent, c(-Inf, -2.5, -1.5, -0.5, 0.5, 1.5, 2.5, Inf)))) |>
  select(participant, list, item, length, structure, rating)

acceptability <- acceptability |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         length = factor(length, levels = c("short", "long")),
         structure = factor(structure, levels = c("non-island", "island")))

usethis::use_data(acceptability, overwrite = TRUE)
