# Dryer (2013), WALS Online, feature 81A; Greenberg (1963), Universals of Language, 58-90.
library(dplyr)
library(tidyr)
library(tibble)

# set.seed(3016): first seed from 3010 whose word-order proportions are within 3 points of Dryer (2013).
set.seed(3016)
orders <- c("SOV", "SVO", "VSO", "no dominant order")
areas <- paste("Area", LETTERS[1:6])
area_pref <- list(c(0.60, 0.22, 0.05, 0.13), c(0.30, 0.55, 0.05, 0.10),
                  c(0.45, 0.33, 0.07, 0.15), c(0.30, 0.48, 0.10, 0.12),
                  c(0.50, 0.25, 0.10, 0.15), c(0.40, 0.35, 0.05, 0.20))

family_sizes <- pmax(1, round(rexp(100, 1 / 4)))
family_sizes <- pmax(1, round(family_sizes * 400 / sum(family_sizes)))
family_sizes[which.max(family_sizes)] <- max(family_sizes) + 400 - sum(family_sizes)

families <- tibble(family = sprintf("Family %03d", 1:100),
                   area_i = sample(1:6, 100, replace = TRUE),
                   size = family_sizes,
                   f_cons = rnorm(100, 0, 0.25)) |>
  rowwise() |>
  mutate(family_order = sample(orders, 1, prob = area_pref[[area_i]])) |>
  ungroup()

word_order <- families |>
  uncount(size) |>
  rowwise() |>
  mutate(order = if_else(runif(1) < 0.8, family_order,
                         sample(orders, 1, prob = area_pref[[area_i]]))) |>
  ungroup() |>
  mutate(language = sprintf("L%03d", sample(n())),
         area = areas[area_i],
         p_post = case_when(order == "SOV" ~ 0.92, order == "no dominant order" ~ 0.5,
                            TRUE ~ 0.12),
         adpositions = if_else(runif(n()) < p_post, "postpositions", "prepositions"),
         case_marking = if_else(runif(n()) < if_else(order == "SOV", 0.7, 0.3), "yes", "no"),
         consonants = 6 + rnbinom(n(), mu = 16 * exp(f_cons), size = 8),
         vowels = 3 + rpois(n(), 2.5)) |>
  arrange(language) |>
  select(language, family, area, order, adpositions, case_marking, consonants, vowels)

usethis::use_data(word_order, overwrite = TRUE)
