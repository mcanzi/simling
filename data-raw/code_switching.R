# Poplack (1980), Linguistics 18(7-8), 581-618.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(5007)
generations <- tibble(generation = c("first", "second", "third"),
                      gen_rate = c(0.04, 0.12, 0.07),
                      p_intra = c(0.25, 0.6, 0.4))
topics <- tibble(topic = c("family", "work", "leisure", "migration"),
                 topic_rate = c(1.3, 0.8, 1, 1.1))
speakers <- tibble(speaker = str_c("S", str_pad(1:90, 2, pad = "0")),
                   generation = rep(c("first", "second", "third"), each = 30),
                   s0 = rnorm(90, 0, 0.35))

code_switching <- speakers |>
  crossing(topic = c("family", "work", "leisure", "migration")) |>
  left_join(generations, by = "generation") |>
  left_join(topics, by = "topic") |>
  mutate(conversation = str_c(speaker, topic, sep = "_"),
         interlocutor = sample(c("bilingual", "monolingual"), n(), TRUE, prob = c(0.7, 0.3)),
         utterances = round(exp(rnorm(n(), log(120), 0.35))),
         rate = gen_rate * topic_rate * if_else(interlocutor == "bilingual", 1, 0.25) * exp(s0),
         switches = rnbinom(n(), mu = rate * utterances, size = 6),
         intrasentential = rbinom(n(), switches, p_intra)) |>
  select(speaker, generation, conversation, topic, interlocutor,
         utterances, switches, intrasentential)

code_switching <- code_switching |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         generation = factor(generation, levels = c("first", "second", "third")),
         topic = factor(topic, levels = c("family", "work", "leisure", "migration")),
         interlocutor = factor(interlocutor, levels = c("monolingual", "bilingual")),
         across(c(utterances, switches, intrasentential), as.integer))

usethis::use_data(code_switching, overwrite = TRUE)
