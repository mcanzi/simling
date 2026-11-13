# speech_styles: Statistics, lecture 7 (Categorical predictors)
library(tibble)

set.seed(9)
speech_styles <- tibble(
  style    = rep(c("casual", "clear", "loud"), each = 50),
  duration = round(c(rnorm(50, 110, 18), rnorm(50, 150, 20), rnorm(50, 132, 19)))
)

usethis::use_data(speech_styles, overwrite = TRUE)
