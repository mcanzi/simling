# Vowel duration with speakers and words

16 speakers each produce the same 24 words, 12 with a voiceless and 12
with a voiced final consonant. Speakers differ in speed and in the size
of their voicing effect; words differ in duration.

## Usage

``` r
vowel_duration
```

## Format

A tibble with 384 rows and 4 columns:

- speaker:

  Speaker ID, `S01` to `S16`.

- word:

  Word ID, `w01` to `w24`.

- voicing:

  `"voiceless"` or `"voiced"`.

- duration:

  Vowel duration in ms.

## Source

`data-raw/vowel_duration.R`

## Details

True model: `duration = 150 + s0 + w0 + (20 + s1) * voiced + e`.
By-speaker intercepts `s0` have SD 25 ms and slopes `s1` SD 12 ms
(uncorrelated); by-word intercepts `w0` have SD 15 ms; residual SD 20
ms.

## Examples

``` r
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(duration ~ voicing + (1 + voicing | speaker) + (1 | word),
                  data = vowel_duration)
  summary(m)
}
#> Linear mixed model fit by REML ['lmerMod']
#> Formula: duration ~ voicing + (1 + voicing | speaker) + (1 | word)
#>    Data: vowel_duration
#> 
#> REML criterion at convergence: 3492.4
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -2.68928 -0.58558 -0.03095  0.65537  2.75815 
#> 
#> Random effects:
#>  Groups   Name          Variance Std.Dev. Corr  
#>  word     (Intercept)   158.3    12.583         
#>  speaker  (Intercept)   598.5    24.464         
#>           voicingvoiced  57.9     7.609   -0.06 
#>  Residual               402.0    20.049         
#> Number of obs: 384, groups:  word, 24; speaker, 16
#> 
#> Fixed effects:
#>               Estimate Std. Error t value
#> (Intercept)    155.516      7.259  21.423
#> voicingvoiced   20.516      5.848   3.508
#> 
#> Correlation of Fixed Effects:
#>             (Intr)
#> voicingvocd -0.376
```
