# Silva (2006), Phonology 23(2), 287-308.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4002)
vot_mean <- tribble(
  ~generation, ~stop, ~vot,
  "older", "tense", 12,
  "older", "lenis", 60,
  "older", "aspirated", 94,
  "younger", "tense", 12,
  "younger", "lenis", 62,
  "younger", "aspirated", 70
)
f0_shift <- tribble(
  ~generation, ~stop, ~shift,
  "older", "tense", 1,
  "older", "lenis", -3,
  "older", "aspirated", 2,
  "younger", "tense", 1,
  "younger", "lenis", -3,
  "younger", "aspirated", 2
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
         f0 = round(base * 2^((shift + rnorm(n(), 0, 1.5)) / 12))) |>
  select(speaker, generation, gender, stop, place, rep, vot, f0)

korean_stops <- korean_stops |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         stop = factor(stop, levels = c("lenis", "tense", "aspirated")),
         place = factor(place, levels = c("labial", "coronal", "velar")))

usethis::use_data(korean_stops, overwrite = TRUE)
