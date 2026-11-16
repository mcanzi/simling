# /t, d/ deletion

Whether word-final /t, d/ is deleted (as in *wes' side*), 50 tokens from
each of 40 speakers. Includes an interaction, a non-linear age effect,
correlated predictors and two pure-noise predictors. For classification
trees and random forests.

## Usage

``` r
td_deletion
```

## Format

A tibble with 2000 rows and 11 columns:

- speaker:

  `S01` to `S40`.

- deleted:

  `"retained"` or `"deleted"`.

- following:

  Following segment: `"vowel"`, `"pause"` or `"consonant"`.

- morph:

  `"monomorpheme"` (*mist*) or `"past"` (*missed*).

- rate:

  Speech rate in syllables per second.

- log_freq:

  log10 word frequency, 1 to 6.

- age:

  Speaker age, 18 to 80.

- gender:

  `"female"` or `"male"`; no effect.

- education:

  `"school"` or `"university"`; correlated with age but no effect of its
  own.

- noise_cont, noise_bin:

  Random noise, continuous and binary; no effect.

## Source

`data-raw/td_deletion.R`

## Details

True model, in log-odds of deletion:
`-0.8 + s0 + 1.8 * consonant + 0.4 * pause - 1 * past + 0.9 * (rate - 5) * consonant + 1.2 * plogis((45 - age) / 5) + 0.25 * (log_freq - 3.5)`,
with by-speaker intercepts `s0` of SD 0.5. Rate matters only before
consonants; deletion drops sharply around age 45.

## Examples

``` r
if (requireNamespace("rpart", quietly = TRUE)) {
  tree <- rpart::rpart(deleted ~ following + morph + rate + log_freq + age + gender +
                         education + noise_cont + noise_bin, data = td_deletion)
  round(tree$variable.importance)
}
#>  following        age       rate   log_freq  education      morph noise_cont 
#>         85         39         27         22         19          6          2 
#>  noise_bin 
#>          1 
if (requireNamespace("randomForest", quietly = TRUE)) {
  set.seed(1)
  rf <- randomForest::randomForest(deleted ~ following + morph + rate + log_freq + age +
                                     gender + education + noise_cont + noise_bin,
                                   data = td_deletion, importance = TRUE)
  round(randomForest::importance(rf, type = 1), 1)
}
#>            MeanDecreaseAccuracy
#> following                  62.4
#> morph                      22.6
#> rate                       10.4
#> log_freq                   10.1
#> age                        28.9
#> gender                      5.0
#> education                  12.3
#> noise_cont                  2.2
#> noise_bin                  -0.2
```
