# Biber (1988), Variation across Speech and Writing;
# Egbert, Biber & Davies (2015), Journal of the Association for Information Science and Technology 66(9), 1817-1831;
# Ehret & Taboada (2021), Frontiers in Artificial Intelligence 4, 643770;
# base rates, spreads and register means chosen to match their data: https://doi.org/10.5281/zenodo.4885180
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(tibble)

set.seed(6012)
registers <- tribble(
  ~register, ~n, ~involved, ~narrative, ~elaborated,
  "forum discussion", 90, 1.3, 0, -1,
  "personal blog", 90, 1.1, 0.5, -0.9,
  "news report", 110, -0.2, 0.5, 0.3,
  "encyclopedia article", 60, -1.1, 0, 0.5,
  "research article", 70, -1, -0.5, 1.8,
  "recipe", 60, 0, -1, -1.6
)

features <- tribble(
  ~feature, ~base_rate, ~spread, ~involved, ~narrative, ~elaborated,
  "contractions", 3.2, 1.3, 0.75, 0, 0,
  "first_person", 9.2, 1.26, 0.75, 0, 0,
  "second_person", 3, 1.36, 0.7, 0, 0,
  "adverbs", 26.5, 0.43, 0.55, 0, 0,
  "negation", 5.2, 0.63, 0.6, 0, 0,
  "private_verbs", 10.5, 0.4, 0.5, 0, 0,
  "present_tense", 44.2, 0.26, 0.7, -0.4, 0,
  "nouns", 217.8, 0.15, -0.8, 0, 0,
  "prepositions", 88.8, 0.21, -0.55, 0, 0,
  "word_length", 4.6, 0.32, -0.45, 0, 0.7,
  "past_tense", 22.5, 0.44, 0, 0.85, 0,
  "third_person", 7.6, 1.16, 0, 0.55, 0,
  "perfect_aspect", 3.3, 0.84, 0, 0.5, 0,
  "nominalisations", 14.8, 0.69, 0, 0, 0.75,
  "attributive_adjectives", 57.8, 0.18, 0, 0, 0.5,
  "conjuncts", 1.4, 0.79, 0, 0, 0.45
)

texts <- registers |>
  uncount(n) |>
  mutate(text = str_c("T", str_pad(row_number(), 3, pad = "0")),
         words = pmin(pmax(round(exp(rnorm(n(), log(900), 0.5))), 400), 4000),
         involved = involved + rnorm(n(), 0, 0.6),
         narrative = narrative + rnorm(n(), 0, 0.9),
         elaborated = elaborated + rnorm(n(), 0, 0.6))

simulate_feature <- function(feature, base_rate, spread, involved, narrative, elaborated) {
  latent <- texts$involved * involved + texts$narrative * narrative +
    texts$elaborated * elaborated +
    rnorm(nrow(texts), 0, sqrt(1 - (involved^2 + narrative^2 + elaborated^2)))
  if (feature == "word_length") {
    round(base_rate + spread * latent, 2)
  } else {
    rate <- base_rate * exp(spread * latent)
    round(rpois(nrow(texts), texts$words * rate / 1000) / texts$words * 1000, 1)
  }
}

web_registers <- texts |>
  select(text, register, words) |>
  bind_cols(features |> pmap(simulate_feature) |> set_names(features$feature) |> as_tibble())

web_registers <- web_registers |>
  mutate(pronouns = first_person + second_person + third_person) |>
  select(text, register, words, adverbs, attributive_adjectives, conjuncts, contractions,
         first_person, negation, nominalisations, nouns, past_tense, perfect_aspect,
         prepositions, present_tense, private_verbs, pronouns, second_person, third_person,
         word_length)

web_registers <- web_registers |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         register = factor(register, levels = registers$register),
         words = as.integer(words))

usethis::use_data(web_registers, overwrite = TRUE)
