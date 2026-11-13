# Frequency effects in L1 and L2 speakers

Reaction times of L1 and L2 speakers to words of varying frequency. The
frequency effect is stronger for L2 speakers, so frequency and group
interact (a continuous-by-categorical interaction).

## Usage

``` r
l2_frequency
```

## Format

A tibble with 400 rows and 3 columns:

- group:

  `"L1"` or `"L2"`, 200 responses each.

- log_freq:

  log10 word frequency, 1 to 6.

- rt:

  Reaction time in ms.

## Source

`data-raw/l2_frequency.R`

## Details

True model: `log(rt) = 6.56 - 0.04 * log_freq` for L1 and
`6.85 - 0.07 * log_freq` for L2 speakers, plus normal noise with SD
0.06.

## Examples

``` r
head(l2_frequency)
#> # A tibble: 6 × 3
#>   group log_freq    rt
#>   <fct>    <dbl> <dbl>
#> 1 L1        3.54   659
#> 2 L1        2.53   651
#> 3 L1        3.13   677
#> 4 L1        4.47   622
#> 5 L1        1.43   625
#> 6 L1        2.13   668
```
