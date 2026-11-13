# Reaction times to high- and low-frequency words

A small lexical decision task: 10 participants each respond to the same
20 words, 10 of high and 10 of low frequency.

## Usage

``` r
rt_frequency
```

## Format

A tibble with 200 rows and 5 columns:

- participant:

  Participant ID, `P01` to `P10`.

- word:

  Word ID, `w01` to `w20`.

- frequency:

  Word frequency, `"high"` or `"low"`.

- rt:

  Reaction time in ms.

- correct:

  1 for a correct response, 0 for an error.

## Source

`data-raw/rt_frequency.R`

## Details

True model: `log(rt) = 6.38 + 0.1 * low + p0 + w0 + e`, with
by-participant intercepts `p0` (SD 0.12), by-word intercepts `w0` (SD
0.06) and residual SD 0.15, so low-frequency words take about 10%
longer. Accuracy is 95% for high- and 85% for low-frequency words.

## Examples

``` r
aggregate(cbind(rt, correct) ~ frequency, data = rt_frequency, FUN = mean)
#>   frequency     rt correct
#> 1      high 630.86    0.96
#> 2       low 692.68    0.86
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(rt) ~ frequency + (1 | participant) + (1 | word), data = rt_frequency)
  exp(lme4::fixef(m))
}
#>  (Intercept) frequencylow 
#>   619.355116     1.102924 
```
