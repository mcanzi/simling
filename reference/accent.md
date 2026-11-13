# Acoustic cues to a foreign accent

Six acoustic measures from 40 tokens of each of 30 speakers of English:
15 L1 English and 15 L1 Italian. Three measures differ by L1, one by
gender and two by nothing. For classification with random forests and
cross-validation by speaker.

## Usage

``` r
accent
```

## Format

A tibble with 1200 rows and 9 columns:

- speaker:

  `S01` to `S30`.

- l1:

  `"English"` or `"Italian"`.

- gender:

  `"female"` or `"male"`.

- vot:

  Voice onset time of /p t k/ in ms.

- vowel_ratio:

  Ratio of stressed to unstressed vowel duration.

- rate:

  Speech rate in syllables per second.

- f0:

  Mean f0 in Hz.

- h1h2:

  H1-H2 in dB.

- intensity:

  Mean intensity in dB.

## Source

`data-raw/accent.R`

## Details

True model: speaker means for English vs Italian are 70 vs 45 ms VOT,
1.6 vs 1.2 vowel ratio and 5.2 vs 4.7 syllables/s; VOT and vowel ratio
vary log-normally around the speaker mean, so they stay positive; f0 is
210 Hz for female and 120 Hz for male speakers. H1-H2 varies by speaker
only and intensity by token only.

## Examples

``` r
head(accent)
#> # A tibble: 6 × 9
#>   speaker l1      gender   vot vowel_ratio  rate    f0  h1h2 intensity
#>   <fct>   <fct>   <fct>  <dbl>       <dbl> <dbl> <dbl> <dbl>     <dbl>
#> 1 S01     English female   103        1.79  5.76   188   2.6      61.8
#> 2 S01     English female    76        1.27  5.68   200   3        70.5
#> 3 S01     English female    83        1.73  6.31   191   5.3      69  
#> 4 S01     English female    85        1.67  5.26   211   2.6      67.6
#> 5 S01     English female    74        1.8   4.25   188   5.2      70  
#> 6 S01     English female    86        1.97  4.32   200   2.4      55.8
```
