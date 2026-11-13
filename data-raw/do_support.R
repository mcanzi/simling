# Ellegård (1953), The auxiliary do; Constant Rate Effect: Kroch (1989), Language Variation and Change 1(3), 199-244.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3009)
baseline <- c("affirmative question" = 1.0, "negative question" = 1.6,
              "negative declarative" = -0.6, "affirmative declarative" = -7.5)

texts <- tibble(text = sprintf("T%03d", 1:300),
                year = round(runif(300, 1400, 1700)),
                t0 = rnorm(300, 0, 0.4))

do_support <- crossing(texts, context = names(baseline)) |>
  mutate(eligible = rpois(n(), if_else(context == "affirmative declarative", 60, 12)),
         p = plogis(baseline[context] + t0 + 0.035 * (year - 1550)),
         do = rbinom(n(), eligible, p)) |>
  filter(eligible > 0) |>
  select(text, year, context, do, eligible)

do_support <- do_support |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         context = factor(context, levels = c("affirmative declarative", "negative declarative", "affirmative question", "negative question")))

usethis::use_data(do_support, overwrite = TRUE)
