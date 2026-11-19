library(dplyr)
library(tidyr)
library(stringr)
library(tibble)

set.seed(5010)
participants <- tibble(n = 1:24,
                       p0 = rnorm(24, 0, 0.12),
                       lab = rep(c("A", "B"), each = 12),
                       age = sample(19:34, 24, TRUE))
items <- tibble(item = 1:40,
                frequency = rep(c("high", "low"), each = 20),
                w0 = rnorm(40, 0, 0.05))

clean <- crossing(participants, items) |>
  mutate(block = "test",
         rt = round(exp(6.38 + p0 + w0 + 0.1 * (frequency == "low") + rnorm(n(), 0, 0.15)), 1),
         correct = rbinom(n(), 1, if_else(frequency == "low", 0.88, 0.96)))
practice <- crossing(participants, item = 1:4) |>
  mutate(frequency = sample(c("high", "low"), n(), TRUE), block = "practice",
         rt = round(exp(6.6 + rnorm(n(), 0, 0.2)), 1), correct = rbinom(n(), 1, 0.8))

raw <- bind_rows(practice, clean) |>
  arrange(n, block != "practice", item) |>
  mutate(id_style = (n %% 4) + 1,
         `Subject ID` = case_when(id_style == 1 ~ str_c("P", str_pad(n, 2, pad = "0")),
                                  id_style == 2 ~ str_c("p", n),
                                  id_style == 3 ~ str_c("P ", str_pad(n, 2, pad = "0")),
                                  TRUE ~ str_pad(n, 2, pad = "0")),
         `Cond.` = case_when(lab == "A" & frequency == "high" ~
                               sample(c("high", "High"), n(), TRUE),
                             lab == "A" ~ sample(c("low", "Low"), n(), TRUE),
                             frequency == "high" ~ sample(c("HIGH ", "hi"), n(), TRUE),
                             TRUE ~ sample(c("LOW", "lo "), n(), TRUE)),
         `Response Time (ms)` = case_when(runif(n()) < 0.02 ~ "-999",
                                          runif(n()) < 0.01 ~ "",
                                          lab == "B" ~
                                            str_replace(as.character(rt), fixed("."), ","),
                                          TRUE ~ as.character(rt)),
         ACC = if_else(lab == "A", as.character(correct),
                       if_else(correct == 1, "correct", "incorrect")),
         Age = if_else(n %% 3 == 0, str_c(age, " years"), as.character(age)),
         time = as.POSIXct("2026-05-04 09:00:00", tz = "UTC") + n * 3600 + item * 3,
         Timestamp = if_else(lab == "A", format(time, "%Y-%m-%d %H:%M:%S"),
                             format(time, "%d.%m.%Y %H:%M")),
         Block = block,
         Item = item,
         Lab = lab,
         Notes = NA_character_)

dupes <- raw |> filter(block == "test") |> slice_sample(n = 30)
messy_export <- bind_rows(raw, dupes) |>
  arrange(n, Block != "practice", Item) |>
  select(`Subject ID`, Lab, Age, Block, Item, `Cond.`, `Response Time (ms)`, ACC, Timestamp, Notes)

usethis::use_data(messy_export, overwrite = TRUE)
