# korean_stops: phonetics, the three-way laryngeal contrast in Seoul Korean
# Lenis, tense and aspirated stops differ in VOT and in the f0 of the
# following vowel. In older speakers lenis stops have intermediate VOT; in
# younger speakers lenis and aspirated VOT have merged, and the two are kept
# apart by f0 instead. 40 speakers, 36 tokens each.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4002)
vot_mean <- tribble(
  ~generation, ~stop,       ~vot,
  "older",     "tense",      12,
  "older",     "lenis",      55,
  "older",     "aspirated",  95,
  "younger",   "tense",      12,
  "younger",   "lenis",      78,
  "younger",   "aspirated",  82
)
f0_shift <- tribble(                                # semitones from speaker mean
  ~generation, ~stop,       ~shift,
  "older",     "tense",      1.2,
  "older",     "lenis",     -1.5,
  "older",     "aspirated",  1.5,
  "younger",   "tense",      1.2,
  "younger",   "lenis",     -3.5,
  "younger",   "aspirated",  2.0
)

speakers <- tibble(speaker = sprintf("S%02d", 1:40),
                   generation = rep(c("older", "younger"), each = 20),
                   gender = rep(rep(c("female", "male"), each = 10), 2),
                   base = if_else(gender == "female", 200, 115) * exp(rnorm(40, 0, 0.1)),
                   s_vot = rnorm(40, 0, 0.1))

korean_stops <- crossing(speakers, stop = c("lenis", "tense", "aspirated"),
                         place = c("labial", "coronal", "velar"), rep = 1:4) |>
  left_join(vot_mean, by = c("generation", "stop")) |>
  left_join(f0_shift, by = c("generation", "stop")) |>
  mutate(vot = round(exp(log(vot + c(labial = -5, coronal = 0, velar = 10)[place]) + s_vot +
                           rnorm(n(), 0, if_else(stop == "tense", 0.3, 0.18)))),
         f0 = round(base * 2^((shift + rnorm(n(), 0, 0.8)) / 12)),
         across(c(speaker, generation, gender, stop, place), factor)) |>
  select(speaker, generation, gender, stop, place, rep, vot, f0)

usethis::use_data(korean_stops, overwrite = TRUE)
