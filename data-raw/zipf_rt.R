# zipf_rt: psycholinguistics, reaction times and Zipfian word frequency
# 2000 words sampled at random from the 50,000 most frequent word types of a
# corpus whose frequencies follow Zipf's law: most words are rare, a few are
# very frequent. Statistics, lecture 5 (Transformations).
library(dplyr)
library(tibble)

set.seed(5)
zipf_rt <- tibble(rank = sort(sample(50000, 2000))) |>
  mutate(word = sprintf("w%04d", row_number()),
         freq = round(50000 / rank, 2),                 # per million words
         rt = round(exp(6.62 - 0.08 * log10(freq) + rnorm(n(), 0, 0.15)))) |>
  select(word, rank, freq, rt)

usethis::use_data(zipf_rt, overwrite = TRUE)
