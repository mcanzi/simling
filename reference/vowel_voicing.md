# Vowel duration before voiced and voiceless consonants

A production study: 60 vowels before voiceless consonants (*beat*) and
60 before voiced ones (*bead*).

## Usage

``` r
vowel_voicing
```

## Format

A tibble with 120 rows and 2 columns:

- voicing:

  `"voiceless"` or `"voiced"`.

- duration:

  Vowel duration in ms.

## Source

`data-raw/vowel_voicing.R`

## Details

True model: mean 120 ms (SD 20) before voiceless and 160 ms (SD 22)
before voiced consonants.

## Examples

``` r
head(vowel_voicing)
#> # A tibble: 6 × 2
#>   voicing   duration
#>   <fct>        <dbl>
#> 1 voiceless      166
#> 2 voiceless       96
#> 3 voiceless      106
#> 4 voiceless      112
#> 5 voiceless      101
#> 6 voiceless      101
```
