# Lexical decision with participants and words

20 participants each respond to the same 40 words. Participants differ
in speed and in the size of their frequency effect; words differ in
difficulty. For crossed random effects.

## Usage

``` r
lexical_decision
```

## Format

A tibble with 800 rows and 5 columns:

- participant:

  Participant ID, `P01` to `P20`.

- word:

  Word ID, `w01` to `w40`.

- log_freq:

  log10 word frequency, 1 to 6.

- freq_c:

  `log_freq`, centred on the mean of the 40 words.

- rt:

  Reaction time in ms.

## Source

`data-raw/lexical_decision.R`

## Details

True model: `log(rt) = 6.47 + u0 + w0 + (-0.045 + u1) * freq_c + e`.
By-participant intercepts `u0` have SD 0.11 and slopes `u1` SD 0.025,
correlated at -0.6; by-word intercepts `w0` have SD 0.045; residual SD
0.075. `languageR::lexdec` is a different data set, with real data.

## Examples

``` r
head(lexical_decision)
#> # A tibble: 6 × 5
#>   participant word  log_freq  freq_c    rt
#>   <fct>       <fct>    <dbl>   <dbl> <dbl>
#> 1 P01         w01       3.61 -0.169    655
#> 2 P01         w02       5.95  2.17     529
#> 3 P01         w03       1.32 -2.46     722
#> 4 P01         w04       5.31  1.53     590
#> 5 P01         w05       3.4  -0.379    779
#> 6 P01         w06       3.68 -0.0992   761
```
