# Accuracy in an Italian lexical decision task

30 native speakers of Italian decide whether each of 60 Italian words is
a word; the outcome is whether the response was correct. For
mixed-effects logistic regression.

## Usage

``` r
lexical_accuracy
```

## Format

A tibble with 1800 rows and 5 columns:

- participant:

  Participant ID, `P01` to `P30`.

- word:

  Word ID, `w01` to `w60`.

- log_freq:

  log10 word frequency, 1 to 6.

- freq_c:

  `log_freq`, centred on the mean of the 60 words.

- correct:

  1 for a correct response, 0 for an error.

## Source

`data-raw/lexical_accuracy.R`

## Details

True model, in log-odds: `1.5 + u0 + w0 + (0.8 + u1) * freq_c`.
By-participant intercepts `u0` have SD 0.8 and slopes `u1` SD 0.3
(uncorrelated); by-word intercepts `w0` have SD 0.5.

## Examples

``` r
head(lexical_accuracy)
#> # A tibble: 6 × 5
#>   participant word  log_freq freq_c correct
#>   <fct>       <fct>    <dbl>  <dbl>   <int>
#> 1 P01         w01       5.96  2.38        1
#> 2 P01         w02       3.48 -0.101       1
#> 3 P01         w03       3.42 -0.161       1
#> 4 P01         w04       1.87 -1.71        0
#> 5 P01         w05       4.77  1.19        1
#> 6 P01         w06       3.27 -0.311       0
```
