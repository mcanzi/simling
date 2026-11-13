library(dplyr)
library(tidyr)
library(tibble)

set.seed(3011)
p_du <- tribble(
  ~age_group, ~setting, ~p,
  "under 30", "university", 0.85,
  "under 30", "shop", 0.35,
  "under 30", "office", 0.45,
  "over 50", "university", 0.40,
  "over 50", "shop", 0.08,
  "over 50", "office", 0.15
)

address_forms <- p_du |>
  uncount(30) |>
  mutate(form = if_else(runif(n()) < p, "du", "Sie")) |>
  slice_sample(prop = 1) |>
  mutate(speaker = sprintf("S%03d", row_number())) |>
  select(speaker, age_group, setting, form)

address_forms <- address_forms |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         age_group = factor(age_group, levels = c("under 30", "over 50")),
         setting = factor(setting, levels = c("university", "office", "shop")),
         form = factor(form, levels = c("Sie", "du")))

usethis::use_data(address_forms, overwrite = TRUE)
