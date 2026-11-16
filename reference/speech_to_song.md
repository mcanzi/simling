# The speech-to-song illusion

86 English listeners each hear six spoken sentences, each repeated eight
times. Before the repetitions they rate how song-like the sentence
sounds (1 = clearly speech, 8 = clearly song). During the repetitions
they press a button as soon as the speech turns into song, and
afterwards they rate the sentence again. Each sentence comes in a
baseline version, a version with flattened pitch within syllables and a
version with lengthened sonorous parts. Both manipulations make the
illusion more likely, while musical aptitude does not. Listeners with
weaker beat perception hear the song earlier, and listeners with better
melody perception rate it as more song-like. For mixed logistic and
ordinal models, and for a response that is missing by design.

## Usage

``` r
speech_to_song
```

## Format

A tibble with 516 rows and 9 columns:

- listener:

  Listener ID, `L01` to `L86`.

- bat:

  Beat perception score (z-score), as from the Computerised Adaptive
  Beat Alignment Test.

- mpt:

  Melody perception score (z-score), as from the Mistuning Perception
  Test.

- sentence:

  Sentence, `S1` to `S9`.

- manipulation:

  Version of the sentence: `"baseline"`, `"pitch"` (pitch movements
  within syllables flattened) or `"duration"` (sonorous parts lengthened
  by 20% and obstruents shortened by the same amount).

- rating_before:

  Rating before the repetitions, 1 (clearly speech) to 8 (clearly song).

- transformed:

  1 if the listener reported the illusion, 0 if not.

- cycle:

  Repetition, 1 to 8, during which the listener reported the illusion.
  `NA` when there was no illusion.

- rating_after:

  Rating after the repetitions, on the same scale.

## Source

`data-raw/speech_to_song.R`

## Details

True model: each listener hears two sentences in each condition,
assigned in a Latin square. `transformed` is Bernoulli with logit
`-0.9 + 1.04 * pitch + 0.78 * duration` plus listener (SD 1) and
sentence (SD 0.5) effects. `cycle` and both ratings come from ordered
probit models. For `cycle` the latent value is `0.61 * bat` plus a
listener effect (SD 0.6). For `rating_after` it is
`0.2 + 1.2 * pitch + 0.91 * duration + 0.44 * mpt + 0.8 * transformed`
plus listener (SD 0.7) and sentence effects. The two aptitude scores
correlate at about 0.5. The design and the effects of the manipulations
and of aptitude follow Rathcke and Smit (2025); in their data the
manipulated stimuli transformed about half of the time. The other
intercepts, the effect of `transformed` on the final rating and all data
are simulated.

## References

Rathcke, T. & Smit, E. A. (2025). Musical aptitude moderates ease and
vividness but not frequency of the speech-to-song illusion. *Scientific
Reports*, 15, 33315.
[doi:10.1038/s41598-025-18612-8](https://doi.org/10.1038/s41598-025-18612-8)

Falk, S., Rathcke, T. & Dalla Bella, S. (2014). When speech sounds like
music. *Journal of Experimental Psychology: Human Perception and
Performance*, 40(4), 1491-1506.
[doi:10.1037/a0036858](https://doi.org/10.1037/a0036858)

Rathcke, T., Falk, S. & Dalla Bella, S. (2024). Why does speech
sometimes sound like song? Exploring the role of music-related priors in
the "speech-to-song illusion". *Music & Science*, 7.
[doi:10.1177/20592043241266060](https://doi.org/10.1177/20592043241266060)

## Examples

``` r
round(tapply(speech_to_song$transformed, speech_to_song$manipulation, mean), 2)
#> baseline    pitch duration 
#>     0.28     0.49     0.41 
table(speech_to_song$cycle)
#> 
#>  1  2  3  4  5  6  7  8 
#> 30 48 55 27 17 12  6  9 
wilcox.test(speech_to_song$rating_after, speech_to_song$rating_before, paired = TRUE)
#> 
#>  Wilcoxon signed rank test with continuity correction
#> 
#> data:  speech_to_song$rating_after and speech_to_song$rating_before
#> V = 89096, p-value < 2.2e-16
#> alternative hypothesis: true location shift is not equal to 0
#> 
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(transformed ~ manipulation + bat + mpt + (1 | listener) + (1 | sentence),
                   data = speech_to_song, family = binomial)
  round(lme4::fixef(m), 2)
}
#>          (Intercept)    manipulationpitch manipulationduration 
#>                -1.05                 1.03                 0.66 
#>                  bat                  mpt 
#>                 0.13                -0.13 
if (requireNamespace("ordinal", quietly = TRUE)) {
  m <- ordinal::clm(factor(rating_after) ~ manipulation + bat + mpt, data = speech_to_song,
                    link = "probit")
  print(round(coef(m)[c("manipulationpitch", "manipulationduration", "bat", "mpt")], 2))
  m <- ordinal::clm(factor(cycle) ~ bat + mpt, data = speech_to_song, link = "probit")
  print(round(coef(m)[c("bat", "mpt")], 2))
}
#>    manipulationpitch manipulationduration                  bat 
#>                 1.06                 0.61                -0.08 
#>                  mpt 
#>                 0.38 
#>  bat  mpt 
#> 0.37 0.23 
```
