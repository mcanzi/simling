library(dplyr)
library(tibble)

set.seed(5)
zipf_rt <- tibble(rank = sort(sample(50000, 2000))) |>
  mutate(word = sprintf("w%04d", row_number()),
         freq = round(50000 / rank, 2),
         rt = round(exp(6.62 - 0.08 * log10(freq) + rnorm(n(), 0, 0.15)))) |>
  select(word, rank, freq, rt)

zipf_rt <- zipf_rt |>
  mutate(across(where(is.character), \(x) factor(x, levels = sort(unique(x), method = "radix"))))

usethis::use_data(zipf_rt, overwrite = TRUE)
