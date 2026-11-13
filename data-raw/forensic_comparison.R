# Cllr: Brümmer & du Preez (2006), Computer Speech and Language 20(2-3), 230-275.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5001)
n_speakers <- 80
speakers <- tibble(speaker = sprintf("S%02d", 1:n_speakers),
                   s_auto = rnorm(n_speakers, 0, 0.4),
                   s_formant = rnorm(n_speakers, 0, 0.3))

pairs <- expand_grid(speaker_a = speakers$speaker, speaker_b = speakers$speaker) |>
  filter(speaker_a <= speaker_b) |>
  mutate(same_speaker = if_else(speaker_a == speaker_b, "yes", "no"))

forensic_comparison <- pairs |>
  left_join(select(speakers, speaker_a = speaker, a_auto = s_auto, a_formant = s_formant), by = "speaker_a") |>
  left_join(select(speakers, speaker_b = speaker, b_auto = s_auto, b_formant = s_formant), by = "speaker_b") |>
  mutate(comparison = sprintf("C%04d", row_number()),
         score_auto = round(if_else(same_speaker == "yes",
                                    rnorm(n(), 2.5, 1) + a_auto,
                                    rnorm(n(), -1, 1.3) + (a_auto + b_auto) / 2), 3),
         score_formant = round(if_else(same_speaker == "yes",
                                       rnorm(n(), 1, 1) + a_formant,
                                       rnorm(n(), -0.5, 1.1) + (a_formant + b_formant) / 2), 3)) |>
  select(comparison, speaker_a, speaker_b, same_speaker, score_auto, score_formant)

forensic_comparison <- forensic_comparison |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         same_speaker = factor(same_speaker, levels = c("no", "yes")))

usethis::use_data(forensic_comparison, overwrite = TRUE)
