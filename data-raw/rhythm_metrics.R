# Ramus, Nespor & Mehler (1999), Cognition 73(3), 265-292; White & Mattys (2007), Journal of Phonetics 35(4), 501-522;
# European vs Brazilian Portuguese: Frota & Vigário (2001), Probus 13(2), 247-275.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5003)
languages <- tribble(
  ~language,              ~percent_v, ~delta_c, ~varco_v,
  "English",              41,         54,       65,
  "German",               42,         52,       62,
  "Dutch",                42,         53,       63,
  "European Portuguese",  43,         50,       58,
  "Brazilian Portuguese", 46,         45,       52,
  "Spanish",              46,         46,       48,
  "Italian",              47,         47,       52,
  "Japanese",             53,         36,       45
)

speakers <- languages |>
  crossing(speaker_no = 1:10) |>
  mutate(speaker = paste(substr(gsub(" ", "", language), 1, 3), sprintf("%02d", speaker_no), sep = "_"),
         s_v = rnorm(n(), 0, 1.2),
         s_c = rnorm(n(), 0, 3),
         s_rate = rnorm(n(), 0, 0.4))

rhythm_metrics <- speakers |>
  crossing(sentence = sprintf("sent%d", 1:5)) |>
  mutate(rate = round(5.5 + s_rate + rnorm(n(), 0, 0.35), 2),
         percent_v = round(percent_v + s_v + rnorm(n(), 0, 1.5), 1),
         delta_c = round(delta_c + s_c - 6 * (rate - 5.5) + rnorm(n(), 0, 4), 1),
         varco_v = round(varco_v + rnorm(n(), 0, 5), 1)) |>
  select(language, speaker, sentence, rate, percent_v, delta_c, varco_v)

rhythm_metrics <- rhythm_metrics |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         language = factor(language, levels = languages$language))

usethis::use_data(rhythm_metrics, overwrite = TRUE)
