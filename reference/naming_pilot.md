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
`log(latency) = 6.75 + 0.15 * group + p0 + w0 + (-0.04 - 0.02 * group + p1) * freq_c + e`.
By-participant intercepts `p0` have SD 0.08 and slopes `p1` SD 0.015;
by-picture intercepts `w0` have SD 0.04; residual SD 0.1.

## Examples

``` r
head(naming_pilot)
#> # A tibble: 6 × 6
#>   participant age_group group picture freq_c latency
#>   <fct>       <fct>     <dbl> <fct>    <dbl>   <dbl>
#> 1 P01         younger    -0.5 pic01    -0.27     938
#> 2 P01         younger    -0.5 pic02     1.33     777
#> 3 P01         younger    -0.5 pic03     0.9      855
#> 4 P01         younger    -0.5 pic04     2.22     765
#> 5 P01         younger    -0.5 pic05    -2.43     872
#> 6 P01         younger    -0.5 pic06     0.46     779
```
