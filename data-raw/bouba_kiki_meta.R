# Ćwiek et al. (2022), Philosophical Transactions of the Royal Society B 377(1841), 20200390.
library(dplyr)
library(tibble)

set.seed(5006)
langs <- c("English", "German", "Italian", "Spanish", "French", "Portuguese", "Polish",
           "Hungarian", "Finnish", "Estonian", "Turkish", "Japanese", "Korean",
           "Mandarin", "Cantonese", "Georgian", "Farsi", "Hindi", "Zulu", "Swahili",
           "Greek", "Russian", "Arabic", "Hebrew", "Thai")
roman <- c("English", "German", "Italian", "Spanish", "French", "Portuguese", "Polish",
           "Hungarian", "Finnish", "Estonian", "Turkish", "Zulu", "Swahili")

conducted <- tibble(study_no = 1:90,
                    year = sample(2001:2025, 90, replace = TRUE),
                    language = sample(langs, 90, replace = TRUE),
                    n = round(exp(runif(90, log(20), log(400))))) |>
  mutate(script = if_else(language %in% roman, "Roman", "other"),
         theta = 0.85 + 0.2 * (script == "Roman") + rnorm(n(), 0, 0.35),
         congruent = rbinom(n(), n, plogis(theta)),
         log_odds = log((congruent + 0.5) / (n - congruent + 0.5)),
         var = 1 / (congruent + 0.5) + 1 / (n - congruent + 0.5),
         p = 2 * pnorm(-abs(log_odds) / sqrt(var)),
         published = runif(n()) < if_else(p < 0.05 & log_odds > 0, 0.95, 0.3))

bouba_kiki_meta <- conducted |>
  filter(published) |>
  slice_head(n = 40) |>
  arrange(year) |>
  mutate(study = sprintf("S%02d", row_number()),
         log_odds = round(log_odds, 3),
         se = round(sqrt(var), 3)) |>
  select(study, year, language, script, n, congruent, log_odds, se)

bouba_kiki_meta <- bouba_kiki_meta |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         script = factor(script, levels = c("other", "Roman")))

bouba_kiki_meta <- bouba_kiki_meta |>
  mutate(across(c(year, n, congruent), as.integer))

usethis::use_data(bouba_kiki_meta, overwrite = TRUE)
