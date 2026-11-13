# The three-way stop contrast in Seoul Korean

Word-initial lenis, tense and aspirated stops from 20 older and 20
younger speakers of Seoul Korean: VOT and the f0 of the following vowel.
Older speakers keep the three stops apart by VOT; younger speakers have
merged lenis and aspirated VOT and keep them apart by f0. For cluster
analysis and classification, and for a sound change in progress.

## Usage

``` r
korean_stops
```

## Format

A tibble with 1440 rows and 8 columns:

- speaker:

  `S01` to `S40`.

- generation:

  `"older"` or `"younger"`.

- gender:

  `"female"` or `"male"`.

- stop:

  `"lenis"`, `"tense"` or `"aspirated"`.

- place:

  `"labial"`, `"coronal"` or `"velar"`.

- rep:

  Repetition, 1 to 4.

- vot:

  Voice onset time in ms.

- f0:

  f0 at the start of the following vowel in Hz.

## Source

`data-raw/korean_stops.R`

## Details

True model: mean VOT for tense, lenis and aspirated stops is 12, 55 and
95 ms for older and 12, 78 and 82 ms for younger speakers, 5 ms shorter
for labials and 10 ms longer for velars; token variation is log-normal
(SD 0.3 for tense, 0.18 otherwise) and by-speaker SD 0.1. f0 relative to
the speaker's mean (about 200 Hz female, 115 Hz male) is +1.2, -1.5 and
+1.5 semitones for older and +1.2, -3.5 and +2.0 semitones for younger
speakers, token SD 0.8 semitones. The design follows reports of the VOT
merger in younger Seoul speakers (Silva 2006); the data are simulated.

## References

Silva, D. J. (2006). Acoustic evidence for the emergence of tonal
contrast in contemporary Korean. *Phonology*, 23(2), 287-308.
[doi:10.1017/S0952675706000911](https://doi.org/10.1017/S0952675706000911)

## Examples

``` r
head(korean_stops)
#> # A tibble: 6 × 8
#>   speaker generation gender stop      place     rep   vot    f0
#>   <fct>   <fct>      <fct>  <fct>     <fct>   <int> <dbl> <dbl>
#> 1 S01     older      female aspirated coronal     1   100   217
#> 2 S01     older      female aspirated coronal     2    59   215
#> 3 S01     older      female aspirated coronal     3   114   207
#> 4 S01     older      female aspirated coronal     4    82   197
#> 5 S01     older      female aspirated labial      1   107   218
#> 6 S01     older      female aspirated labial      2    94   212
```
