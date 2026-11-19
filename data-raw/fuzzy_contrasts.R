# Strycharczuk & Scobbie (2017), Laboratory Phonology 8(1), 7, Tables 1 and 2.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(2017)
speakers <- tibble(age_group = rep(c("older", "younger"), each = 10),
                   sex = rep(rep(c("female", "male"), c(7, 3)), 2)) |>
  mutate(speaker = str_c(if_else(age_group == "older", "O", "Y"),
                         if_else(sex == "female", "F", "M"),
                         row_number()),
         .by = c(age_group, sex))
words <- tribble(
  ~vowel, ~context, ~word,
  "GOOSE", "morpheme_internal", "hula",
  "GOOSE", "morpheme_internal", "Pooley",
  "GOOSE", "morpheme_internal", "goulash",
  "GOOSE", "morpheme_final", "fool-ing",
  "GOOSE", "morpheme_final", "pool-ing",
  "GOOSE", "morpheme_final", "school-ing",
  "GOOSE", "word_prevocalic", "fool#it",
  "GOOSE", "word_prevocalic", "pool#it",
  "GOOSE", "word_prevocalic", "school#in here",
  "GOOSE", "word_preconsonantal", "fool#five",
  "GOOSE", "word_preconsonantal", "pool#five",
  "GOOSE", "word_preconsonantal", "school#five",
  "FOOT", "morpheme_internal", "bully",
  "FOOT", "morpheme_internal", "bullet",
  "FOOT", "morpheme_internal", "Fulham",
  "FOOT", "morpheme_final", "pull-ing",
  "FOOT", "morpheme_final", "bull-ish",
  "FOOT", "morpheme_final", "full-ish",
  "FOOT", "word_prevocalic", "pull#it",
  "FOOT", "word_prevocalic", "bull#in here",
  "FOOT", "word_prevocalic", "full#in here",
  "FOOT", "word_preconsonantal", "pull#five",
  "FOOT", "word_preconsonantal", "bull#five",
  "FOOT", "word_preconsonantal", "full#five"
) |>
  mutate(w0 = rnorm(n(), 0, 0.1))
durations <- tribble(
  ~vowel, ~context, ~dur_mean, ~dur_sd,
  "GOOSE", "morpheme_internal", 233, 76,
  "GOOSE", "morpheme_final", 227, 42,
  "GOOSE", "word_prevocalic", 231, 61,
  "GOOSE", "word_preconsonantal", 381, 114,
  "FOOT", "morpheme_internal", 153, 32,
  "FOOT", "morpheme_final", 153, 29,
  "FOOT", "word_prevocalic", 180, 66,
  "FOOT", "word_preconsonantal", 343, 103
)
older_contrast <- speakers |>
  filter(age_group == "older") |>
  slice_sample(n = 4) |>
  pull(speaker)
speaker_vowel <- crossing(speakers, vowel = c("GOOSE", "FOOT")) |>
  mutate(s0 = rnorm(n(), 0, 0.3),
         final = case_when(vowel == "GOOSE" ~ runif(n(), 1, 2.2),
                           speaker == "YF7" ~ -0.6,
                           speaker == "YF6" ~ 0.2,
                           speaker == "YM1" ~ 0,
                           age_group == "younger" ~ 0.8,
                           speaker %in% older_contrast ~ 0.7,
                           .default = 0))
tokens <- speaker_vowel |>
  inner_join(words, by = "vowel", relationship = "many-to-many") |>
  left_join(durations, by = c("vowel", "context")) |>
  crossing(repetition = 1:4) |>
  mutate(token = str_c(speaker, word, repetition, sep = "."),
         duration = round(pmax(rnorm(n(), dur_mean, dur_sd), 80)),
         effect = case_when(context == "morpheme_internal" ~ 0,
                            context == "morpheme_final" ~ final,
                            context == "word_prevocalic" & vowel == "GOOSE" ~ 2.6,
                            context == "word_prevocalic" ~ 2,
                            .default = 4),
         t0 = rnorm(n(), 0, 0.3))
fuzzy_contrasts <- crossing(tokens, time = seq(0, 100, by = 10)) |>
  arrange(token, time) |>
  mutate(ld = -2 + s0 + w0 + t0 + 0.6 * time / 100 + effect * (1 - 0.25 * time / 100)) |>
  group_by(token) |>
  mutate(ld = round(ld + as.numeric(arima.sim(list(ar = 0.8), n = n(), sd = 0.2)), 3)) |>
  ungroup() |>
  select(speaker, age_group, sex, vowel, context, word, repetition, token, duration, time, ld)

fuzzy_contrasts <- fuzzy_contrasts |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         vowel = factor(vowel, levels = c("GOOSE", "FOOT")),
         context = factor(context, levels = c("morpheme_internal", "morpheme_final",
                                              "word_prevocalic", "word_preconsonantal")))

usethis::use_data(fuzzy_contrasts, overwrite = TRUE)
