# The three-way stop contrast in Seoul Korean

Word-initial lenis, tense and aspirated stops from 20 older and 20
younger speakers of Seoul Korean: VOT and the f0 of the following vowel.
Older speakers keep lenis and aspirated stops apart by VOT as well as by
f0. Younger speakers produce aspirated stops with a shorter VOT, so
lenis and aspirated VOT overlap and f0 alone keeps them apart. For
cluster analysis and classification, and for a sound change in progress.

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

True model: mean VOT for tense, lenis and aspirated stops is 12, 60 and
94 ms for older and 12, 62 and 70 ms for younger speakers, 5 ms shorter
for labials and 10 ms longer for velars; token variation is log-normal
(SD 0.3 for tense, 0.18 otherwise) and by-speaker SD 0.1. f0 relative to
the speaker's mean (about 200 Hz female, 115 Hz male) is +1, -3 and +2
semitones for tense, lenis and aspirated stops in both generations,
token SD 1.5 semitones. The pattern follows Silva (2006): mean aspirated
VOT fell from 94 ms in speakers born before 1965 to 70 ms in those born
later, lenis and tense VOT stayed about the same, and the low f0 after
lenis stops did not change with age. The other values and the data are
simulated.

## References

Silva, D. J. (2006). Acoustic evidence for the emergence of tonal
contrast in contemporary Korean. *Phonology*, 23(2), 287-308.
[doi:10.1017/S0952675706000911](https://doi.org/10.1017/S0952675706000911)

## Examples

``` r
aggregate(cbind(vot, f0) ~ generation + stop, data = korean_stops, FUN = mean)
#>   generation      stop      vot       f0
#> 1      older     lenis 62.94583 131.5625
#> 2    younger     lenis 64.85417 135.2708
#> 3      older     tense 14.35417 166.2708
#> 4    younger     tense 14.39167 168.8458
#> 5      older aspirated 97.95833 175.7292
#> 6    younger aspirated 73.02500 180.2792
korean_stops$f0_st <- 12 * log2(korean_stops$f0 /
                                   ave(korean_stops$f0, korean_stops$speaker))
la <- subset(korean_stops, stop != "tense")
la$aspirated <- as.integer(la$stop == "aspirated")
accuracy <- function(cue, d) {
  m <- glm(reformulate(cue, "aspirated"), data = d, family = binomial)
  mean((fitted(m) > 0.5) == d$aspirated)
}
sapply(split(la, la$generation), function(d) c(vot = accuracy("vot", d),
                                                f0 = accuracy("f0_st", d)))
#>         older   younger
#> vot 0.8395833 0.6104167
#> f0  0.9583333 0.9583333
```
