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
head(td_deletion)
#> # A tibble: 6 × 11
#>   speaker deleted  following morph         rate log_freq   age gender education
#>   <fct>   <fct>    <fct>     <fct>        <dbl>    <dbl> <int> <fct>  <fct>    
#> 1 S01     deleted  consonant past          4.14     2.64    55 female school   
#> 2 S01     retained vowel     monomorpheme  4.17     2.55    55 female school   
#> 3 S01     deleted  vowel     monomorpheme  4.4      3.85    55 female school   
#> 4 S01     deleted  vowel     monomorpheme  5.76     5.8     55 female school   
#> 5 S01     deleted  consonant past          5.42     3.86    55 female school   
#> 6 S01     retained pause     monomorpheme  4.19     3.88    55 female school   
#> # ℹ 2 more variables: noise_cont <dbl>, noise_bin <fct>
```
