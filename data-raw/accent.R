library(dplyr)
library(tidyr)
library(tibble)

set.seed(2033)
speakers <- tibble(speaker = sprintf("S%02d", 1:30), l1 = rep(c("English", "Italian"), each = 15),
                   gender = rep(c("female", "male"), 15)) |>
  mutate(f0_s = if_else(gender == "female", 210, 120) + rnorm(30, 0, 15), h1h2_s = rnorm(30, 4, 2.5),
         vot_s = if_else(l1 == "English", 70, 45) + rnorm(30, 0, 10),
         ratio_s = if_else(l1 == "English", 1.6, 1.2) + rnorm(30, 0, 0.15),
         rate_s = if_else(l1 == "English", 5.2, 4.7) + rnorm(30, 0, 0.5))
accent <- crossing(speakers, token = 1:40) |>
  mutate(vot = round(exp(log(vot_s) + rnorm(n(), 0, 0.22))),
         vowel_ratio = round(exp(log(ratio_s) + rnorm(n(), 0, 0.17)), 2),
         rate = round(rate_s + rnorm(n(), 0, 0.6), 2), f0 = round(f0_s + rnorm(n(), 0, 10)),
         h1h2 = round(h1h2_s + rnorm(n(), 0, 1), 1), intensity = round(rnorm(n(), 68, 4), 1)) |>
  mutate(across(c(speaker, l1, gender), factor)) |>
  select(speaker, l1, gender, vot, vowel_ratio, rate, f0, h1h2, intensity)

accent <- accent |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(accent, overwrite = TRUE)
