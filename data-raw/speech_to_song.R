# Rathcke & Smit (2025), Scientific Reports 15, 33315;
# Falk, Rathcke & Dalla Bella (2014), Journal of Experimental Psychology: Human Perception and Performance 40(4), 1491-1506.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5101)
probit_cut <- function(latent, cuts) as.integer(findInterval(latent, cuts) + 1L)

listeners <- tibble(listener = sprintf("L%02d", 1:86),
                    z1 = rnorm(86), z2 = rnorm(86)) |>
  mutate(bat = round(z1, 2),
         mpt = round(0.5 * z1 + sqrt(1 - 0.5^2) * z2, 2),
         l_tr = rnorm(n(), 0, 1),
         l_cyc = rnorm(n(), 0, 0.6),
         l_rat = rnorm(n(), 0, 0.7),
         block = rep_len(0:8, n()))

sentences <- tibble(sentence = sprintf("S%d", 1:9), s0 = rnorm(9, 0, 0.5))
manipulations <- c("baseline", "pitch", "duration")

design <- listeners |>
  crossing(slot = 0:5) |>
  mutate(sentence = sprintf("S%d", (block + slot) %% 9 + 1),
         manipulation = manipulations[slot %% 3 + 1]) |>
  left_join(sentences, by = "sentence")

speech_to_song <- design |>
  mutate(pitch = manipulation == "pitch",
         dur = manipulation == "duration",
         rating_before = probit_cut(-0.8 + 0.3 * l_rat + s0 + rnorm(n()),
                                    c(-1.2, -0.5, 0, 0.5, 1, 1.5, 2.1)),
         transformed = rbinom(n(), 1, plogis(-0.9 + 1.04 * pitch + 0.78 * dur + l_tr + s0)),
         cycle = if_else(transformed == 1L,
                         probit_cut(0.61 * bat + l_cyc + rnorm(n()),
                                    c(-1.4, -0.4, 0.4, 1, 1.5, 1.9, 2.3)),
                         NA_integer_),
         rating_after = probit_cut(0.2 + 1.2 * pitch + 0.91 * dur + 0.44 * mpt + 0.8 * transformed +
                                     l_rat + s0 + rnorm(n()),
                                   c(-0.6, 0, 0.5, 1, 1.5, 2, 2.6))) |>
  select(listener, bat, mpt, sentence, manipulation, rating_before, transformed, cycle,
         rating_after)

speech_to_song <- speech_to_song |>
  mutate(listener = factor(listener, levels = sort(unique(listener), method = "radix")),
         sentence = factor(sentence, levels = sprintf("S%d", 1:9)),
         manipulation = factor(manipulation, levels = manipulations),
         across(c(rating_before, transformed, cycle, rating_after), as.integer)) |>
  arrange(listener, sentence)

usethis::use_data(speech_to_song, overwrite = TRUE)
