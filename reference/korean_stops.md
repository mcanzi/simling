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
aggregate(cbind(vot, f0) ~ generation + stop, data = korean_stops, FUN = mean)
#>   generation      stop      vot       f0
#> 1      older     lenis 57.85000 143.1750
#> 2    younger     lenis 81.12917 130.9750
#> 3      older     tense 14.35417 167.6083
#> 4    younger     tense 14.39167 170.9750
#> 5      older aspirated 99.00000 170.2958
#> 6    younger aspirated 85.27500 179.8167
korean_stops$f0_st <- 12 * log2(korean_stops$f0 /
                                   ave(korean_stops$f0, korean_stops$speaker))
for (g in c("older", "younger")) {
  d <- subset(korean_stops, generation == g)
  set.seed(1)
  cl <- kmeans(scale(d[c("vot", "f0_st")]), centers = 3, nstart = 10)
  print(table(d$stop, cl$cluster))
}
#>            
#>               1   2   3
#>   lenis       0 238   2
#>   tense     240   0   0
#>   aspirated   2   7 231
#>            
#>               1   2   3
#>   lenis       0 240   0
#>   tense     240   0   0
#>   aspirated   1   0 239
```
