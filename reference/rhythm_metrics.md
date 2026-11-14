# Rhythm metrics across languages, speakers and speech materials

%V, ΔC and VarcoV from 8 speakers of each of six languages: English,
German, Greek, Italian, Korean and Spanish. Ramus et al. (1999) proposed
%V and ΔC to sort languages into rhythm classes. Each speaker produced
five samples of five kinds of material: uncontrolled sentences,
sentences built from complex syllables, sentences built from simple
syllables, a read story and spontaneous speech. The design follows
Arvaniti (2012). The languages differ, but not in the way rhythm classes
predict, and speakers, elicitation method and syllable complexity move
the metrics about as much as language does. ΔC also falls as speech rate
rises. For partitioning variance with mixed models.

## Usage

``` r
rhythm_metrics
```

## Format

A tibble with 1200 rows and 8 columns:

- language:

  `"English"`, `"German"`, `"Greek"`, `"Italian"`, `"Korean"` or
  `"Spanish"`.

- speaker:

  Speaker ID: ISO 639-3 language code and number, e.g. `eng_01`.

- material:

  Kind of speech material. The three read sentence sets are
  `"uncontrolled sentences"`, `"complex-syllable sentences"` and
  `"simple-syllable sentences"`; the other two levels are `"story"` and
  `"spontaneous"`.

- item:

  Sample number within speaker and material, 1 to 5.

- rate:

  Speech rate in syllables per second.

- percent_v:

  Percentage of the sample that is vocalic.

- delta_c:

  Standard deviation of consonantal intervals in ms.

- varco_v:

  Coefficient of variation of vocalic intervals.

## Source

`data-raw/rhythm_metrics.R`

## Details

True model: each metric is the sum of a language mean, a material
effect, a language-by-material deviation, a speaker effect and noise.
Language means for %V, ΔC and VarcoV are 43, 51, 55 (English), 41.5, 51,
52 (German), 44.5, 46, 56 (Greek), 46, 46.5, 55 (Italian), 46, 49, 57.5
(Korean) and 46, 48.5, 54 (Spanish). They follow the order of the
language differences Arvaniti (2012) found: for %V, German \< English \<
Greek \< Italian, Korean and Spanish; for ΔC, English and German \>
Korean and Spanish \> Greek and Italian; for VarcoV, German lowest and
Korean highest. Material effects, relative to the uncontrolled
sentences, are -3, +7, +3 (complex-syllable sentences), +3, -6, -4
(simple-syllable sentences), -1, +2, +2 (story) and -1.5, +6, +7
(spontaneous). Language-by-material deviations have SD 1, 3 and 3,
speaker effects SD 2, 4 and 4, and residuals SD 2, 5 and 6. ΔC falls by
6 ms per syllable per second, a rate effect described by Dellwo (2006).
All values were chosen for the simulation to reproduce these patterns;
they are not measurements from either study.

## References

Arvaniti, A. (2012). The usefulness of metrics in the quantification of
speech rhythm. *Journal of Phonetics*, 40(3), 351-373.
[doi:10.1016/j.wocn.2012.02.003](https://doi.org/10.1016/j.wocn.2012.02.003)

Dellwo, V. (2006). Rhythm and speech rate: A variation coefficient for
deltaC. In P. Karnowski & I. Szigeti (eds.), *Language and
Language-Processing: Proceedings of the 38th Linguistics Colloquium,
Piliscsaba 2003* (pp. 231-241). Frankfurt am Main: Peter Lang.

Rathcke, T. & Smith, R. (2015). Speech timing and linguistic rhythm: On
the acoustic bases of rhythm typologies. *Journal of the Acoustical
Society of America*, 137(5), 2834-2845.
[doi:10.1121/1.4919322](https://doi.org/10.1121/1.4919322)

Ramus, F., Nespor, M. & Mehler, J. (1999). Correlates of linguistic
rhythm in the speech signal. *Cognition*, 73(3), 265-292.
[doi:10.1016/S0010-0277(99)00058-X](https://doi.org/10.1016/S0010-0277%2899%2900058-X)

White, L. & Mattys, S. L. (2007). Calibrating rhythm: First language and
second language studies. *Journal of Phonetics*, 35(4), 501-522.
[doi:10.1016/j.wocn.2007.02.003](https://doi.org/10.1016/j.wocn.2007.02.003)

## Examples

``` r
round(tapply(rhythm_metrics$percent_v, rhythm_metrics[c("material", "language")], mean),
      1)
#>                             language
#> material                     English German Greek Italian Korean Spanish
#>   uncontrolled sentences        42.8   42.8  45.3    43.7   45.9    46.3
#>   complex-syllable sentences    38.6   40.3  42.0    41.8   43.0    43.4
#>   simple-syllable sentences     46.4   45.7  48.2    49.7   48.9    52.1
#>   story                         41.8   42.8  45.5    44.9   44.7    46.7
#>   spontaneous                   41.9   41.2  44.2    43.5   44.0    45.3
boxplot(percent_v ~ material, data = rhythm_metrics)

coef(lm(delta_c ~ rate + language + material, data = rhythm_metrics))["rate"]
#>      rate 
#> -6.414159 
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(percent_v ~ language + material + (1 | speaker), data = rhythm_metrics)
  round(lme4::fixef(m), 2)
  lme4::VarCorr(m)
}
#>  Groups   Name        Std.Dev.
#>  speaker  (Intercept) 2.0526  
#>  Residual             2.0880  
```
