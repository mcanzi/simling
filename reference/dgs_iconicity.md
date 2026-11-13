# Iconicity ratings for signs of German Sign Language

30 deaf signers of German Sign Language (DGS) and 30 hearing non-signers
rate 300 DGS signs for iconicity (1 = not iconic, 7 = very iconic).
Ratings by the two groups are correlated (r about 0.78 for sign means,
as in Trettenbrein et al. 2021). Signers rate signs as more iconic
overall, and non-signers rate verbs as more iconic than nouns. More
iconic signs are acquired earlier. For mixed models of ratings with
crossed raters and items.

## Usage

``` r
dgs_iconicity
```

## Format

A tibble with 18000 rows and 7 columns:

- rater:

  Rater ID, `R01` to `R60`.

- group:

  `"hearing non-signer"` or `"deaf signer"`.

- sign:

  Sign ID, `sign001` to `sign300`.

- category:

  `"noun"` or `"verb"`.

- handedness:

  `"one-handed"` or `"two-handed"`; no effect.

- aoa:

  Age of acquisition of the sign in years, as rated by deaf signers.

- rating:

  Iconicity rating, 1 to 7.

## Source

`data-raw/dgs_iconicity.R`

## Details

True model: `rating` is
`3.3 + iconicity + g0 + r0 + signer + 0.5 * verb * non-signer + e`,
rounded and limited to 1-7. Each sign's iconicity has SD 1.2, `g0` is a
deviation of each sign within each group (SD 0.6), raters differ by SD
0.5 and `e` has SD 0.9. Age of acquisition is `5.5 - 0.6 * iconicity`
years plus noise (SD 1.3). The group differences follow findings for DGS
(signers higher) and for ASL (Sehyr and Emmorey 2019) and Israeli Sign
Language (Fuks 2023) (verbs higher for non-signers).

## References

Trettenbrein, P. C., Pendzich, N.-K., Cramer, J.-M., Steinbach, M. &
Zaccarella, E. (2021). Psycholinguistic norms for more than 300 lexical
signs in German Sign Language (DGS). *Behavior Research Methods*, 53(5),
1817-1832.
[doi:10.3758/s13428-020-01524-y](https://doi.org/10.3758/s13428-020-01524-y)

Fuks, O. (2023). Iconicity perception under the lens of iconicity rating
and transparency tasks in Israeli Sign Language (ISL). *Sign Language
Studies*, 24(1), 46-92.

Sehyr, Z. S. & Emmorey, K. (2019). The perceived mapping between form
and meaning in American Sign Language depends on linguistic knowledge
and task: Evidence from iconicity and transparency judgments. *Language
and Cognition*, 11(2), 208-234.
[doi:10.1017/langcog.2019.18](https://doi.org/10.1017/langcog.2019.18)

Thompson, R. L., Vinson, D. P., Woll, B. & Vigliocco, G. (2012). The
road to language learning is iconic: Evidence from British Sign
Language. *Psychological Science*, 23(12), 1443-1448.
[doi:10.1177/0956797612459763](https://doi.org/10.1177/0956797612459763)

## Examples

``` r
round(tapply(dgs_iconicity$rating, dgs_iconicity[c("group", "category")], mean), 2)
#>                     category
#> group                noun verb
#>   hearing non-signer 3.51 3.95
#>   deaf signer        4.37 4.47
signs <- aggregate(rating ~ sign + group, data = dgs_iconicity, FUN = mean)
signs <- reshape(signs, idvar = "sign", timevar = "group", direction = "wide")
cor(signs[, 2], signs[, 3])
#> [1] 0.7814731
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(rating ~ group * category + (1 | rater) + (1 | sign), data = dgs_iconicity)
  lme4::fixef(m)
}
#>                   (Intercept)              groupdeaf signer 
#>                     3.5124260                     0.8609467 
#>                  categoryverb groupdeaf signer:categoryverb 
#>                     0.4425358                    -0.3428806 
```
