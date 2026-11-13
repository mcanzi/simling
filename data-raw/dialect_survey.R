# dialect_survey: dialectology, a geographic survey with coordinates
# Degemination (gatto pronounced [gato]) in the speech of 4 speakers at each
# of 150 towns in mainland Italy and Sicily. Northern dialects degeminate,
# central and southern ones keep geminates, with a sharp transition along a
# stylised La Spezia-Rimini line (about 44.1° N). Older speakers degeminate
# more. Each speaker reads 10 words with a geminate.
# Town names and coordinates come from maps::world.cities (towns over 50,000
# inhabitants); the dialect data are simulated, not real survey results.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4009)
towns <- maps::world.cities |>
  filter(country.etc == "Italy", pop > 50000,
         !(long < 10 & lat < 41.5)) |>                 # leave out Sardinia
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

# mark non-ASCII strings as UTF-8 so they display correctly in every locale
dialect_survey <- dialect_survey |>
  mutate(across(where(is.character), enc2utf8),
         across(where(is.factor), \(f) { levels(f) <- enc2utf8(levels(f)); f }))

usethis::use_data(dialect_survey, overwrite = TRUE)
