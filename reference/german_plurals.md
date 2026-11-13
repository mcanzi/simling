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
five endings (see `data-raw/german_plurals.R`), perturbed on the log
scale by a by-participant preference for *-s* (SD 0.6) and by
response-level noise (SD 0.3).

## References

Berko, J. (1958). The child's learning of English morphology. *Word*,
14(2-3), 150-177.
[doi:10.1080/00437956.1958.11659661](https://doi.org/10.1080/00437956.1958.11659661)

## Examples

``` r
table(german_plurals$final, german_plurals$plural)
#>             
#>               -e -(e)n -er  -s zero
#>   schwa       41   525  16  63   75
#>   -el/-er     49   219   8  84  360
#>   consonant  277   234  79  94   36
#>   full vowel  22    82  19 555   42
```
