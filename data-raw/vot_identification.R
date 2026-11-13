# Lisker & Abramson (1970), Proceedings of the 6th International Congress of Phonetic Sciences, 563-567;
# Abramson & Lisker (1973), Journal of Phonetics 1(1), 1-8.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5102)
boundaries <- tribble(~language, ~place, ~boundary,
  "English", "labial", 25, "English", "apical", 35, "English", "velar", 42,
  "Spanish", "labial", 14, "Spanish", "apical", 22, "Spanish", "velar", 24)

listeners <- tibble(language = rep(c("English", "Spanish"), each = 12)) |>
  mutate(listener = paste0(substr(language, 1, 2), sprintf("%02d", rep(1:12, 2))),
         b0 = rnorm(n(), 0, 4),
         slope = exp(rnorm(n(), log(0.3), 0.25)))

vot_identification <- listeners |>
  left_join(boundaries, by = "language", relationship = "many-to-many") |>
  crossing(vot = seq(-20, 60, by = 5)) |>
  mutate(trials = 10L,
         voiceless = rbinom(n(), trials, plogis(slope * (vot - boundary - b0)))) |>
  select(listener, language, place, vot, trials, voiceless)

vot_identification <- vot_identification |>
  mutate(listener = factor(listener, levels = sort(unique(listener), method = "radix")),
         language = factor(language, levels = c("English", "Spanish")),
         place = factor(place, levels = c("labial", "apical", "velar")),
         vot = as.integer(vot), voiceless = as.integer(voiceless)) |>
  arrange(listener, place, vot)

usethis::use_data(vot_identification, overwrite = TRUE)
