# A pilot German picture-naming study for power analysis

15 younger and 15 older adults name the same 40 pictures in German.
Naming is slower for pictures with less frequent names, more so for
older adults. Meant as the pilot data from which to simulate a larger
study.

## Usage

``` r
naming_pilot
```

## Format

A tibble with 1200 rows and 6 columns:

- participant:

  `P01` to `P30`.

- age_group:

  `"younger"` or `"older"`.

- group:

  `age_group` contrast-coded: -0.5 younger, 0.5 older.

- picture:

  `pic01` to `pic40`.

- freq_c:

  Centred log10 frequency of the picture name, about -2.5 to 2.5.

- latency:

  Naming latency in ms.

## Source

`data-raw/naming_pilot.R`

## Details

True model:

    log(latency) = 6.75 + 0.15 * group + p0 + w0
      + (-0.04 - 0.02 * group + p1) * freq_c + e

By-participant intercepts `p0` have SD 0.08 and slopes `p1` SD 0.015;
by-picture intercepts `w0` have SD 0.04; residual SD 0.1.

## Examples

``` r
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(latency) ~ age_group * freq_c + (1 + freq_c | participant) +
                    (1 | picture), data = naming_pilot)
  lme4::fixef(m)
}
#>           (Intercept)        age_groupolder                freq_c 
#>            6.67824899            0.15986993           -0.02301863 
#> age_groupolder:freq_c 
#>           -0.03207034 
```
