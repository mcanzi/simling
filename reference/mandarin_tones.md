# f0 contours of the four Mandarin tones

12 speakers of Mandarin (6 female, 6 male) produce 8 syllables on each
of the four lexical tones; f0 is measured at 11 equally spaced points
through the vowel. The contours follow the textbook shapes: T1 high
level (55), T2 rising (35), T3 low dipping (214) and T4 falling (51).
For GAMMs of contour shape and for speaker normalisation.

## Usage

``` r
mandarin_tones
```

## Format

A tibble with 4224 rows and 8 columns:

- speaker:

  `S01` to `S12`.

- gender:

  `"female"` or `"male"`.

- tone:

  `"T1"` to `"T4"`.

- syllable:

  `syl1` to `syl8`.

- token_id:

  One level per token (`speaker.tone.syllable`).

- duration:

  Vowel duration in ms.

- time:

  Normalised time, 0 to 100 in steps of 10.

- f0:

  f0 in Hz.

## Source

`data-raw/mandarin_tones.R`

## Details

True model: each tone follows a smooth curve through targets on Chao's
1-5 scale at 0, 25, 50, 75 and 100% of the vowel (T1: 5, 5, 5, 4.9, 4.8;
T2: 3, 2.8, 3.3, 4.2, 5; T3: 2.2, 1.6, 1, 1.3, 2.5; T4: 5, 4.6, 3.7,
2.5, 1.2). One Chao level is about 2.5 semitones (by-speaker SD 0.3);
level 1 is about 160 Hz for female and 90 Hz for male speakers. Token
offsets have SD 0.5 semitones and residuals are AR(1) with rho 0.7. Mean
durations are 250, 270, 300 and 220 ms for T1 to T4.

## References

Chao, Y. R. (1930). A system of tone letters. *Le Maître Phonétique*,
45, 24-27.

## Examples

``` r
head(mandarin_tones)
#> # A tibble: 6 × 8
#>   speaker gender tone  syllable token_id    duration  time    f0
#>   <fct>   <fct>  <fct> <fct>    <fct>          <dbl> <dbl> <dbl>
#> 1 S01     female T1    syl1     S01.T1.syl1      242     0   313
#> 2 S01     female T1    syl1     S01.T1.syl1      242    10   316
#> 3 S01     female T1    syl1     S01.T1.syl1      242    20   317
#> 4 S01     female T1    syl1     S01.T1.syl1      242    30   312
#> 5 S01     female T1    syl1     S01.T1.syl1      242    40   315
#> 6 S01     female T1    syl1     S01.T1.syl1      242    50   312
```
