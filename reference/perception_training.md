# Perceptual training of a non-native contrast

18 learners identify a non-native consonant contrast in 40 trials before
and after a week of perceptual training. A small paired design in wide
format.

## Usage

``` r
perception_training
```

## Format

A tibble with 18 rows and 3 columns:

- learner:

  Learner ID, `L01` to `L18`.

- pre:

  Correct responses out of 40 before training.

- post:

  Correct responses out of 40 after training.

## Source

`data-raw/perception_training.R`

## Details

True model: binomial out of 40, with log-odds `0.4 + ability` before and
`0.4 + ability + gain` after training. `ability` has SD 0.6; `gain` has
mean 0.6 and SD 0.35.

## Examples

``` r
perception_training
#> # A tibble: 18 × 3
#>    learner   pre  post
#>    <fct>   <int> <int>
#>  1 L01        26    33
#>  2 L02        23    27
#>  3 L03        28    26
#>  4 L04        24    28
#>  5 L05        33    37
#>  6 L06        25    30
#>  7 L07        27    29
#>  8 L08        23    20
#>  9 L09        28    30
#> 10 L10        22    30
#> 11 L11        25    25
#> 12 L12        24    29
#> 13 L13        27    30
#> 14 L14        25    29
#> 15 L15        23    24
#> 16 L16        27    35
#> 17 L17        35    38
#> 18 L18        31    34
```
