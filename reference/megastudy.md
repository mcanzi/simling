# Megastudy of 6000 words

Item-level norms for 6000 words, as in large lexical decision
megastudies: mean RT and accuracy per word, with correlated lexical
predictors. For multiple regression, collinearity, non-linear effects
and variable importance.

## Usage

``` r
megastudy
```

## Format

A tibble with 6000 rows and 8 columns:

- word:

  Word ID, `w0001` to `w6000`.

- log_freq:

  log10 frequency per million words.

- length:

  Length in letters, 2 to 16.

- neighbours:

  Number of orthographic neighbours.

- aoa:

  Age of acquisition in years.

- concreteness:

  Concreteness rating, 1 to 5.

- rt:

  Mean lexical decision RT in ms.

- accuracy:

  Proportion of correct responses.

## Source

`data-raw/megastudy.R`

## Details

True model:
`rt = 720 - 120 * plogis(log_freq - 2.5) + 9 * (length - 7) - 2 * neighbours + 10 * (aoa - 7) - 6 * (concreteness - 3) + e`,
with `e` normal, SD 35 ms. The frequency effect is S-shaped: it levels
off for very rare and very frequent words. Accuracy is \`plogis(2.5

- 0.7 \* (log_freq - 2.5) - 0.2 \* (aoa - 7) + e)`, with `e\` SD 0.5.
  Frequent words are shorter, have more neighbours and are acquired
  earlier.

## Examples

``` r
m1 <- lm(rt ~ log_freq + length + neighbours + aoa + concreteness, data = megastudy)
m2 <- lm(rt ~ splines::ns(log_freq, 4) + length + neighbours + aoa + concreteness,
         data = megastudy)
anova(m1, m2)
#> Analysis of Variance Table
#> 
#> Model 1: rt ~ log_freq + length + neighbours + aoa + concreteness
#> Model 2: rt ~ splines::ns(log_freq, 4) + length + neighbours + aoa + concreteness
#>   Res.Df     RSS Df Sum of Sq     F    Pr(>F)    
#> 1   5994 7175939                                 
#> 2   5991 7128571  3     47368 13.27 1.245e-08 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
coef(m2)[c("length", "neighbours", "aoa", "concreteness")]
#>       length   neighbours          aoa concreteness 
#>     8.820286    -2.221157    10.032493    -5.273099 
round(cor(megastudy[c("log_freq", "length", "neighbours", "aoa")]), 2)
#>            log_freq length neighbours   aoa
#> log_freq       1.00  -0.40       0.29 -0.58
#> length        -0.40   1.00      -0.71  0.24
#> neighbours     0.29  -0.71       1.00 -0.18
#> aoa           -0.58   0.24      -0.18  1.00
```
