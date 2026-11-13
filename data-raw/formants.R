# formants: Statistics, lecture 5 (Transformations)
library(dplyr)
library(tidyr)
library(tibble)

set.seed(8)
vowel_means <- tribble(
  ~vowel, ~F1, ~F2,
  "i",    300, 2300,
  "a",    750, 1300,
  "u",    320,  800
)
formants <- crossing(speaker = c("A", "B"), vowel_means, token = 1:20) |>
  mutate(k  = if_else(speaker == "A", 1, 1.2),   # speaker B: shorter vocal tract
         F1 = F1 * k + rnorm(n(), 0, 40),
         F2 = F2 * k + rnorm(n(), 0, 120))

usethis::use_data(formants, overwrite = TRUE)
