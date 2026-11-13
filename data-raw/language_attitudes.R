library(dplyr)
library(tibble)

set.seed(4008)
n <- 320
items <- tribble(
  ~item,           ~factor,       ~loading,
  "intelligent",   "status",       0.75,
  "educated",      "status",       0.80,
  "competent",     "status",       0.70,
  "lazy",          "status",      -0.55,
  "friendly",      "solidarity",   0.80,
  "warm",          "solidarity",   0.75,
  "trustworthy",   "solidarity",   0.65,
  "cold",          "solidarity",  -0.60,
  "used_by_young", "vitality",     0.60,
  "will_survive",  "vitality",     0.70,
  "teach_school",  "vitality",     0.65,
  "identity",      "vitality",     0.70
)

r <- matrix(c(1, 0.2, 0.3,
              0.2, 1, 0.5,
              0.3, 0.5, 1), 3, 3)
z <- matrix(rnorm(n * 3), n, 3) %*% chol(r)

respondents <- tibble(respondent = sprintf("R%03d", 1:n),
                      age = round(runif(n, 18, 75)),
                      dialect_speaker = sample(c("yes", "no"), n, TRUE, prob = c(0.4, 0.6))) |>
  mutate(status = z[, 1],
         solidarity = z[, 2] + 0.6 * (dialect_speaker == "yes"),
         vitality = z[, 3] + 0.5 * (dialect_speaker == "yes") - 0.01 * (age - 45))

language_attitudes <- respondents
for (i in seq_len(nrow(items))) {
  f <- respondents[[items$factor[i]]]
  latent <- items$loading[i] * f + rnorm(n, 0, sqrt(1 - items$loading[i]^2))
  answer <- as.integer(cut(latent, c(-Inf, -1.3, -0.4, 0.4, 1.3, Inf)))
  answer[runif(n) < 0.02] <- NA
  language_attitudes[[items$item[i]]] <- answer
}
language_attitudes <- language_attitudes |>
  select(respondent, age, dialect_speaker, all_of(items$item))

language_attitudes <- language_attitudes |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))),
         dialect_speaker = factor(dialect_speaker, levels = c("no", "yes")))

usethis::use_data(language_attitudes, overwrite = TRUE)
