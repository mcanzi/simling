# Vowel duration with speakers and words

16 speakers each produce the same 24 words, 12 with a voiceless and 12
with a voiced final consonant. Speakers differ in speed and in the size
of their voicing effect; words differ in duration.

## Usage

``` r
vowel_duration
```

## Format

A tibble with 384 rows and 4 columns:

- speaker:

  Speaker ID, `S01` to `S16`.

- word:

  Word ID, `w01` to `w24`.

- voicing:

  `"voiceless"` or `"voiced"`.

- duration:

  Vowel duration in ms.

## Source

`data-raw/vowel_duration.R`

## Details

True model: `duration = 150 + s0 + w0 + (20 + s1) * voiced + e`.
By-speaker intercepts `s0` have SD 25 ms and slopes `s1` SD 12 ms
(uncorrelated); by-word intercepts `w0` have SD 15 ms; residual SD 20
ms.

## Examples

``` r
head(vowel_duration)
#> # A tibble: 6 × 4
#>   speaker word  voicing   duration
#>   <fct>   <fct> <fct>        <dbl>
#> 1 S01     w01   voiceless      133
#> 2 S01     w02   voiceless      113
#> 3 S01     w03   voiceless      125
#> 4 S01     w04   voiceless      125
#> 5 S01     w05   voiceless      176
#> 6 S01     w06   voiceless      133
```
