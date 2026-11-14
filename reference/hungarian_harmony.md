# Hungarian vowel harmony in a wug test

50 Hungarian speakers choose between a back (*-nak*) and a front
(*-nek*) dative suffix for 84 nonce stems. Stems with only back vowels
take back suffixes and stems with front rounded vowels front ones. Stems
with a back vowel followed by neutral vowels vary: the lower the last
neutral vowel (*i* \> *é* \> *e*), the more front suffixes (the Height
Effect), and two neutral vowels give more front suffixes than one (the
Count Effect).

## Usage

``` r
hungarian_harmony
```

## Format

A tibble with 4200 rows and 6 columns:

- participant:

  Participant ID, `P01` to `P50`.

- item:

  Item ID, `i01` to `i84`.

- stem_type:

  Vowels of the stem: `"B"` (back), `"F"` (front rounded), `"N"`
  (neutral only), `"Bi"`, `"Bé"`, `"Be"` (back vowel plus one neutral
  vowel) or `"BNN"` (back vowel plus two neutral vowels).

- n_neutral:

  Number of neutral vowels after the last back vowel.

- last_vowel:

  Last vowel of the stem: `"back"`, `"front rounded"`, `"high"`, `"mid"`
  or `"low"`.

- suffix:

  `"back"` or `"front"`.

## Source

`data-raw/hungarian_harmony.R`

## Details

True model: the probability of a back suffix is 0.97 (B), 0.03 (F), 0.08
(N), 0.90 (Bi), 0.60 (Bé), 0.35 (Be) and 0.20 (BNN), shifted on the
logit scale by participant (SD 0.5) and item (SD 0.4) effects. Items are
identified by their stem type; the nonce word forms are left out.

## References

Hayes, B. & Londe, Z. C. (2006). Stochastic phonological knowledge: The
case of Hungarian vowel harmony. *Phonology*, 23, 59-104.
[doi:10.1017/S0952675706000765](https://doi.org/10.1017/S0952675706000765)

Hayes, B., Zuraw, K., Siptár, P. & Londe, Z. (2009). Natural and
unnatural constraints in Hungarian vowel harmony. *Language*, 85,
822-863. [doi:10.1353/lan.0.0169](https://doi.org/10.1353/lan.0.0169)

## Examples

``` r
round(prop.table(table(hungarian_harmony$stem_type, hungarian_harmony$suffix), 1), 2)
#>      
#>       back front
#>   B   0.97  0.03
#>   F   0.03  0.97
#>   N   0.10  0.90
#>   Bi  0.90  0.10
#>   Bé  0.57  0.43
#>   Be  0.40  0.60
#>   BNN 0.27  0.73
if (requireNamespace("lme4", quietly = TRUE)) {
  mixed <- subset(hungarian_harmony, is.element(stem_type, c("Bi", "Bé", "Be", "BNN")))
  m <- lme4::glmer(suffix ~ stem_type + (1 | participant) + (1 | item),
                   data = droplevels(mixed), family = binomial)
  lme4::fixef(m)
}
#>  (Intercept)  stem_typeBé  stem_typeBe stem_typeBNN 
#>    -2.412535     2.089041     2.851846     3.535132 
```
