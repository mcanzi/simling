# Formants of three vowels from two speakers

F1 and F2 of /i a u/, 20 tokens per vowel from each of two speakers.
Speaker B has a shorter vocal tract, so all formants are 20% higher.

## Usage

``` r
formants
```

## Format

A tibble with 120 rows and 5 columns:

- speaker:

  `"A"` or `"B"`.

- vowel:

  `"i"`, `"a"` or `"u"`.

- token:

  Token number, 1 to 20.

- f1, f2:

  First and second formant in Hz.

## Source

`data-raw/formants.R`

## Details

True model: speaker A's mean F1 and F2 are 300 and 2300 Hz for /i/, 750
and 1300 Hz for /a/, and 320 and 800 Hz for /u/; speaker B's are 1.2
times higher. Token SD is 40 Hz for F1 and 120 Hz for F2.

## Examples

``` r
head(formants)
#> # A tibble: 6 × 5
#>   speaker vowel token    f1    f2
#>   <fct>   <fct> <int> <dbl> <dbl>
#> 1 A       a         1   747  1163
#> 2 A       a         2   784  1093
#> 3 A       a         3   731  1256
#> 4 A       a         4   728  1519
#> 5 A       a         5   779  1357
#> 6 A       a         6   746  1317
```
