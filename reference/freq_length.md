# Reaction times with a frequency-by-length interaction

400 words whose frequency and length interact in a
continuous-by-continuous interaction. The length effect is smaller for
frequent words.

## Usage

``` r
freq_length
```

## Format

A tibble with 400 rows and 5 columns:

- log_freq:

  log10 word frequency, 1 to 6.

- length:

  Length in letters, 3 to 12.

- lf_c:

  `log_freq`, centred.

- len_c:

  `length`, centred.

- rt:

  Reaction time in ms.

## Source

`data-raw/freq_length.R`

## Details

True model:
`log(rt) = 6.63 - 0.04 * lf_c + 0.018 * len_c - 0.0065 * lf_c * len_c + e`,
with `e` normal, SD 0.05.

## Examples

``` r
m <- lm(log(rt) ~ lf_c * len_c, data = freq_length)
coef(m)
#>  (Intercept)         lf_c        len_c   lf_c:len_c 
#>  6.626117467 -0.037866256  0.017640267 -0.006635436 
```
