library(dplyr)
library(tidyr)
library(tibble)

set.seed(2032)
speakers <- tibble(speaker = sprintf("S%02d", 1:40), age = round(runif(40, 18, 80)),
                   gender = sample(rep(c("female", "male"), 20)), s0 = rnorm(40, 0, 0.5)) |>
  mutate(education = if_else(age + rnorm(40, 0, 10) > 50, "school", "university"))
td_deletion <- crossing(speakers, token = 1:50) |>
  mutate(following = sample(c("consonant", "vowel", "pause"), n(), TRUE, prob = c(0.5, 0.3, 0.2)),
         morph = sample(c("monomorpheme", "past"), n(), TRUE, prob = c(0.6, 0.4)),
         rate = round(rnorm(n(), 5, 0.8), 2), log_freq = round(runif(n(), 1, 6), 2),
         noise_cont = rnorm(n()), noise_bin = sample(c("a", "b"), n(), TRUE),
         eta = -0.8 + s0 + 1.8 * (following == "consonant") + 0.4 * (following == "pause") -
           1 * (morph == "past") + 0.9 * (rate - 5) * (following == "consonant") +
           1.2 * plogis((45 - age) / 5) + 0.25 * (log_freq - 3.5),
         deleted = if_else(rbinom(n(), 1, plogis(eta)) == 1, "deleted", "retained")) |>
  select(speaker, deleted, following, morph, rate, log_freq, age, gender, education,
         noise_cont, noise_bin)

td_deletion <- td_deletion |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         following = factor(following, levels = c("vowel", "pause", "consonant")),
         morph = factor(morph, levels = c("monomorpheme", "past")),
         deleted = factor(deleted, levels = c("retained", "deleted")),
         across(c(age), as.integer))

usethis::use_data(td_deletion, overwrite = TRUE)
