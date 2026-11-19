# Dryer (2013), WALS Online, feature 81A; Greenberg (1963), Universals of Language, 58-90.
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(tibble)

set.seed(3016)
orders <- c("SOV", "SVO", "VSO", "no dominant order")
areas <- tibble(area_i = 1:6,
                area = str_c("Area ", LETTERS[1:6]),
                pref = list(c(0.60, 0.22, 0.05, 0.13), c(0.30, 0.55, 0.05, 0.10),
                            c(0.45, 0.33, 0.07, 0.15), c(0.30, 0.48, 0.10, 0.12),
                            c(0.50, 0.25, 0.10, 0.15), c(0.40, 0.35, 0.05, 0.20)))

families <- tibble(size = pmax(1, round(rexp(100, 1 / 4)))) |>
  mutate(size = pmax(1, round(size * 400 / sum(size))),
         size = if_else(row_number() == which.max(size), max(size) + 400 - sum(size), size),
         family = str_c("Family ", str_pad(1:100, 3, pad = "0")),
         area_i = sample(1:6, 100, replace = TRUE),
         f_cons = rnorm(100, 0, 0.25)) |>
  left_join(areas, by = "area_i") |>
  mutate(family_order = map_chr(pref, \(p) sample(orders, 1, prob = p)))

word_order <- families |>
  uncount(size) |>
  mutate(order = map2_chr(family_order, pref,
                          \(fo, p) if_else(runif(1) < 0.8, fo, sample(orders, 1, prob = p)))) |>
  mutate(language = str_c("L", str_pad(sample(n()), 3, pad = "0")),
         p_post = case_when(order == "SOV" ~ 0.92, order == "no dominant order" ~ 0.5,
                            TRUE ~ 0.12),
         adpositions = if_else(runif(n()) < p_post, "postpositions", "prepositions"),
         case_marking = if_else(runif(n()) < if_else(order == "SOV", 0.7, 0.3), "yes", "no"),
         consonants = 6 + rnbinom(n(), mu = 16 * exp(f_cons), size = 8),
         vowels = 3 + rpois(n(), 2.5)) |>
  arrange(language) |>
  select(language, family, area, order, adpositions, case_marking, consonants, vowels)

word_order <- word_order |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         order = factor(order, levels = c("SOV", "SVO", "VSO", "no dominant order")),
         adpositions = factor(adpositions, levels = c("postpositions", "prepositions")),
         case_marking = factor(case_marking, levels = c("no", "yes")),
         across(c(consonants, vowels), as.integer))

usethis::use_data(word_order, overwrite = TRUE)
