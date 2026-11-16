# Trettenbrein et al. (2021), Behavior Research Methods 53(5), 1817-1832;
# Sehyr & Emmorey (2019), Language and Cognition 11(2), 208-234;
# Fuks (2023), Sign Language Studies 24(1), 46-92;
# Thompson, Vinson, Woll & Vigliocco (2012), Psychological Science 23(12), 1443-1448.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(5008)
signs <- tibble(sign = sprintf("sign%03d", 1:300),
                category = sample(c("noun", "verb"), 300, TRUE, prob = c(0.6, 0.4)),
                handedness = sample(c("one-handed", "two-handed"), 300, TRUE),
                iconicity = rnorm(300, 0, 1.2)) |>
  mutate(aoa = round(pmin(pmax(5.5 - 0.6 * iconicity + rnorm(n(), 0, 1.3), 1.5), 12), 1))

group_dev <- crossing(sign = signs$sign, group = c("deaf signer", "hearing non-signer")) |>
  mutate(g0 = rnorm(n(), 0, 0.6))

raters <- tibble(rater = sprintf("R%02d", 1:60),
                 group = rep(c("deaf signer", "hearing non-signer"), each = 30),
                 r0 = rnorm(60, 0, 0.5))

dgs_iconicity <- crossing(raters, signs) |>
  left_join(group_dev, by = c("sign", "group")) |>
  mutate(signer = group == "deaf signer",
         latent = 3.3 + r0 + iconicity + g0 + signer +
           if_else(!signer & category == "verb", 0.5, 0) + rnorm(n(), 0, 0.9),
         rating = as.integer(pmin(pmax(round(latent), 1), 7))) |>
  select(rater, group, sign, category, handedness, aoa, rating)

dgs_iconicity <- dgs_iconicity |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         group = factor(group, levels = c("hearing non-signer", "deaf signer")),
         category = factor(category, levels = c("noun", "verb")))

usethis::use_data(dgs_iconicity, overwrite = TRUE)
