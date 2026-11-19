# Tone letters: Chao (1930), Le Maître Phonétique 45, 24-27.
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(tibble)

set.seed(4001)
targets <- list(T1 = c(5, 5, 5, 4.9, 4.8),
                T2 = c(3, 2.8, 3.3, 4.2, 5),
                T3 = c(2.2, 1.6, 1, 1.3, 2.5),
                T4 = c(5, 4.6, 3.7, 2.5, 1.2))
contour <- function(tone, time) {
  spline(c(0, 25, 50, 75, 100), pluck(targets, tone), xout = time, method = "natural") |>
    pluck("y")
}

speakers <- tibble(speaker = str_c("S", str_pad(1:12, 2, pad = "0")),
                   gender = rep(c("female", "male"), each = 6),
                   base = if_else(gender == "female", 160, 90) * exp(rnorm(12, 0, 0.08)),
                   span = rnorm(12, 2.5, 0.3))

tokens <- crossing(speakers, tone = names(targets), syllable = str_c("syl", 1:8)) |>
  mutate(token_id = str_c(speaker, tone, syllable, sep = "."),
         duration = case_when(tone == "T1" ~ 250, tone == "T2" ~ 270,
                              tone == "T3" ~ 300, tone == "T4" ~ 220),
         duration = round(exp(log(duration) + rnorm(n(), 0, 0.12))),
         t0 = rnorm(n(), 0, 0.5))

mandarin_tones <- crossing(tokens, time = seq(0, 100, by = 10)) |>
  arrange(token_id, time) |>
  group_by(tone) |>
  mutate(level = contour(first(tone), time)) |>
  group_by(token_id) |>
  mutate(st = (level - 1) * span + t0 +
           as.numeric(arima.sim(list(ar = 0.7), n = n(), sd = 0.25))) |>
  ungroup() |>
  mutate(f0 = round(base * 2^(st / 12))) |>
  select(speaker, gender, tone, syllable, token_id, duration, time, f0)

mandarin_tones <- mandarin_tones |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(mandarin_tones, overwrite = TRUE)
