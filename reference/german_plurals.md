# A wug test of German noun plurals

60 adult native speakers of German give the plural of 48 nonce nouns,
each presented with its article (*der*, *die*, *das*). The plural ending
depends on gender and on how the noun ends: schwa-final and feminine
nouns mostly take *-(e)n*, nouns in *-el*/*-er* mostly no ending,
masculine and neuter nouns ending in a consonant mostly *-e*, and nouns
ending in a full vowel *-s*. Speakers differ in how readily they use
*-s*. A five-way outcome.

## Usage

``` r
german_plurals
```

## Format

A tibble with 2880 rows and 7 columns:

- participant:

  Participant ID, `P01` to `P60`.

- item:

  Item ID, `i01` to `i48`.

- nonce:

  The nonce noun, e.g. `"Pünde"`.

- article:

  `"der"`, `"die"` or `"das"`.

- gender:

  `"masculine"`, `"feminine"` or `"neuter"`.

- final:

  How the noun ends: `"schwa"`, `"-el/-er"`, `"consonant"` or
  `"full vowel"`.

- plural:

  `"-e"`, `"-(e)n"`, `"-er"`, `"-s"` or `"zero"`.

## Source

`data-raw/german_plurals.R`

## Details

True model: each gender-by-ending cell has its own probabilities for the
five endings (see the data script), perturbed on the log scale by a
by-participant preference for *-s* (SD 0.6) and by response-level noise
(SD 0.3).

## References

Berko, J. (1958). The child's learning of English morphology. *Word*,
14(2-3), 150-177.
[doi:10.1080/00437956.1958.11659661](https://doi.org/10.1080/00437956.1958.11659661)

## Examples

``` r
round(prop.table(table(german_plurals$final, german_plurals$plural), 1), 2)
#>             
#>                -e -(e)n  -er   -s zero
#>   schwa      0.06  0.73 0.02 0.09 0.10
#>   -el/-er    0.07  0.30 0.01 0.12 0.50
#>   consonant  0.38  0.32 0.11 0.13 0.05
#>   full vowel 0.03  0.11 0.03 0.77 0.06
round(prop.table(table(german_plurals$gender, german_plurals$plural), 1), 2)
#>            
#>               -e -(e)n  -er   -s zero
#>   masculine 0.17  0.29 0.04 0.27 0.23
#>   feminine  0.07  0.61 0.01 0.24 0.06
#>   neuter    0.16  0.19 0.08 0.32 0.24
if (requireNamespace("nnet", quietly = TRUE)) {
  m <- nnet::multinom(plural ~ gender + final, data = german_plurals, trace = FALSE)
  round(coef(m), 2)
}
#>       (Intercept) genderfeminine genderneuter final-el/-er finalconsonant
#> -(e)n        2.33           1.89        -0.52        -1.58          -3.14
#> -er         -1.42          -0.45         0.81        -0.72          -0.18
#> -s           0.12           0.67         0.44         0.07          -1.53
#> zero         0.58          -0.59         0.12         1.47          -2.58
#>       finalfull vowel
#> -(e)n           -1.76
#> -er              0.99
#> -s               2.78
#> zero             0.13
```
