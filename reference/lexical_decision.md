# Lexical decision with participants and words

20 participants each respond to the same 40 words. Participants differ
in speed and in the size of their frequency effect; words differ in
difficulty. For crossed random effects.

## Usage

``` r
lexical_decision
```

## Format

A tibble with 800 rows and 5 columns:

- participant:

  Participant ID, `P01` to `P20`.

- word:

  Word ID, `w01` to `w40`.

- log_freq:

  log10 word frequency, 1 to 6.

- freq_c:

  `log_freq`, centred on the mean of the 40 words.

- rt:

  Reaction time in ms.

## Source

`data-raw/lexical_decision.R`

## Details

True model: `log(rt) = 6.47 + u0 + w0 + (-0.045 + u1) * freq_c + e`.
By-participant intercepts `u0` have SD 0.11 and slopes `u1` SD 0.025,
correlated at -0.6; by-word intercepts `w0` have SD 0.045; residual SD
0.075. `languageR::lexdec` is a different data set, with real data.

## Examples

``` r
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(log(rt) ~ freq_c + (1 + freq_c | participant) + (1 | word),
                  data = lexical_decision)
  summary(m)
}
#> Linear mixed model fit by REML ['lmerMod']
#> Formula: log(rt) ~ freq_c + (1 + freq_c | participant) + (1 | word)
#>    Data: lexical_decision
#> 
#> REML criterion at convergence: -1665.1
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -2.91814 -0.59608 -0.03356  0.66228  2.72553 
#> 
#> Random effects:
#>  Groups      Name        Variance  Std.Dev. Corr  
#>  word        (Intercept) 0.0014925 0.03863        
#>  participant (Intercept) 0.0154301 0.12422        
#>              freq_c      0.0006462 0.02542  -0.64 
#>  Residual                0.0055712 0.07464        
#> Number of obs: 800, groups:  word, 40; participant, 20
#> 
#> Fixed effects:
#>              Estimate Std. Error t value
#> (Intercept)  6.488661   0.028562 227.179
#> freq_c      -0.044199   0.007188  -6.149
#> 
#> Correlation of Fixed Effects:
#>        (Intr)
#> freq_c -0.489
```
