# Iconicity ratings for signs of German Sign Language

30 deaf signers of German Sign Language (DGS) and 30 hearing non-signers
rate 300 DGS signs for iconicity (1 = not iconic, 7 = very iconic).
Ratings by the two groups are highly correlated. Signers rate signs as
more iconic overall, and non-signers rate verbs as more iconic than
nouns. More iconic signs are acquired earlier. For mixed models of
ratings with crossed raters and items.

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
`3.6 + iconicity + r0 + 0.4 * signer + 0.5 * verb * non-signer + e`,
rounded and limited to 1-7. Each sign's iconicity has SD 1.2, raters
differ by SD 0.5 and `e` has SD 0.9. Age of acquisition is
`5.5 - 0.6 * iconicity` years plus noise (SD 1.3). The group differences
follow findings for DGS (signers higher) and for ASL and Israeli Sign
Language (verbs higher for non-signers).

## References

Trettenbrein, P. C., Pendzich, N.-K., Cramer, J.-M., Steinbach, M. &
Zaccarella, E. (2021). Psycholinguistic norms for more than 300 lexical
signs in German Sign Language (DGS). *Behavior Research Methods*, 53(5),
1817-1832.
[doi:10.3758/s13428-020-01524-y](https://doi.org/10.3758/s13428-020-01524-y)

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
head(dgs_iconicity)
#> # A tibble: 6 × 7
#>   rater group       sign    category handedness   aoa rating
#>   <fct> <fct>       <fct>   <fct>    <fct>      <dbl>  <int>
#> 1 R01   deaf signer sign001 noun     one-handed   4.5      6
#> 2 R01   deaf signer sign002 noun     two-handed   6.9      5
#> 3 R01   deaf signer sign003 verb     two-handed   5        6
#> 4 R01   deaf signer sign004 noun     one-handed   8.8      1
#> 5 R01   deaf signer sign005 noun     one-handed   6.8      4
#> 6 R01   deaf signer sign006 verb     one-handed   6.4      7
```
