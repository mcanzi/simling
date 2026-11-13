# vowel_voicing: Statistics, lectures 7 (Categorical predictors) and 9 (Significance testing)
library(tibble)

set.seed(7)
vowel_voicing <- tibble(
  voicing  = rep(c("voiceless", "voiced"), each = 60),
  duration = round(c(rnorm(60, 120, 20), rnorm(60, 160, 22)))   # ms
)

usethis::use_data(vowel_voicing, overwrite = TRUE)
