# Age of first production of words

Parents of 60 children acquiring European Portuguese report each month,
from 10 to 24 months, whether their child says each of 40 words. For
each child and word, the data give the age at which the child first said
the word, or 24 months if the child had not said it by the end of the
study (a censored observation). Frequent words and nouns are learned
earlier. For survival analysis.

## Usage

``` r
first_words
```

## Format

A tibble with 2400 rows and 6 columns:

- child:

  Child ID, `C01` to `C60`.

- word:

  Word ID, `w01` to `w40`.

- category:

  `"noun"`, `"verb"` or `"other"`.

- log_freq:

  log10 frequency of the word in child-directed speech.

- age:

  Age in months at first production, or 24 if censored.

- produced:

  1 if the child said the word by 24 months, 0 if censored.

## Source

`data-raw/first_words.R`

## Details

True model: a discrete-time hazard. In each month from 10 to 24 the
probability of first saying a word is
`plogis(-5.2 + 0.28 * (age - 10) + 0.6 * (log_freq - 2) + category + c0 + w0)`,
with category effects 0.5 (noun), -0.3 (verb) and -0.6 (other), by-child
effects `c0` (SD 0.6) and by-word effects `w0` (SD 0.4). About 37% of
observations are censored.

## Examples

``` r
head(first_words)
#> # A tibble: 6 × 6
#>   child word  category log_freq   age produced
#>   <fct> <fct> <fct>       <dbl> <int>    <int>
#> 1 C01   w01   noun         1.3     24        0
#> 2 C01   w02   noun         1.16    24        0
#> 3 C01   w03   noun         1.31    21        1
#> 4 C01   w04   noun         3.39    13        1
#> 5 C01   w05   noun         2.91    24        0
#> 6 C01   w06   noun         2.14    23        1
```
