# Stivers et al. (2009), PNAS 106(26), 10587-10592;
# Levinson & Torreira (2015), Frontiers in Psychology 6, 731.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4007)
languages <- tibble(language = c("Japanese", "Tzeltal", "Y\u00e9l\u00ee Dnye", "Dutch", "Korean",
                                 "English", "Italian", "Lao", "\u01c2\u0100khoe Hai\u01c1om", "Danish"),
                    reported = c(7, 67, 71, 108, 182, 236, 310, 419, 423, 469)) |>
  mutate(lang_mean = reported - (0.3 * 207 + 0.1 * 132 - 0.5 * 69))

conversations <- languages |>
  crossing(conv = 1:12) |>
  mutate(conversation = paste(substr(language, 1, 3), sprintf("%02d", conv), sep = "_"),
         c0 = rnorm(n(), 0, 60))

turn_taking <- conversations |>
  uncount(25) |>
  mutate(response = sample(c("confirmation", "disconfirmation"), n(), TRUE, prob = c(0.7, 0.3)),
         answer = if_else(runif(n()) < 0.1, "non-answer", "answer"),
         gaze = sample(c("yes", "no"), n(), TRUE),
         offset = round(lang_mean + c0 - 150 +
                          207 * (response == "disconfirmation") + 132 * (answer == "non-answer") -
                          69 * (gaze == "yes") +
                          rnorm(n(), 0, 200) + rexp(n(), 1 / 150))) |>
  mutate(across(c(language, conversation), factor)) |>
  select(language, conversation, response, answer, gaze, offset)

turn_taking <- turn_taking |>
  mutate(across(where(is.character), enc2utf8),
         across(where(is.factor), \(f) factor(f, levels = levels(f), labels = enc2utf8(levels(f)))))

turn_taking <- turn_taking |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         response = factor(response, levels = c("confirmation", "disconfirmation")),
         answer = factor(answer, levels = c("answer", "non-answer")),
         gaze = factor(gaze, levels = c("no", "yes")))

usethis::use_data(turn_taking, overwrite = TRUE)
