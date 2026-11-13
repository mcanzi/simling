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
mandarin_tones$st <- 12 * log2(mandarin_tones$f0 /
  ave(mandarin_tones$f0, mandarin_tones$speaker))
round(tapply(mandarin_tones$st, mandarin_tones[c("tone", "time")], mean), 1)
#>     time
#> tone    0   10   20   30   40   50   60   70   80   90  100
#>   T1  3.8  3.7  3.7  3.7  3.7  3.6  3.6  3.4  3.4  3.3  3.2
#>   T2 -1.4 -1.7 -1.9 -1.8 -1.4 -0.6  0.2  1.2  2.1  2.9  3.6
#>   T3 -3.4 -4.0 -4.6 -5.3 -6.0 -6.4 -6.4 -6.0 -5.1 -4.0 -2.6
#>   T4  3.7  3.3  2.9  2.3  1.4  0.4 -0.8 -2.0 -3.3 -4.6 -6.0
```
