# Filled pauses are rare in Italian task-oriented dialogue: Di Napoli (2020), Laughter and Other
#   Non-Verbal Vocalisations Workshop.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5009)
speakers <- tibble(speaker = sprintf("S%02d", 1:40),
                   dialogue = rep(sprintf("D%02d", 1:20), each = 2),
                   role = rep(c("giver", "follower"), 20),
                   s0 = rnorm(40, 0, 0.5))

disfluencies <- speakers |>
  crossing(turn = 1:60) |>
  mutate(syllables = pmax(1L, as.integer(round(exp(rnorm(n(), log(9), 0.9))))),
         fluent = runif(n()) < 0.55,
         rate = if_else(role == "giver", 1.2, 0.6) * exp(s0),
         filled_pauses = if_else(fluent, 0L, rpois(n(), rate * syllables / 100))) |>
  select(dialogue, speaker, role, turn, syllables, filled_pauses)

disfluencies <- disfluencies |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         role = factor(role, levels = c("follower", "giver")),
         across(c(syllables, filled_pauses), as.integer))

usethis::use_data(disfluencies, overwrite = TRUE)
