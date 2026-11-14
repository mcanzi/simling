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

  Vowels of the stem: `"B"` (back), `"F"` (front rounded), `"N"` (one
  neutral vowel), `"Bi"`, `"Bé"`, `"Be"` (back vowel plus one neutral
  vowel) or `"BNN"` (back vowel plus two neutral vowels, the last one
  *e*).

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

True model: the probability of a back suffix is 0.99 (B), 0.01 (F), 0.06
(N), 0.95 (Bi), 0.38 (Bé), 0.07 (Be) and 0.02 (BNN), shifted on the
logit scale by participant (SD 0.5) and item (SD 0.4) effects. These are
the rounded proportions of back responses in the wug test of Hayes and
Londe (2006, Table III); BNN uses their stems ending in *e*. Items are
identified by their stem type; the nonce word forms are left out.
Participants, items and responses are simulated.

## References

Hayes, B. & Londe, Z. C. (2006). Stochastic phonological knowledge: The
case of Hungarian vowel harmony. *Phonology*, 23(1), 59-104.
[doi:10.1017/S0952675706000765](https://doi.org/10.1017/S0952675706000765)

Hayes, B., Zuraw, K., Siptár, P. & Londe, Z. (2009). Natural and
unnatural constraints in Hungarian vowel harmony. *Language*, 85(4),
822-863. [doi:10.1353/lan.0.0169](https://doi.org/10.1353/lan.0.0169)

## Examples

``` r
round(prop.table(table(hungarian_harmony$stem_type, hungarian_harmony$suffix), 1), 2)
#>      
#>       back front
#>   B   0.98  0.02
#>   F   0.01  0.99
#>   N   0.07  0.93
#>   Bi  0.95  0.05
#>   Bé  0.41  0.60
#>   Be  0.10  0.90
#>   BNN 0.03  0.97
if (requireNamespace("lme4", quietly = TRUE)) {
  mixed <- subset(hungarian_harmony, is.element(stem_type, c("Bi", "Bé", "Be", "BNN")))
  m <- lme4::glmer(suffix ~ stem_type + (1 | participant) + (1 | item),
                   data = droplevels(mixed), family = binomial)
  lme4::fixef(m)
}
#>  (Intercept)  stem_typeBé  stem_typeBe stem_typeBNN 
#>    -3.159737     3.575282     5.519569     6.692253 
```
