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
head(rt_frequency)
#> # A tibble: 6 × 5
#>   participant word  frequency    rt correct
#>   <fct>       <fct> <fct>     <dbl>   <int>
#> 1 P01         w01   high        805       1
#> 2 P01         w02   high        887       1
#> 3 P01         w03   high        747       1
#> 4 P01         w04   high        624       1
#> 5 P01         w05   high        744       1
#> 6 P01         w06   high        558       1
```
