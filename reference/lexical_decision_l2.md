# German lexical decision by L1 and L2 speakers

30 participants (15 L1 and 15 L2 speakers of German) each respond to the
same 40 German words. L2 speakers are slower and more sensitive to
frequency.

## Usage

``` r
lexical_decision_l2
```

## Format

A tibble with 1200 rows and 6 columns:

- participant:

  Participant ID, `P01` to `P30`.

- group:

  `"L1"` or `"L2"`.

- word:

  Word ID, `w01` to `w40`.

- log_freq:

  log10 word frequency, 1 to 6.

- length:

  Length in letters, 3 to 13; frequent words are shorter.

- rt:

  Reaction time in ms.

## Source

`data-raw/lexical_decision_l2.R`

## Details

True model:
`log(rt) = 6.55 + 0.16 * L2 + p0 + w0 + slope * (log_freq - 3.5) + 0.017 * (length - 7) + e`,
where `slope = -0.035 - 0.03 * L2 + p1`. By-participant intercepts `p0`
have SD 0.085 and slopes `p1` SD 0.015; by-word intercepts `w0` have SD
0.04; residual SD 0.09.

## Examples

``` r
head(lexical_decision_l2)
#> # A tibble: 6 × 6
#>   participant group word  log_freq length    rt
#>   <fct>       <fct> <fct>    <dbl>  <int> <dbl>
#> 1 P01         L1    w01       4.38      3   568
#> 2 P01         L1    w02       3.84      8   632
#> 3 P01         L1    w03       2.64      8   636
#> 4 P01         L1    w04       4.85      5   655
#> 5 P01         L1    w05       1.68     10   666
#> 6 P01         L1    w06       4.25      7   686
```
