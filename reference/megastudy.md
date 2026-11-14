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

A tibble with 6000 rows and 9 columns:

- word:

  Word ID, `w0001` to `w6000`.

- log_freq:

  log10 frequency per million words.

- length:

  Length in letters, 2 to 15.

- syllables:

  Number of syllables, 1 to 6.

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
      + 8 * (syllables - 2.5) - 2 * neighbours + 10 * (aoa - 7)
      - 6 * (concreteness - 3) + e
    accuracy = plogis(2.5 + 0.7 * (log_freq - 2.5) - 0.2 * (aoa - 7) + e)

The error `e` is normal with SD 35 ms for RT and SD 0.5 for accuracy.
The frequency effect is S-shaped: it levels off for very rare and very
frequent words. Frequent words are shorter, have more neighbours and are
acquired earlier. Syllables correlate with length (r = 0.75): on its
own, each syllable adds about 39 ms, but only 8 ms once length is in the
model. Mean length (8 letters), mean number of syllables (2.6), mean RT
(about 790 ms) and mean accuracy (0.86) are close to the English Lexicon
Project words (Balota et al. 2007: 8 letters, 2.54 syllables, 784 ms,
0.84), but RTs vary less across words (SD 68 ms against 135 ms). In the
English Lexicon Project, the number of syllables has an inhibitory
effect of its own and the length effect is U-shaped (New et al. 2006);
here the length effect is linear. The effects and data are simulated.

## References

Balota, D. A., Yap, M. J., Cortese, M. J., Hutchison, K. A., Kessler,
B., Loftis, B., Neely, J. H., Nelson, D. L., Simpson, G. B. & Treiman,
R. (2007). The English Lexicon Project. *Behavior Research Methods*,
39(3), 445-459.
[doi:10.3758/BF03193014](https://doi.org/10.3758/BF03193014)

New, B., Ferrand, L., Pallier, C. & Brysbaert, M. (2006). Reexamining
the word length effect in visual word recognition: New evidence from the
English Lexicon Project. *Psychonomic Bulletin & Review*, 13(1), 45-52.
[doi:10.3758/BF03193811](https://doi.org/10.3758/BF03193811)

## Examples

``` r
round(cor(megastudy[c("log_freq", "length", "syllables", "neighbours", "aoa")]), 2)
#>            log_freq length syllables neighbours   aoa
#> log_freq       1.00  -0.41     -0.30       0.25 -0.57
#> length        -0.41   1.00      0.75      -0.63  0.24
#> syllables     -0.30   0.75      1.00      -0.46  0.18
#> neighbours     0.25  -0.63     -0.46       1.00 -0.15
#> aoa           -0.57   0.24      0.18      -0.15  1.00
coef(lm(rt ~ syllables, data = megastudy))
#> (Intercept)   syllables 
#>   686.68015    38.95821 
m1 <- lm(rt ~ log_freq + length + syllables + neighbours + aoa + concreteness,
         data = megastudy)
m2 <- lm(rt ~ splines::ns(log_freq, 4) + length + syllables + neighbours + aoa +
           concreteness, data = megastudy)
anova(m1, m2)
#> Analysis of Variance Table
#> 
#> Model 1: rt ~ log_freq + length + syllables + neighbours + aoa + concreteness
#> Model 2: rt ~ splines::ns(log_freq, 4) + length + syllables + neighbours + 
#>     aoa + concreteness
#>   Res.Df     RSS Df Sum of Sq      F    Pr(>F)    
#> 1   5993 7286785                                  
#> 2   5990 7241395  3     45390 12.515 3.728e-08 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
coef(m2)[c("length", "syllables", "neighbours", "aoa", "concreteness")]
#>       length    syllables   neighbours          aoa concreteness 
#>     8.861030     8.142864    -1.992065     9.643519    -6.460866 
```
