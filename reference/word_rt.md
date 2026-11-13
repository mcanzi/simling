# Reaction times, word frequency and word length

400 words with their frequency, length in letters and syllables, and a
reaction time. Frequent words are shorter, so frequency and length are
correlated.

## Usage

``` r
word_rt
```

## Format

A tibble with 400 rows and 4 columns:

- log_freq:

  log10 word frequency, 1 to 6.

- length:

  Length in letters, 2 to 14.

- syllables:

  Number of syllables, roughly `length / 3`.

- rt:

  Reaction time in ms.

## Source

`data-raw/word_rt.R`

## Details

True model:
`log(rt) = 6.62 - 0.04 * (log_freq - 3.5) + 0.0186 * (length - 7) + e`,
with `e` normal, SD 0.06. Syllables have no effect of their own.

## Examples

``` r
cor(word_rt[c("log_freq", "length", "syllables")])
#>             log_freq     length  syllables
#> log_freq   1.0000000 -0.7011851 -0.6044546
#> length    -0.7011851  1.0000000  0.8429225
#> syllables -0.6044546  0.8429225  1.0000000
m <- lm(log(rt) ~ log_freq + length + syllables, data = word_rt)
summary(m)
#> 
#> Call:
#> lm(formula = log(rt) ~ log_freq + length + syllables, data = word_rt)
#> 
#> Residuals:
#>       Min        1Q    Median        3Q       Max 
#> -0.179465 -0.039362  0.000779  0.038931  0.189268 
#> 
#> Coefficients:
#>              Estimate Std. Error t value Pr(>|t|)    
#> (Intercept)  6.617147   0.022141 298.861  < 2e-16 ***
#> log_freq    -0.038949   0.002866 -13.590  < 2e-16 ***
#> length       0.020926   0.002849   7.346 1.18e-12 ***
#> syllables   -0.003550   0.006574  -0.540     0.59    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Residual standard error: 0.05979 on 396 degrees of freedom
#> Multiple R-squared:  0.7073, Adjusted R-squared:  0.7051 
#> F-statistic:   319 on 3 and 396 DF,  p-value: < 2.2e-16
#> 
summary(lm(log(rt) ~ syllables, data = word_rt))$coefficients
#>               Estimate  Std. Error   t value     Pr(>|t|)
#> (Intercept) 6.42007031 0.012527868 512.46313 0.000000e+00
#> syllables   0.08268879 0.005030299  16.43815 1.036217e-46
```
