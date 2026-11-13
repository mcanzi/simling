# GToBI: Grice, Baumann & Benzmüller (2005), in Jun (ed.), Prosodic Typology, 55-83.
# Agreement benchmarks: Pitrelli, Beckman & Hirschberg (1994), Proceedings of ICSLP 1994.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5002)
accents <- c("none", "H*", "L+H*", "L*", "L*+H", "H+!H*", "H+L*")
accent_prob <- c(0.55, 0.16, 0.10, 0.08, 0.05, 0.04, 0.02)
boundaries <- c("none", "intermediate", "intonation phrase")

utterances <- tibble(utterance = sprintf("U%02d", 1:40),
                     style = rep(c("read", "spontaneous"), each = 20),
                     n_words = sample(8:14, 40, replace = TRUE))

words <- utterances |>
  uncount(n_words, .id = "position") |>
  group_by(utterance) |>
  mutate(last = position == max(position)) |>
  ungroup() |>
  mutate(word = sprintf("%s_w%02d", utterance, position),
         true_accent = sample(accents, n(), TRUE, prob = accent_prob),
         true_boundary = case_when(last ~ "intonation phrase",
                                   runif(n()) < 0.12 ~ "intermediate",
                                   TRUE ~ "none"),
         difficulty = rnorm(n(), if_else(style == "spontaneous", 0.5, 0), 0.5))

label <- function(truth, levels, p_correct_logit, confusable) {
  correct <- runif(length(truth)) < plogis(p_correct_logit)
  vapply(seq_along(truth), function(i) {
    if (correct[i]) truth[i] else sample(setdiff(confusable[[truth[i]]], truth[i]), 1)
  }, character(1))
}
accent_confusions <- list("none" = c("H*", "L*"), "H*" = c("none", "L+H*", "H+!H*"),
                          "L+H*" = c("H*", "L*+H"), "L*" = c("none", "L*+H"),
                          "L*+H" = c("L*", "L+H*"), "H+!H*" = c("H*", "H+L*"),
                          "H+L*" = c("H+!H*", "L*"))
boundary_confusions <- list("none" = c("intermediate"),
                            "intermediate" = c("none", "intonation phrase"),
                            "intonation phrase" = c("intermediate"))

tobi_agreement <- words |>
  mutate(base = if_else(true_accent == "none", 2.6, 1.6),
         accent_1 = label(true_accent, accents, base - difficulty, accent_confusions),
         accent_2 = label(true_accent, accents, base - 0.2 - difficulty, accent_confusions),
         boundary_1 = label(true_boundary, boundaries, 2.6 - difficulty, boundary_confusions),
         boundary_2 = label(true_boundary, boundaries, 2.4 - difficulty, boundary_confusions)) |>
  select(utterance, style, word, position, accent_1, accent_2, boundary_1, boundary_2)

tobi_agreement <- tobi_agreement |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         style = factor(style, levels = c("read", "spontaneous")),
         accent_1 = factor(accent_1, levels = accents),
         accent_2 = factor(accent_2, levels = accents),
         boundary_1 = factor(boundary_1, levels = boundaries),
         boundary_2 = factor(boundary_2, levels = boundaries))

usethis::use_data(tobi_agreement, overwrite = TRUE)
