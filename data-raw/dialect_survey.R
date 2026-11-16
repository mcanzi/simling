# Towns and coordinates: maps::world.cities (towns over 50,000 inhabitants).
library(dplyr)
library(tidyr)

set.seed(4009)
towns <- maps::world.cities |>
  filter(country.etc == "Italy", pop > 50000,
         !(long < 10 & lat < 41.5)) |>
  transmute(town = name, lat, long) |>
  arrange(desc(lat)) |>
  mutate(t0 = rnorm(n(), 0, 0.6))

dialect_survey <- towns |>
  crossing(speaker_no = 1:4) |>
  mutate(speaker = paste(town, speaker_no, sep = "_"),
         age = round(runif(n(), 20, 80)),
         p = plogis(-1.5 + 6 * (lat - 44.1) + t0 + 0.03 * (age - 50)),
         words = 10L,
         degeminated = rbinom(n(), words, p)) |>
  select(town, lat, long, speaker, age, words, degeminated)

dialect_survey <- dialect_survey |>
  mutate(across(where(is.character), enc2utf8),
         across(where(is.factor), \(f) factor(f, levels = levels(f), labels = enc2utf8(levels(f)))))

dialect_survey <- dialect_survey |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         across(c(age), as.integer))

usethis::use_data(dialect_survey, overwrite = TRUE)
