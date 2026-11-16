# Vowel duration in three speaking styles

50 vowels each in casual, clear and loud speech.

## Usage

``` r
speech_styles
```

## Format

A tibble with 150 rows and 2 columns:

- style:

  `"casual"`, `"clear"` or `"loud"`.

- duration:

  Vowel duration in ms.

## Source

`data-raw/speech_styles.R`

## Details

True model: mean 110 ms (SD 18) in casual, 150 ms (SD 20) in clear and
132 ms (SD 19) in loud speech.

## Examples

``` r
m <- lm(duration ~ style, data = speech_styles)
anova(m)
#> Analysis of Variance Table
#> 
#> Response: duration
#>            Df Sum Sq Mean Sq F value    Pr(>F)    
#> style       2  42881 21440.5  62.266 < 2.2e-16 ***
#> Residuals 147  50618   344.3                      
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
coef(m)
#> (Intercept)  styleclear   styleloud 
#>      108.34       41.40       21.68 
pairwise.t.test(speech_styles$duration, speech_styles$style)
#> 
#>  Pairwise comparisons using t tests with pooled SD 
#> 
#> data:  speech_styles$duration and speech_styles$style 
#> 
#>       casual  clear  
#> clear < 2e-16 -      
#> loud  6.4e-08 3.9e-07
#> 
#> P value adjustment method: holm 
```
