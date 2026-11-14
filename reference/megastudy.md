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

  Length in letters, 2 to 15.

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

    rt = 825 - 120 * plogis(log_freq - 2.5) + 9 * (length - 7)
      - 2 * neighbours + 10 * (aoa - 7) - 6 * (concreteness - 3) + e
    accuracy = plogis(2.5 + 0.7 * (log_freq - 2.5) - 0.2 * (aoa - 7) + e)

The error `e` is normal with SD 35 ms for RT and SD 0.5 for accuracy.
The frequency effect is S-shaped: it levels off for very rare and very
frequent words. Frequent words are shorter, have more neighbours and are
acquired earlier. Mean length (8 letters), mean RT (about 785 ms) and
mean accuracy (0.86) are close to the English Lexicon Project words
(Balota et al. 2007: 8 letters, 784 ms, 0.84), but RTs vary less across
words (SD 64 ms against 135 ms). The effects and data are simulated.

## References

Balota, D. A., Yap, M. J., Cortese, M. J., Hutchison, K. A., Kessler,
B., Loftis, B., Neely, J. H., Nelson, D. L., Simpson, G. B. & Treiman,
R. (2007). The English Lexicon Project. *Behavior Research Methods*,
39(3), 445-459.
[doi:10.3758/BF03193014](https://doi.org/10.3758/BF03193014)

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
#>   Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
#> 1   5994 7148153                                  
#> 2   5991 7120410  3     27743 7.7809 3.498e-05 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
coef(m2)[c("length", "neighbours", "aoa", "concreteness")]
#>       length   neighbours          aoa concreteness 
#>     8.930200    -1.909641    10.033375    -5.063249 
round(cor(megastudy[c("log_freq", "length", "neighbours", "aoa")]), 2)
#>            log_freq length neighbours   aoa
#> log_freq       1.00  -0.41       0.25 -0.58
#> length        -0.41   1.00      -0.63  0.23
#> neighbours     0.25  -0.63       1.00 -0.16
#> aoa           -0.58   0.23      -0.16  1.00
```
