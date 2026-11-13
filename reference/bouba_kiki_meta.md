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

True model: each study's true log-odds is `0.85 + 0.2 * Roman` plus a
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
if (requireNamespace("metafor", quietly = TRUE)) {
  m <- metafor::rma(yi = log_odds, sei = se, data = bouba_kiki_meta)
  print(m)
  print(metafor::rma(yi = log_odds, sei = se, mods = ~ script, data = bouba_kiki_meta))
  print(metafor::regtest(m))
  metafor::funnel(m)
}
#> 
#> Random-Effects Model (k = 40; tau^2 estimator: REML)
#> 
#> tau^2 (estimated amount of total heterogeneity): 0.1230 (SE = 0.0386)
#> tau (square root of estimated tau^2 value):      0.3507
#> I^2 (total heterogeneity / total variability):   78.73%
#> H^2 (total variability / sampling variability):  4.70
#> 
#> Test for Heterogeneity:
#> Q(df = 39) = 182.1438, p-val < .0001
#> 
#> Model Results:
#> 
#> estimate      se     zval    pval   ci.lb   ci.ub      
#>   0.9776  0.0663  14.7553  <.0001  0.8478  1.1075  *** 
#> 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> 
#> Mixed-Effects Model (k = 40; tau^2 estimator: REML)
#> 
#> tau^2 (estimated amount of residual heterogeneity):     0.1271 (SE = 0.0401)
#> tau (square root of estimated tau^2 value):             0.3564
#> I^2 (residual heterogeneity / unaccounted variability): 79.05%
#> H^2 (unaccounted variability / sampling variability):   4.77
#> R^2 (amount of heterogeneity accounted for):            0.00%
#> 
#> Test for Residual Heterogeneity:
#> QE(df = 38) = 182.0415, p-val < .0001
#> 
#> Test of Moderators (coefficient 2):
#> QM(df = 1) = 0.2716, p-val = 0.6023
#> 
#> Model Results:
#> 
#>              estimate      se    zval    pval    ci.lb   ci.ub      
#> intrcpt        0.9417  0.0975  9.6587  <.0001   0.7506  1.1328  *** 
#> scriptRoman    0.0700  0.1343  0.5211  0.6023  -0.1933  0.3333      
#> 
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> 
#> Regression Test for Funnel Plot Asymmetry
#> 
#> Model:     mixed-effects meta-regression model
#> Predictor: standard error
#> 
#> Test for Funnel Plot Asymmetry: z = 2.8968, p = 0.0038
#> Limit Estimate (as sei -> 0):   b = 0.5931 (CI: 0.3121, 0.8741)
#> 
```
