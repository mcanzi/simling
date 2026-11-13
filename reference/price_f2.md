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
if (requireNamespace("mgcv", quietly = TRUE)) {
  m <- mgcv::bam(f2 ~ l1 + s(time, by = l1) + s(time, speaker, bs = "fs", m = 1),
                 data = price_f2)
  summary(m)
  new <- expand.grid(time = c(0, 50, 100), l1 = c("English", "Italian"), speaker = "S01")
  cbind(new, f2 = predict(m, new, exclude = "s(time,speaker)"))
}
#>   time      l1 speaker       f2
#> 1    0 English     S01 1276.931
#> 2   50 English     S01 1408.882
#> 3  100 English     S01 1991.965
#> 4    0 Italian     S01 1315.532
#> 5   50 Italian     S01 1551.971
#> 6  100 Italian     S01 1780.778
```
