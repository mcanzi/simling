# Fant (1966), STL-QPSR 7(4), 22-30.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(8)
vowel_means <- tribble(
  ~vowel, ~F1, ~F2,
  "i", 300, 2300,
  "a", 750, 1300,
  "u", 320, 800
)
formants <- crossing(speaker = c("A", "B"), vowel_means, token = 1:20) |>
  mutate(k = if_else(speaker == "A", 1, 1.2),
         f1 = round(F1 * k + rnorm(n(), 0, 40)),
         f2 = round(F2 * k + rnorm(n(), 0, 120))) |>
  select(speaker, vowel, token, f1, f2)

formants <- formants |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         vowel = factor(vowel, levels = c("i", "a", "u")),
         across(c(token), as.integer))

usethis::use_data(formants, overwrite = TRUE)
