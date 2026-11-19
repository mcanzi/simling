# Ellegård (1953), The auxiliary do;
# Kroch (1989), Language Variation and Change 1(3), 199-244, Tables 4 and 9.
library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(3009)
contexts <- tribble(
  ~context, ~intercept, ~slope,
  "affirmative question", -6.58, 3.7,
  "negative question", -5.57, 3.7,
  "negative declarative", -8.33, 3.7,
  "affirmative declarative", -8.32, 2.82
)

texts <- tibble(text = str_c("T", str_pad(1:300, 3, pad = "0")),
                year = round(runif(300, 1400, 1575)),
                t0 = rnorm(300, 0, 0.4))

do_support <- crossing(texts, contexts) |>
  mutate(eligible = rpois(n(), if_else(context == "affirmative declarative", 60, 12)),
         p = plogis(intercept + slope * (year - 1350) / 100 + t0),
         do = rbinom(n(), eligible, p)) |>
  filter(eligible > 0) |>
  select(text, year, context, do, eligible)

do_support <- do_support |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         context = factor(context, levels = c("affirmative declarative", "negative declarative",
                                              "affirmative question", "negative question")),
         across(c(year, do, eligible), as.integer))

usethis::use_data(do_support, overwrite = TRUE)
