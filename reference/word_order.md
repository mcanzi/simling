# Word order in a typological sample

400 invented languages from 100 invented families in six invented areas.
Languages mostly inherit their family's word order, so languages from
the same family are similar. Adposition order and case marking correlate
with word order in the same way in every family, as in Greenberg's
(1963) universals. Dunn et al. (2011) argue that such dependencies are
mostly specific to lineages, so real samples need not share one pattern.
Family sizes are skewed: a few large families and many small ones.

## Usage

``` r
word_order
```

## Format

A tibble with 400 rows and 8 columns:

- language:

  Language ID, `L001` to `L400`.

- family:

  `"Family 001"` to `"Family 100"`.

- area:

  `"Area A"` to `"Area F"`.

- order:

  Basic word order: `"SOV"`, `"SVO"`, `"VSO"` or `"no dominant order"`.

- adpositions:

  `"postpositions"` or `"prepositions"`.

- case_marking:

  Whether nouns are case-marked, `"no"` or `"yes"`.

- consonants:

  Size of the consonant inventory.

- vowels:

  Size of the vowel inventory.

## Source

`data-raw/word_order.R`

## Details

True model: each family draws a word order from its area's preferences;
each language keeps it with probability 0.8 and otherwise draws again.
Postpositions have probability 0.92 in SOV, 0.5 in no-dominant-order and
0.12 in VO languages. Case marking has probability 0.7 in SOV and 0.3 in
other languages. Consonant inventories are 6 plus a negative binomial
count (mean 16, by-family variation); vowel inventories are 3 plus a
Poisson count (mean 2.5). Overall, about 44% of the languages are SOV,
36% SVO, 6% VSO and 14% have no dominant order, close to the world-wide
proportions in WALS (feature 81A). All language, family and area names
and all figures are invented.

## References

Dryer, M. S. (2013). Order of subject, object and verb. In M. S. Dryer &
M. Haspelmath (eds.), *WALS Online*. Leipzig: Max Planck Institute for
Evolutionary Anthropology. <https://wals.info/chapter/81>

Greenberg, J. H. (1963). Some universals of grammar with particular
reference to the order of meaningful elements. In J. H. Greenberg (ed.),
*Universals of Language* (pp. 58-90). Cambridge, MA: MIT Press.

Dunn, M., Greenhill, S. J., Levinson, S. C. & Gray, R. D. (2011).
Evolved structure of language shows lineage-specific trends in
word-order universals. *Nature*, 473(7345), 79-82.
[doi:10.1038/nature09923](https://doi.org/10.1038/nature09923)

## Examples

``` r
round(prop.table(table(word_order$order)), 2)
#> 
#>               SOV               SVO               VSO no dominant order 
#>              0.44              0.36              0.06              0.14 
round(prop.table(table(word_order$order, word_order$adpositions), 1), 2)
#>                    
#>                     postpositions prepositions
#>   SOV                        0.90         0.10
#>   SVO                        0.14         0.86
#>   VSO                        0.04         0.96
#>   no dominant order          0.46         0.54
head(sort(table(word_order$family), decreasing = TRUE))
#> 
#> Family 002 Family 069 Family 005 Family 006 Family 052 Family 004 
#>         17         16         14         13         13         11 
if (requireNamespace("lme4", quietly = TRUE)) {
  word_order$sov <- word_order$order == "SOV"
  m1 <- glm(adpositions ~ sov, data = word_order, family = binomial)
  m2 <- lme4::glmer(adpositions ~ sov + (1 | family), data = word_order, family = binomial)
  rbind(glm = summary(m1)$coefficients["sovTRUE", 1:2],
        glmer = summary(m2)$coefficients["sovTRUE", 1:2])
}
#>        Estimate Std. Error
#> glm   -3.561018  0.3033691
#> glmer -3.629515  0.3637423
```
