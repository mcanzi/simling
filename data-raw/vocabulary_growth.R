# vocabulary_growth: language acquisition, longitudinal counts
# Productive vocabulary on a 680-word checklist, every two months from 12 to
# 30 months, for 80 children. Children with more input learn earlier.
# About 10% of sessions are missing.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3007)
children <- tibble(child = sprintf("C%02d", 1:80),
                   input = round(exp(rnorm(80, log(1200), 0.4))),   # adult words per hour
                   c_mid = rnorm(80, 0, 1.8))

vocabulary_growth <- crossing(children, age = seq(12, 30, by = 2)) |>
  mutate(mid = 23 - 2 * log2(input / 1200) + c_mid,
         p = plogis((age - mid) / 2.8 + rnorm(n(), 0, 0.15)),
         vocabulary = rbinom(n(), 680, p)) |>
  filter(runif(n()) > 0.1) |>
  select(child, input, age, vocabulary)

usethis::use_data(vocabulary_growth, overwrite = TRUE)
