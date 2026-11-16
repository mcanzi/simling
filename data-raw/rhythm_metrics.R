# Arvaniti (2012), Journal of Phonetics 40(3), 351-373;
# Dellwo (2006), Language and Language-Processing, 231-241;
# Rathcke & Smith (2015), Journal of the Acoustical Society of America 137(5), 2834-2845;
# Ramus, Nespor & Mehler (1999), Cognition 73(3), 265-292;
# White & Mattys (2007), Journal of Phonetics 35(4), 501-522.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5004)
languages <- tribble(
  ~language, ~code, ~l_v, ~l_c, ~l_varco,
  "English", "eng", 43, 51, 55,
  "German", "deu", 41.5, 51, 52,
  "Greek", "ell", 44.5, 46, 56,
  "Italian", "ita", 46, 46.5, 55,
  "Korean", "kor", 46, 49, 57.5,
  "Spanish", "spa", 46, 48.5, 54
)

materials <- tribble(
  ~material, ~m_v, ~m_c, ~m_varco, ~m_rate,
  "uncontrolled sentences", 0, 0, 0, 0,
  "complex-syllable sentences", -3, 7, 3, -0.3,
  "simple-syllable sentences", 3, -6, -4, 0.3,
  "story", -1, 2, 2, 0.2,
  "spontaneous", -1.5, 6, 7, -0.6
)

cells <- crossing(languages, materials) |>
  mutate(lm_v = rnorm(n(), 0, 1),
         lm_c = rnorm(n(), 0, 3),
         lm_varco = rnorm(n(), 0, 3))

speakers <- languages |>
  select(language, code) |>
  crossing(speaker_no = 1:8) |>
  mutate(speaker = paste(code, sprintf("%02d", speaker_no), sep = "_"),
         s_v = rnorm(n(), 0, 2),
         s_c = rnorm(n(), 0, 4),
         s_varco = rnorm(n(), 0, 4),
         s_rate = rnorm(n(), 0, 0.5))

rhythm_metrics <- speakers |>
  left_join(cells, by = c("language", "code"), relationship = "many-to-many") |>
  crossing(item = 1:5) |>
  mutate(rate = round(5.6 + m_rate + s_rate + rnorm(n(), 0, 0.35), 2),
         percent_v = round(l_v + m_v + lm_v + s_v + rnorm(n(), 0, 2), 1),
         delta_c = round(l_c + m_c + lm_c + s_c - 6 * (rate - 5.6) + rnorm(n(), 0, 5), 1),
         varco_v = round(l_varco + m_varco + lm_varco + s_varco + rnorm(n(), 0, 6), 1)) |>
  select(language, speaker, material, item, rate, percent_v, delta_c, varco_v)

rhythm_metrics <- rhythm_metrics |>
  mutate(language = factor(language, levels = languages$language),
         speaker = factor(speaker, levels = sort(unique(speaker), method = "radix")),
         material = factor(material, levels = materials$material),
         item = as.integer(item))

usethis::use_data(rhythm_metrics, overwrite = TRUE)
