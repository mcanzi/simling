# F2 trajectories of the PRICE diphthong

F2 over the course of the PRICE vowel (as in *price*), 10 tokens from
each of 20 speakers: 10 L1 English and 10 L1 Italian speakers of
English. Italian speakers start higher, end lower and move earlier and
more gradually. For GAMs and GAMMs.

## Usage

``` r
price_f2
```

## Format

A tibble with 2200 rows and 6 columns:

- speaker:

  `S01` to `S20`.

- l1:

  `"English"` or `"Italian"`.

- traj:

  One level per token (`speaker.token`).

- duration:

  Vowel duration in ms, 120 to 300.

- time:

  Normalised time, 0 to 100 in steps of 10.

- f2:

  F2 in Hz.

## Source

`data-raw/price_f2.R`

## Details

True model: a logistic rise from an onset (1250 Hz English, 1320 Hz
Italian) to an offset (2050 / 1900 Hz, lowered by 2 Hz per ms that the
vowel is shorter than 250 ms), with its midpoint at 62 / 50 and width 8
/ 14. By-speaker offsets (SD 60 Hz) and midpoints (SD 5) and by-token
offsets (SD 40 Hz); residuals are AR(1) with rho 0.6 and SD 30 Hz.

## Examples

``` r
head(price_f2)
#> # A tibble: 6 × 6
#>   speaker l1      traj  duration  time    f2
#>   <fct>   <fct>   <fct>    <dbl> <dbl> <dbl>
#> 1 S01     English S01.1      252     0  1199
#> 2 S01     English S01.1      252    10  1232
#> 3 S01     English S01.1      252    20  1174
#> 4 S01     English S01.1      252    30  1194
#> 5 S01     English S01.1      252    40  1280
#> 6 S01     English S01.1      252    50  1399
```
