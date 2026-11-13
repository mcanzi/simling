library(dplyr)
library(tibble)

set.seed(7)
vowel_voicing <- tibble(
  voicing = factor(rep(c("voiceless", "voiced"), each = 60), levels = c("voiceless", "voiced")),
  duration = round(c(rnorm(60, 120, 20), rnorm(60, 160, 22)))
)

vowel_voicing <- vowel_voicing |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(vowel_voicing, overwrite = TRUE)
