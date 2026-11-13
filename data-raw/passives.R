library(dplyr)
library(tibble)

set.seed(3005)
rate <- c(conversation = 2, fiction = 5, news = 10, academic = 18)

passives <- tibble(text = sprintf("T%03d", 1:400),
                   register = rep(names(rate), each = 100)) |>
  mutate(words = round(exp(rnorm(n(), log(2000), 0.5))),
         passives = rnbinom(n(), mu = rate[register] * words / 1000, size = 4))

passives <- passives |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         register = factor(register, levels = c("conversation", "fiction", "news", "academic")))

usethis::use_data(passives, overwrite = TRUE)
