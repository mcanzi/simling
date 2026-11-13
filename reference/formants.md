# Formants of three vowels from two speakers

F1 and F2 of /i a u/, 20 tokens per vowel from each of two speakers.
Every formant of speaker B is 1.2 times the same formant of speaker A.
This uniform scaling is a simplification. Between real speakers, and
between women and men, the ratio differs across vowels and formants
(Fant 1966), so normalisation methods that assume one factor per speaker
work better here than on real data.

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

## References

Fant, G. (1966). A note on vocal tract size factors and non-uniform
F-pattern scalings. *Speech Transmission Laboratory Quarterly Progress
and Status Report*, 7(4), 22-30.

## Examples

``` r
aggregate(cbind(f1, f2) ~ speaker + vowel, data = formants, FUN = mean)
#>   speaker vowel     f1      f2
#> 1       A     i 306.80 2325.65
#> 2       B     i 353.40 2760.25
#> 3       A     a 741.95 1274.20
#> 4       B     a 892.70 1559.30
#> 5       A     u 316.50  816.55
#> 6       B     u 377.90  950.10
formants$f1_z <- ave(formants$f1, formants$speaker, FUN = function(x) c(scale(x)))
formants$f2_z <- ave(formants$f2, formants$speaker, FUN = function(x) c(scale(x)))
aggregate(cbind(f1_z, f2_z) ~ speaker + vowel, data = formants, FUN = mean)
#>   speaker vowel       f1_z       f2_z
#> 1       A     i -0.7119075  1.3136014
#> 2       B     i -0.7372816  1.3090919
#> 3       A     a  1.3772454 -0.3046285
#> 4       B     a  1.3784471 -0.2572665
#> 5       A     u -0.6653379 -1.0089729
#> 6       B     u -0.6411656 -1.0518254
```
