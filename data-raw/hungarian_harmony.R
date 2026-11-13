# Hayes & Londe (2006), Phonology 23, 59-104; Hayes, Zuraw, Siptár & Londe (2009), Language 85, 822-863.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5004)
stem_types <- tribble(
  ~stem_type, ~n_neutral, ~last_vowel,     ~p_back,
  "B",        0,          "back",          0.97,
  "F",        0,          "front rounded", 0.03,
  "N",        2,          "high",          0.08,
  "Bi",       1,          "high",          0.90,
  "Bé",       1,          "mid",           0.60,
  "Be",       1,          "low",           0.35,
  "BNN",      2,          "low",           0.20
)

items <- stem_types |>
  uncount(12) |>
  mutate(item = sprintf("i%02d", row_number()),
         i0 = rnorm(n(), 0, 0.4))

participants <- tibble(participant = sprintf("P%02d", 1:50),
                       p0 = rnorm(50, 0, 0.5))

hungarian_harmony <- crossing(participants, items) |>
  mutate(suffix = if_else(rbinom(n(), 1, plogis(qlogis(p_back) + p0 + i0)) == 1,
                          "back", "front")) |>
  select(participant, item, stem_type, n_neutral, last_vowel, suffix)

hungarian_harmony <- hungarian_harmony |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         stem_type = factor(stem_type, levels = stem_types$stem_type),
         last_vowel = factor(last_vowel, levels = c("back", "front rounded", "high", "mid", "low")),
         suffix = factor(suffix, levels = c("back", "front")))

hungarian_harmony <- hungarian_harmony |>
  mutate(across(where(is.factor), \(f) { levels(f) <- enc2utf8(levels(f)); f }))

usethis::use_data(hungarian_harmony, overwrite = TRUE)
