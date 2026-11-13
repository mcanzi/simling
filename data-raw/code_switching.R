# Poplack (1980), Linguistics 18(7-8), 581-618.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5007)
speakers <- tibble(speaker = sprintf("S%02d", 1:90),
                   generation = rep(c("first", "second", "third"), each = 30),
                   s0 = rnorm(90, 0, 0.35))

code_switching <- speakers |>
  crossing(topic = c("family", "work", "leisure", "migration")) |>
  mutate(conversation = paste(speaker, topic, sep = "_"),
         interlocutor = sample(c("bilingual", "monolingual"), n(), TRUE, prob = c(0.7, 0.3)),
         utterances = round(exp(rnorm(n(), log(120), 0.35))),
         rate = c(first = 0.04, second = 0.12, third = 0.07)[generation] *
           c(family = 1.3, work = 0.8, leisure = 1, migration = 1.1)[topic] *
           if_else(interlocutor == "bilingual", 1, 0.25) * exp(s0),
         switches = rnbinom(n(), mu = rate * utterances, size = 6),
         intrasentential = rbinom(n(), switches,
                                  c(first = 0.25, second = 0.6, third = 0.4)[generation])) |>
  select(speaker, generation, conversation, topic, interlocutor,
         utterances, switches, intrasentential)

code_switching <- code_switching |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         generation = factor(generation, levels = c("first", "second", "third")),
         topic = factor(topic, levels = c("family", "work", "leisure", "migration")),
         interlocutor = factor(interlocutor, levels = c("monolingual", "bilingual")))

code_switching <- code_switching |>
  mutate(across(c(utterances, switches, intrasentential), as.integer))

usethis::use_data(code_switching, overwrite = TRUE)
