library(dplyr)
library(tidyr)
library(tibble)

set.seed(2029)
speakers <- tibble(speaker = sprintf("S%02d", 1:20),
                   l1 = rep(c("English", "Italian"), each = 10),
                   s0 = rnorm(20, 0, 60),
                   s_mid = rnorm(20, 0, 5))
tokens <- crossing(speakers, token = 1:10) |>
  mutate(traj = paste(speaker, token, sep = "."),
         duration = round(runif(n(), 120, 300)),
         t0 = rnorm(n(), 0, 40))
price_f2 <- crossing(tokens, time = seq(0, 100, by = 10)) |>
  arrange(traj, time) |>
  mutate(onset = if_else(l1 == "English", 1250, 1320),
         offset = if_else(l1 == "English", 2050, 1900) - 2 * (250 - duration),
         mid = if_else(l1 == "English", 62, 50) + s_mid,
         width = if_else(l1 == "English", 8, 14),
         f2 = onset + (offset - onset) * plogis((time - mid) / width) + s0 + t0) |>
  group_by(traj) |>
  mutate(f2 = round(f2 + as.numeric(arima.sim(list(ar = 0.6), n = n(), sd = 30)))) |>
  ungroup() |>
  mutate(across(c(speaker, l1, traj), factor)) |>
  select(speaker, l1, traj, duration, time, f2)

price_f2 <- price_f2 |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(price_f2, overwrite = TRUE)
