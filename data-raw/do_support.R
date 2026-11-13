# do_support: historical linguistics, a change over time
# The rise of periphrastic "do" (Did he go? He did not go.) in 300 texts
# dated 1400 to 1700, in four sentence types. The change follows the same
# S-curve slope in every context but starts from different baselines (the
# Constant Rate Effect). Counts of "do" out of all eligible clauses per text.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3009)
baseline <- c("affirmative question" = 1.0, "negative question" = 1.6,
              "negative declarative" = -0.6, "affirmative declarative" = -7.5)

texts <- tibble(text = sprintf("T%03d", 1:300),
                year = round(runif(300, 1400, 1700)),
                t0 = rnorm(300, 0, 0.4))

do_support <- crossing(texts, context = names(baseline)) |>
  mutate(eligible = rpois(n(), if_else(context == "affirmative declarative", 60, 12)),
         p = plogis(baseline[context] + t0 + 0.035 * (year - 1550)),
         do = rbinom(n(), eligible, p)) |>
  filter(eligible > 0) |>
  select(text, year, context, do, eligible)

usethis::use_data(do_support, overwrite = TRUE)
