library(dplyr)
library(purrr)
library(stringr)
library(tibble)

set.seed(4008)
n <- 320
items <- tribble(
  ~item, ~factor, ~loading,
  "intelligent", "status", 0.75,
  "educated", "status", 0.80,
  "competent", "status", 0.70,
  "lazy", "status", -0.55,
  "friendly", "solidarity", 0.80,
  "warm", "solidarity", 0.75,
  "trustworthy", "solidarity", 0.65,
  "cold", "solidarity", -0.60,
  "used_by_young", "vitality", 0.60,
  "will_survive", "vitality", 0.70,
  "teach_school", "vitality", 0.65,
  "identity", "vitality", 0.70
)

r <- matrix(c(1, 0.2, 0.3,
              0.2, 1, 0.5,
              0.3, 0.5, 1), 3, 3)
z <- (matrix(rnorm(n * 3), n, 3) %*% chol(r)) |>
  as_tibble(.name_repair = \(x) c("status", "solidarity", "vitality"))

respondents <- tibble(respondent = str_c("R", str_pad(1:n, 3, pad = "0")),
                      age = round(runif(n, 18, 75)),
                      dialect_speaker = sample(c("yes", "no"), n, TRUE, prob = c(0.4, 0.6))) |>
  bind_cols(z) |>
  mutate(solidarity = solidarity + 0.6 * (dialect_speaker == "yes"),
         vitality = vitality + 0.5 * (dialect_speaker == "yes") - 0.01 * (age - 45))

answers <- items |>
  pmap(\(item, factor, loading) {
    latent <- loading * pull(respondents, all_of(factor)) + rnorm(n, 0, sqrt(1 - loading^2))
    answer <- as.integer(cut(latent, c(-Inf, -1.3, -0.4, 0.4, 1.3, Inf)))
    if_else(runif(n) < 0.02, NA, answer)
  }) |>
  set_names(items$item) |>
  as_tibble()

language_attitudes <- respondents |>
  select(respondent, age, dialect_speaker) |>
  bind_cols(answers)

language_attitudes <- language_attitudes |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         dialect_speaker = factor(dialect_speaker, levels = c("no", "yes")),
         across(c(age), as.integer))

usethis::use_data(language_attitudes, overwrite = TRUE)
