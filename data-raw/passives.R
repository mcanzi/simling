# Biber, Conrad & Leech (2002), Longman Student Grammar of Spoken and Written English.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(3005)
registers <- tibble(register = c("conversation", "fiction", "news", "academic"),
                    rate = c(2, 5, 10, 20))

passives <- registers |>
  uncount(100) |>
  mutate(text = str_c("T", str_pad(row_number(), 3, pad = "0")),
         words = round(exp(rnorm(n(), log(2000), 0.5))),
         passives = rnbinom(n(), mu = rate * words / 1000, size = 4)) |>
  select(text, register, words, passives)

passives <- passives |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         register = factor(register, levels = c("conversation", "fiction", "news", "academic")),
         across(c(words, passives), as.integer))

usethis::use_data(passives, overwrite = TRUE)
