# passives: corpus linguistics, counts per text with varying text length
# Passive constructions in 400 texts from four registers. Overdispersed
# counts; text length enters as an exposure (offset).
library(dplyr)
library(tibble)

set.seed(3005)
rate <- c(conversation = 2, fiction = 5, news = 10, academic = 18)   # per 1000 words

passives <- tibble(text = sprintf("T%03d", 1:400),
                   register = rep(names(rate), each = 100)) |>
  mutate(words = round(exp(rnorm(n(), log(2000), 0.5))),
         passives = rnbinom(n(), mu = rate[register] * words / 1000, size = 4))

usethis::use_data(passives, overwrite = TRUE)
