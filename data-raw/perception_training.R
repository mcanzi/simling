library(dplyr)
library(tibble)

set.seed(3012)
perception_training <- tibble(learner = sprintf("L%02d", 1:18),
                              ability = rnorm(18, 0, 0.6),
                              gain = rnorm(18, 0.6, 0.35)) |>
  mutate(pre = rbinom(n(), 40, plogis(0.4 + ability)),
         post = rbinom(n(), 40, plogis(0.4 + ability + gain))) |>
  select(learner, pre, post)

perception_training <- perception_training |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(perception_training, overwrite = TRUE)
