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
head(freq_length)
#> # A tibble: 6 × 5
#>   log_freq length  lf_c len_c    rt
#>      <dbl>  <int> <dbl> <dbl> <dbl>
#> 1     1.35      3 -2.12 -4.45   719
#> 2     5.09      5  1.62 -2.45   651
#> 3     5.71      7  2.24 -0.45   645
#> 4     2.35      8 -1.12  0.55   816
#> 5     1.85     11 -1.62  3.55   901
#> 6     1.17      4 -2.30 -3.45   749
```
