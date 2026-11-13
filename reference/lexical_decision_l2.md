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
lexical_decision_l2$freq_c <- lexical_decision_l2$log_freq - 3.5
lexical_decision_l2$length_c <- lexical_decision_l2$length - 7
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(rt) ~ group * freq_c + length_c + (1 + freq_c | participant) +
                    (1 | word), data = lexical_decision_l2)
  lme4::fixef(m)
}
#>    (Intercept)        groupL2         freq_c       length_c groupL2:freq_c 
#>     6.53334179     0.20409400    -0.02452505     0.01448920    -0.04226105 
```
