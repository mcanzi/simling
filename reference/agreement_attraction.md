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

## References

Bock, K. & Miller, C. A. (1991). Broken agreement. *Cognitive
Psychology*, 23(1), 45-93.
[doi:10.1016/0010-0285(91)90003-7](https://doi.org/10.1016/0010-0285%2891%2990003-7)

## Examples

``` r
head(agreement_attraction)
#> # A tibble: 6 × 10
#>   participant  list item  grammaticality attractor skipped first_fixation
#>   <fct>       <int> <fct> <fct>          <fct>       <int>          <dbl>
#> 1 P01             1 i01   ungrammatical  singular        0            398
#> 2 P01             1 i02   ungrammatical  plural          0            349
#> 3 P01             1 i03   grammatical    singular        0            135
#> 4 P01             1 i04   grammatical    plural          0            217
#> 5 P01             1 i05   ungrammatical  singular        0            229
#> 6 P01             1 i06   ungrammatical  plural          0            265
#> # ℹ 3 more variables: gaze_duration <dbl>, regression <int>, total_time <dbl>
```
