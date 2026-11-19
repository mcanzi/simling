# Design: Sprouse, Wagers & Phillips (2012), Language 88(1), 82-123.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(3001)
n_part <- 48
n_item <- 32
conds <- expand_grid(length = c("short", "long"), structure = c("non-island", "island")) |>
  mutate(cond = row_number())

participants <- tibble(participant = str_c("P", str_pad(1:n_part, 2, pad = "0")),
                       list = rep(1:4, length.out = n_part),
                       p0 = rnorm(n_part, 0, 0.8),
                       p_int = rnorm(n_part, 0, 0.3))
items <- tibble(item = str_c("i", str_pad(1:n_item, 2, pad = "0")),
                i0 = rnorm(n_item, 0, 0.4))

acceptability <- crossing(participants, items) |>
  mutate(cond = (as.integer(str_sub(item, 2, 3)) + list) %% 4 + 1) |>
  left_join(conds, by = "cond") |>
  mutate(long = length == "long", island = structure == "island",
         latent = 1.5 + p0 + i0 - 0.6 * long - 0.4 * island +
           (-0.9 + p_int) * long * island + rlogis(n()),
         rating = as.integer(cut(latent, c(-Inf, -2.5, -1.5, -0.5, 0.5, 1.5, 2.5, Inf)))) |>
  select(participant, list, item, length, structure, rating)

acceptability <- acceptability |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         length = factor(length, levels = c("short", "long")),
         structure = factor(structure, levels = c("non-island", "island")))

usethis::use_data(acceptability, overwrite = TRUE)
