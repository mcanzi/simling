# A meta-analysis of the bouba/kiki effect

40 published studies of the bouba/kiki effect: how many participants
matched *bouba* with a round and *kiki* with a spiky shape. The studies
tested speakers of 21 languages. Studies with a non-significant result
were less likely to be published, so the published effects are inflated.
For random-effects meta-analysis, moderators, funnel plots and
publication bias.

## Usage

``` r
bouba_kiki_meta
```

## Format

A tibble with 40 rows and 8 columns:

- study:

  Study ID, `S01` to `S40`.

- year:

  Year of publication.

- language:

  Language of the participants.

- script:

  Writing system of the language: `"other"` or `"Roman"`.

- n:

  Number of participants.

- congruent:

  Participants giving the congruent match.

- log_odds:

  Log-odds of a congruent match,
  `log((congruent + 0.5) / (n - congruent + 0.5))`.

- se:

  Standard error of `log_odds`.

## Source

`data-raw/bouba_kiki_meta.R`

## Details

True model: each study's true log-odds is `0.85 + 0.1 * Roman` plus a
study effect with SD (tau) 0.35, about 70% congruent matches. Of 90
simulated studies, those with a significant positive result were
published with probability 0.95 and the rest with probability 0.3; the
first 40 published studies are included. Studies, years and samples are
invented.

## References

Ćwiek, A., Fuchs, S., Draxler, C., Asu, E. L., Dediu, D., Hiovain, K.,
Kawahara, S., Koutalidis, S., Krifka, M., Lippus, P., Lupyan, G., Oh, G.
E., Paul, J., Petrone, C., Ridouane, R., Reiter, S., Schümchen, N.,
Szalontai, Á., Ünal-Logacev, Ö., Zeller, J., Perlman, M. & Winter, B.
(2022). The bouba/kiki effect is robust across cultures and writing
systems. *Philosophical Transactions of the Royal Society B*, 377(1841),
20200390.
[doi:10.1098/rstb.2020.0390](https://doi.org/10.1098/rstb.2020.0390)

## Examples

``` r
head(bouba_kiki_meta)
#> # A tibble: 6 × 8
#>   study  year language script     n congruent log_odds    se
#>   <fct> <int> <fct>    <fct>  <int>     <int>    <dbl> <dbl>
#> 1 S01    2001 Farsi    other    195       151    1.23  0.171
#> 2 S02    2001 Polish   Roman     24        16    0.663 0.422
#> 3 S03    2001 Farsi    other    197       130    0.659 0.15 
#> 4 S04    2001 Korean   other     56        40    0.898 0.292
#> 5 S05    2002 Finnish  Roman    107        74    0.799 0.208
#> 6 S06    2002 Greek    other     95        77    1.43  0.259
```
