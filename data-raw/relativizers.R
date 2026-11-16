library(dplyr)
library(tidyr)
library(tibble)

set.seed(3006)
texts <- tibble(text = sprintf("T%03d", 1:240),
                mode = rep(c("spoken", "written"), each = 120),
                t_which = rnorm(240, 0, 0.5),
                t_zero = rnorm(240, 0, 0.5))

relativizers <- crossing(texts, token = 1:10) |>
  mutate(role = if_else(runif(n()) < 0.55, "subject", "object"),
         antecedent_length = 1 + rpois(n(), 1.5),
         written = mode == "written",
         eta_which = -1.6 + t_which + 1.4 * written + 0.25 * (antecedent_length - 2),
         eta_zero = if_else(role == "object",
                            0.6 + t_zero - 1.2 * written - 0.4 * (antecedent_length - 2),
                            -Inf),
         p_that = 1 / (1 + exp(eta_which) + exp(eta_zero)),
         p_which = exp(eta_which) * p_that,
         u = runif(n()),
         relativizer = case_when(u < p_that ~ "that",
                                 u < p_that + p_which ~ "which",
                                 TRUE ~ "zero")) |>
  select(text, mode, token, role, antecedent_length, relativizer)

relativizers <- relativizers |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         mode = factor(mode, levels = c("spoken", "written")),
         role = factor(role, levels = c("subject", "object")),
         relativizer = factor(relativizer, levels = c("that", "which", "zero")),
         across(c(antecedent_length), as.integer))

usethis::use_data(relativizers, overwrite = TRUE)
