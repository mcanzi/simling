# perception_training: second language acquisition, a tiny paired design
# 18 learners identify a non-native consonant contrast (40 trials) before and
# after a week of perceptual training. Wide format: one row per learner.
library(dplyr)
library(tibble)

set.seed(3012)
perception_training <- tibble(learner = sprintf("L%02d", 1:18),
                              ability = rnorm(18, 0, 0.6),
                              gain = rnorm(18, 0.6, 0.35)) |>
  mutate(pre = rbinom(n(), 40, plogis(0.4 + ability)),
         post = rbinom(n(), 40, plogis(0.4 + ability + gain))) |>
  select(learner, pre, post)

usethis::use_data(perception_training, overwrite = TRUE)
