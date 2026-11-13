# Merging of the Cantonese rising tones

Hong Kong Cantonese has two rising tones, T2 (high rising, 25) and T5
(low rising, 23), which some younger speakers merge. 90 speakers aged 18
to 74 each produce 10 T2 and 10 T5 words; the size of the f0 rise is
measured in semitones. For a sound change in apparent time and for
individual differences: mergers form a separate group of speakers, most
of them young.

## Usage

``` r
cantonese_tone_merger
```

## Format

A tibble with 1800 rows and 7 columns:

- speaker:

  `S01` to `S90`.

- age:

  Age in years.

- gender:

  `"female"` or `"male"`.

- word:

  `w01` to `w20`.

- tone:

  `"T2"` or `"T5"`.

- log_freq:

  log10 word frequency, 1 to 5; no effect.

- rise:

  f0 rise from onset to offset in semitones.

## Source

`data-raw/cantonese_tone_merger.R`

## Details

True model: each speaker is a merger with probability
`0.65 * plogis((40 - age) / 6)`. Non-mergers rise by 7 semitones in T2
and 3.5 in T5; mergers by 5.6 and 4.8. By-speaker intercepts have SD 0.6
and token SD is 0.9. The design follows reports of T2/T5 merging (Mok,
Zuo & Wong 2013); the data are simulated.

## References

Mok, P. P. K., Zuo, D. & Wong, P. W. Y. (2013). Production and
perception of a sound change in progress: Tone merging in Hong Kong
Cantonese. *Language Variation and Change*, 25(3), 341-370.
[doi:10.1017/S0954394513000161](https://doi.org/10.1017/S0954394513000161)

## Examples

``` r
rise <- tapply(cantonese_tone_merger$rise,
               cantonese_tone_merger[c("speaker", "tone")], mean)
age <- tapply(cantonese_tone_merger$age, cantonese_tone_merger$speaker, unique)
difference <- rise[, "T2"] - rise[, "T5"]
hist(difference, breaks = 20)

plot(age, difference)

table(merger = difference < 2, under_40 = age < 40)
#>        under_40
#> merger  FALSE TRUE
#>   FALSE    56   10
#>   TRUE      2   22
```
