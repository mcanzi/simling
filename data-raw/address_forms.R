# address_forms: pragmatics/sociolinguistics, a small contingency table
# Whether German speakers address a stranger with informal "du" or formal
# "Sie", by the speaker's age group and the setting. 180 observations.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3011)
p_du <- tribble(
  ~age_group, ~setting,     ~p,
  "under 30", "university", 0.85,
  "under 30", "shop",       0.35,
  "under 30", "office",     0.45,
  "over 50",  "university", 0.40,
  "over 50",  "shop",       0.08,
  "over 50",  "office",     0.15
)

address_forms <- p_du |>
  uncount(30) |>
  mutate(form = if_else(runif(n()) < p, "du", "Sie")) |>
  slice_sample(prop = 1) |>
  mutate(speaker = sprintf("S%03d", row_number())) |>
  select(speaker, age_group, setting, form)

usethis::use_data(address_forms, overwrite = TRUE)
