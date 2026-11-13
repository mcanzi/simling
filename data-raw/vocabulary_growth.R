# MacArthur-Bates CDI Words & Sentences (Fenson et al. 2007);
# about 300 words at 24 months: Frank et al. (2017), Journal of Child Language 44(3), 677-694.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3007)
children <- tibble(child = sprintf("C%02d", 1:80),
                   input = round(exp(rnorm(80, log(1200), 0.4))),
                   c_mid = rnorm(80, 0, 2.6))

vocabulary_growth <- crossing(children, age = seq(16, 30, by = 2)) |>
  mutate(mid = 25.2 - 2 * log2(input / 1200) + c_mid,
         p = plogis((age - mid) / 2.8 + rnorm(n(), 0, 0.15)),
         vocabulary = rbinom(n(), 680, p)) |>
  filter(runif(n()) > 0.1) |>
  select(child, input, age, vocabulary)

vocabulary_growth <- vocabulary_growth |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

vocabulary_growth <- vocabulary_growth |>
  mutate(across(c(input, age, vocabulary), as.integer))

usethis::use_data(vocabulary_growth, overwrite = TRUE)
