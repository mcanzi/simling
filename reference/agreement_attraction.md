# Eye-tracking while reading: agreement attraction

Reading measures on the verb in sentences like *The key to the
cabinet(s) was/were rusty*: grammaticality by number of the attractor
noun. A plural attractor makes ungrammatical *were* easier to read. 40
participants read 32 items, each in one condition (four counterbalanced
lists).

## Usage

``` r
agreement_attraction
```

## Format

A tibble with 1280 rows and 10 columns:

- participant:

  Participant ID, `P01` to `P40`.

- list:

  Counterbalancing list, 1 to 4.

- item:

  Item ID, `i01` to `i32`.

- grammaticality:

  `"grammatical"` or `"ungrammatical"`.

- attractor:

  Number of the attractor noun, `"singular"` or `"plural"`.

- skipped:

  1 if the verb was skipped in first-pass reading.

- first_fixation:

  Duration of the first fixation on the verb in ms; `NA` if skipped.

- gaze_duration:

  Sum of first-pass fixations in ms; `NA` if skipped.

- regression:

  1 if the reader made a regression out of the verb in first pass; `NA`
  if skipped.

- total_time:

  Sum of all fixations on the verb in ms; `NA` if never fixated.

## Source

`data-raw/agreement_attraction.R`

## Details

True model:
`log(gaze_duration) = 5.55 + 0.14 * ungrammatical - 0.09 * ungrammatical * plural`,
with by-participant (SD 0.15) and by-item (SD 0.08) intercepts and
residual SD 0.3. First-pass regressions, in log-odds:
`-1.9 + 0.9 * ungrammatical - 0.5 * ungrammatical * plural`,
by-participant SD 0.5. Skipping rate about 14%, unrelated to condition.
The first fixation equals the gaze duration in 65% of trials and is 50
to 85% of it otherwise. Total time adds a rereading time (log-normal,
median about 220 ms) with probability \`plogis(-1 + 0.6 \* ungrammatical

- 1.5 \* regression)\`.

## References

Bock, K. & Miller, C. A. (1991). Broken agreement. *Cognitive
Psychology*, 23(1), 45-93.
[doi:10.1016/0010-0285(91)90003-7](https://doi.org/10.1016/0010-0285%2891%2990003-7)

## Examples

``` r
aggregate(gaze_duration ~ grammaticality + attractor, data = agreement_attraction,
          FUN = mean)
#>   grammaticality attractor gaze_duration
#> 1    grammatical  singular      271.5694
#> 2  ungrammatical  singular      306.6347
#> 3    grammatical    plural      276.6960
#> 4  ungrammatical    plural      286.7132
mean(agreement_attraction$skipped)
#> [1] 0.1429688
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(gaze_duration) ~ grammaticality * attractor + (1 | participant) +
                    (1 | item), data = agreement_attraction)
  lme4::fixef(m)
}
#>                                 (Intercept) 
#>                                  5.55015633 
#>                 grammaticalityungrammatical 
#>                                  0.11821301 
#>                             attractorplural 
#>                                  0.01384567 
#> grammaticalityungrammatical:attractorplural 
#>                                 -0.08109389 
```
