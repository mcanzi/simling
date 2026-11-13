library(dplyr)
library(tidyr)
library(tibble)

set.seed(11)
cells <- tribble(
  ~style, ~voicing, ~mu,
  "casual", "voiceless", 110,
  "casual", "voiced", 145,
  "clear", "voiceless", 125,
  "clear", "voiced", 180
)
style_voicing <- cells |>
  uncount(40) |>
  mutate(duration = round(rnorm(n(), mu, 18))) |>
  select(-mu)

style_voicing <- style_voicing |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         style = factor(style, levels = c("casual", "clear")),
         voicing = factor(voicing, levels = c("voiceless", "voiced")))

usethis::use_data(style_voicing, overwrite = TRUE)
