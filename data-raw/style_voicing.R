# style_voicing: Statistics, lecture 8 (Interactions)
library(dplyr)
library(tidyr)
library(tibble)
library(forcats)

set.seed(11)
cells <- tribble(
  ~style,   ~voicing,    ~mu,
  "casual", "voiceless", 110,
  "casual", "voiced",    145,
  "clear",  "voiceless", 125,
  "clear",  "voiced",    180
)
style_voicing <- cells |>
  uncount(40) |>                                    # 40 tokens per cell
  mutate(duration = round(rnorm(n(), mu, 18)),
         voicing  = fct_relevel(voicing, "voiceless")) |>
  select(-mu)

usethis::use_data(style_voicing, overwrite = TRUE)
