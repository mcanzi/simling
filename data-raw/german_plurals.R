# Wug test: Berko (1958), Word 14(2-3), 150-177.
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(tibble)

set.seed(4006)
endings <- c("-e", "-(e)n", "-er", "-s", "zero")
probs <- tribble(
  ~gender, ~final, ~p,
  "masculine", "schwa", c(0.05, 0.75, 0.01, 0.07, 0.12),
  "masculine", "-el/-er", c(0.06, 0.15, 0.01, 0.08, 0.70),
  "masculine", "consonant", c(0.55, 0.20, 0.08, 0.12, 0.05),
  "masculine", "full vowel", c(0.03, 0.10, 0.01, 0.80, 0.06),
  "feminine", "schwa", c(0.01, 0.95, 0.00, 0.03, 0.01),
  "feminine", "-el/-er", c(0.03, 0.80, 0.00, 0.07, 0.10),
  "feminine", "consonant", c(0.15, 0.73, 0.01, 0.08, 0.03),
  "feminine", "full vowel", c(0.02, 0.15, 0.00, 0.80, 0.03),
  "neuter", "schwa", c(0.10, 0.55, 0.05, 0.15, 0.15),
  "neuter", "-el/-er", c(0.07, 0.10, 0.02, 0.10, 0.71),
  "neuter", "consonant", c(0.50, 0.10, 0.20, 0.15, 0.05),
  "neuter", "full vowel", c(0.02, 0.05, 0.03, 0.85, 0.05)
)

nonce_words <- list(
  "schwa" = c("Pünde", "Kraffe", "Glöbe", "Strunte", "Mafte", "Wöse",
              "Plinde", "Tröfe", "Schlübe", "Dranke", "Nüfe", "Bralte"),
  "-el/-er" = c("Pakel", "Strömel", "Gaftel", "Blüner", "Kröder", "Zumpel",
                "Möfer", "Drüpel", "Schwanter", "Klaber", "Fräbel", "Tüsper"),
  "consonant" = c("Kraf", "Plönt", "Schlimp", "Dauf", "Wüsk", "Trell",
                  "Gnorf", "Pilch", "Stomp", "Fräk", "Zatt", "Mürf"),
  "full vowel" = c("Pilo", "Mebu", "Kanta", "Fosi", "Dalu", "Rimo",
                   "Blenu", "Pfalo", "Nasu", "Gimpa", "Tefo", "Wanu")
) |>
  enframe("final", "nonce") |>
  unnest_longer(nonce, indices_to = "final_rank")

items <- probs |>
  uncount(4) |>
  mutate(gender_order = factor(gender, c("masculine", "feminine", "neuter"))) |>
  mutate(final_rank = row_number(gender_order), .by = final) |>
  left_join(nonce_words, by = c("final", "final_rank")) |>
  mutate(item = str_c("i", str_pad(row_number(), 2, pad = "0")),
         article = case_when(gender == "masculine" ~ "der",
                             gender == "feminine" ~ "die",
                             gender == "neuter" ~ "das")) |>
  select(-final_rank, -gender_order)

participants <- tibble(participant = str_c("P", str_pad(1:60, 2, pad = "0")),
                       p_s = rnorm(60, 0, 0.6))

german_plurals <- crossing(participants, items) |>
  mutate(logp = map2(p, p_s, \(p, s) log(p + 0.005) + c(0, 0, 0, s, 0) + rnorm(5, 0, 0.3)),
         plural = map_chr(logp, \(l) sample(endings, 1, prob = exp(l)))) |>
  select(participant, item, nonce, article, gender, final, plural)

german_plurals <- german_plurals |>
  mutate(across(where(is.character), enc2utf8),
         across(where(is.factor), \(f) factor(f, levels = levels(f), labels = enc2utf8(levels(f)))))

german_plurals <- german_plurals |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         article = factor(article, levels = c("der", "die", "das")),
         gender = factor(gender, levels = c("masculine", "feminine", "neuter")),
         final = factor(final, levels = c("schwa", "-el/-er", "consonant", "full vowel")),
         plural = factor(plural, levels = endings))

usethis::use_data(german_plurals, overwrite = TRUE)
