# scalar_implicature: semantics/pragmatics, truth-value judgments
# "Some of the cards have stars" when all, some or none have stars.
# Under-informative "some" (all context) splits participants into
# pragmatic (false) and logical (true) responders. 60 participants, 24 items.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(3003)
n_part <- 60
n_item <- 24
contexts <- c("all", "some", "none")

participants <- tibble(participant = sprintf("P%02d", 1:n_part),
                       list = rep(1:3, length.out = n_part),
                       pragmatic = rbeta(n_part, 0.5, 0.5),   # own rate of pragmatic readings
                       p_rt = rnorm(n_part, 0, 0.15))
items <- tibble(item = sprintf("i%02d", 1:n_item),
                i_rt = rnorm(n_item, 0, 0.05))

scalar_implicature <- crossing(participants, items) |>
  mutate(context = contexts[(as.integer(substr(item, 2, 3)) + list) %% 3 + 1],
         p_false = case_when(context == "all" ~ pragmatic,
                             context == "some" ~ 0.04,
                             context == "none" ~ 0.96),
         response = if_else(rbinom(n(), 1, p_false) == 1, "false", "true"),
         rt = round(exp(7.25 + p_rt + i_rt +
                          0.22 * (context == "all" & response == "false") +
                          0.08 * (context == "all" & response == "true") +
                          rnorm(n(), 0, 0.25)))) |>
  select(participant, list, item, context, response, rt)

usethis::use_data(scalar_implicature, overwrite = TRUE)
