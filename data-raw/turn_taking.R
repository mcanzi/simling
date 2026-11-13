# turn_taking: conversation analysis, response timing in 10 languages
# The gap between the end of a yes/no question and the start of the answer,
# in conversations in 10 languages. Negative values are overlaps. Across
# languages, gaps peak just above zero and are skewed to the right; languages
# differ in their average gap by a few hundred milliseconds. Disconfirmations
# and non-answers come later; answers to a speaker who is looking at the
# responder come sooner. Loosely based on the design and findings of Stivers
# et al. (2009); the language means are invented, not their values.
library(dplyr)
library(tidyr)
library(tibble)

set.seed(4007)
languages <- tibble(language = c("Japanese", "Tzeltal", "Yélî Dnye", "English", "Korean",
                                 "Italian", "Dutch", "Lao", "‡Ākhoe Hai‖om", "Danish"),
                    lang_mean = c(10, 60, 80, 140, 170, 200, 210, 280, 300, 460))

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
                          120 * (response == "disconfirmation") + 250 * (answer == "non-answer") -
                          70 * (gaze == "yes") +
                          rnorm(n(), 0, 200) + rexp(n(), 1 / 150))) |>
  mutate(across(c(language, conversation), factor)) |>
  select(language, conversation, response, answer, gaze, offset)

# mark non-ASCII strings as UTF-8 so they display correctly in every locale
turn_taking <- turn_taking |>
  mutate(across(where(is.character), enc2utf8),
         across(where(is.factor), \(f) { levels(f) <- enc2utf8(levels(f)); f }))

usethis::use_data(turn_taking, overwrite = TRUE)
