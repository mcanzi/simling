# Wug test: Berko (1958), Word 14(2-3), 150-177.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4006)
endings <- c("-e", "-(e)n", "-er", "-s", "zero")
probs <- tribble(
  ~gender,     ~final,        ~p,
  "masculine", "schwa",       c(0.05, 0.75, 0.01, 0.07, 0.12),
  "masculine", "-el/-er",     c(0.06, 0.15, 0.01, 0.08, 0.70),
  "masculine", "consonant",   c(0.55, 0.20, 0.08, 0.12, 0.05),
  "masculine", "full vowel",  c(0.03, 0.10, 0.01, 0.80, 0.06),
  "feminine",  "schwa",       c(0.01, 0.95, 0.00, 0.03, 0.01),
  "feminine",  "-el/-er",     c(0.03, 0.80, 0.00, 0.07, 0.10),
  "feminine",  "consonant",   c(0.15, 0.73, 0.01, 0.08, 0.03),
  "feminine",  "full vowel",  c(0.02, 0.15, 0.00, 0.80, 0.03),
  "neuter",    "schwa",       c(0.10, 0.55, 0.05, 0.15, 0.15),
  "neuter",    "-el/-er",     c(0.07, 0.10, 0.02, 0.10, 0.71),
  "neuter",    "consonant",   c(0.50, 0.10, 0.20, 0.15, 0.05),
  "neuter",    "full vowel",  c(0.02, 0.05, 0.03, 0.85, 0.05)
)

nonce_words <- list(
  "schwa"      = c("Pünde", "Kraffe", "Glöbe", "Strunte", "Mafte", "Wöse",
                   "Plinde", "Tröfe", "Schlübe", "Dranke", "Nüfe", "Bralte"),
  "-el/-er"    = c("Pakel", "Strömel", "Gaftel", "Blüner", "Kröder", "Zumpel",
                   "Möfer", "Drüpel", "Schwanter", "Klaber", "Fräbel", "Tüsper"),
  "consonant"  = c("Kraf", "Plönt", "Schlimp", "Dauf", "Wüsk", "Trell",
                   "Gnorf", "Pilch", "Stomp", "Fräk", "Zatt", "Mürf"),
  "full vowel" = c("Pilo", "Mebu", "Kanta", "Fosi", "Dalu", "Rimo",
                   "Blenu", "Pfalo", "Nasu", "Gimpa", "Tefo", "Wanu")
)

items <- probs |>
  uncount(4) |>
  mutate(gender_order = factor(gender, c("masculine", "feminine", "neuter")),
         final_rank = rep(1:12, 4)[order(order(final, gender_order))]) |>
  rowwise() |>
  mutate(nonce = nonce_words[[final]][final_rank]) |>
  ungroup() |>
  mutate(item = sprintf("i%02d", row_number()),
         article = c(masculine = "der", feminine = "die", neuter = "das")[gender]) |>
  select(-final_rank, -gender_order)

participants <- tibble(participant = sprintf("P%02d", 1:60),
                       p_s = rnorm(60, 0, 0.6))

german_plurals <- crossing(participants, items) |>
  rowwise() |>
  mutate(logp = list(log(p + 0.005) + c(0, 0, 0, p_s, 0) + rnorm(5, 0, 0.3)),
         plural = sample(endings, 1, prob = exp(logp))) |>
  ungroup() |>
  mutate(plural = factor(plural, levels = endings),
         across(c(gender, final), factor)) |>
  select(participant, item, nonce, article, gender, final, plural)

german_plurals <- german_plurals |>
  mutate(across(where(is.character), enc2utf8),
         across(where(is.factor), \(f) factor(f, levels = levels(f), labels = enc2utf8(levels(f)))))

german_plurals <- german_plurals |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         article = factor(article, levels = c("der", "die", "das")),
         gender = factor(gender, levels = c("masculine", "feminine", "neuter")),
         final = factor(final, levels = c("schwa", "-el/-er", "consonant", "full vowel")))

usethis::use_data(german_plurals, overwrite = TRUE)
