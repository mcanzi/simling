# Pupil dilation when listening in quiet and in noise

Pupil size over 3 seconds after stimulus onset, 12 trials per condition
from each of 24 participants. Listening in noise leads to a larger and
later peak. For GAMMs with autocorrelated residuals.

## Usage

``` r
pupil_noise
```

## Format

A tibble with 17856 rows and 6 columns:

- participant:

  `P01` to `P24`.

- condition:

  `"quiet"` or `"noise"`.

- trial:

  Trial number within condition, 1 to 12.

- trial_id:

  One level per trial (`participant.condition.trial`).

- time:

  Time from stimulus onset in ms, 0 to 3000 in steps of 100.

- pupil:

  Baseline-corrected pupil size, arbitrary units.

## Source

`data-raw/pupil_noise.R`

## Details

True model: a gamma-shaped response peaking at 180 units after 1200 ms
in quiet, and 90 units higher and 250 ms later in noise. The peak
shrinks by 4 units per trial (habituation). By-participant variation in
peak (SD 40), latency (SD 150 ms) and noise effect (SD 30); by-trial
variation in peak (SD 40) and baseline (SD 15); residuals are AR(1) with
rho 0.8 and SD 12.

## Examples

``` r
head(pupil_noise)
#> # A tibble: 6 × 6
#>   participant condition trial trial_id     time pupil
#>   <fct>       <fct>     <int> <fct>       <dbl> <dbl>
#> 1 P01         noise         1 P01.noise.1     0   5.2
#> 2 P01         noise         1 P01.noise.1   100  -1  
#> 3 P01         noise         1 P01.noise.1   200   1.8
#> 4 P01         noise         1 P01.noise.1   300  20.1
#> 5 P01         noise         1 P01.noise.1   400  55.6
#> 6 P01         noise         1 P01.noise.1   500  84.4
```
