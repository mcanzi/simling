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
rho 0.8 and innovation SD 12, so their SD is 20 (12 / sqrt(1 - 0.8^2)).

## Examples

``` r
curve <- aggregate(pupil ~ condition + time, data = pupil_noise, FUN = mean)
plot(pupil ~ time, data = curve, col = condition)

peaks <- do.call(rbind, lapply(split(curve, curve$condition),
                              function(d) d[which.max(d$pupil), ]))
peaks
#>       condition time    pupil
#> quiet     quiet 1200 179.5469
#> noise     noise 1500 256.2295
```
