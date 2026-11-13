library(dplyr)
library(tibble)

set.seed(9)
speech_styles <- tibble(
  style = rep(c("casual", "clear", "loud"), each = 50),
  duration = round(c(rnorm(50, 110, 18), rnorm(50, 150, 20), rnorm(50, 132, 19)))
)

speech_styles <- speech_styles |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         style = factor(style, levels = c("casual", "clear", "loud")))

usethis::use_data(speech_styles, overwrite = TRUE)
