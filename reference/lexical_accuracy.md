# Accuracy in an Italian lexical decision task

30 native speakers of Italian decide whether each of 60 Italian words is
a word; the outcome is whether the response was correct. For
mixed-effects logistic regression.

## Usage

``` r
lexical_accuracy
```

## Format

A tibble with 1800 rows and 5 columns:

- participant:

  Participant ID, `P01` to `P30`.

- word:

  Word ID, `w01` to `w60`.

- log_freq:

  log10 word frequency, 1 to 6.

- freq_c:

  `log_freq`, centred on the mean of the 60 words.

- correct:

  1 for a correct response, 0 for an error.

## Source

`data-raw/lexical_accuracy.R`

## Details

True model, in log-odds: `1.5 + u0 + w0 + (0.8 + u1) * freq_c`.
By-participant intercepts `u0` have SD 0.8 and slopes `u1` SD 0.3
(uncorrelated); by-word intercepts `w0` have SD 0.5.

## Examples

``` r
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(correct ~ freq_c + (1 + freq_c || participant) + (1 | word),
                   data = lexical_accuracy, family = binomial)
  summary(m)
}
#> Generalized linear mixed model fit by maximum likelihood (Laplace
#>   Approximation) [glmerMod]
#>  Family: binomial  ( logit )
#> Formula: correct ~ freq_c + ((1 | participant) + (0 + freq_c | participant)) +  
#>     (1 | word)
#>    Data: lexical_accuracy
#> 
#>       AIC       BIC    logLik -2*log(L)  df.resid 
#>    1686.6    1714.1    -838.3    1676.6      1795 
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -7.8242 -0.3672  0.3045  0.5102  2.8066 
#> 
#> Random effects:
#>  Groups        Name        Variance Std.Dev.
#>  word          (Intercept) 0.10757  0.3280  
#>  participant   freq_c      0.07574  0.2752  
#>  participant.1 (Intercept) 0.59914  0.7740  
#> Number of obs: 1800, groups:  word, 60; participant, 30
#> 
#> Fixed effects:
#>             Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)  1.47165    0.16658   8.834   <2e-16 ***
#> freq_c       0.85216    0.08532   9.988   <2e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>        (Intr)
#> freq_c 0.164 
```
