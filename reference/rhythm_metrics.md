# Rhythm metrics across languages, speakers and speech materials

%V, ΔC and VarcoV from 8 speakers of each of six languages: English,
German, Greek, Italian, Korean and Spanish. Each speaker produced five
samples of five kinds of material. Three are sets of read sentences:
uncontrolled sentences, sentences built from complex syllables (the
"stress-timed" set) and sentences built from simple syllables (the
"syllable-timed" set). The other two are a read story and spontaneous
speech. The design follows Arvaniti (2012). As in her data, the language
means differ little and do not split into a stress-timed and a
syllable-timed group. Speakers, elicitation method and syllable
complexity move the metrics about as much as language does. ΔC falls
with speech rate. For partitioning variance with mixed models and for
testing whether the metrics support rhythm classes.

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

  `"uncontrolled sentences"`, `"complex-syllable sentences"`,
  `"simple-syllable sentences"`, `"story"` or `"spontaneous"`.

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
Language means for %V, ΔC and VarcoV are 43.5, 49, 56 (English), 42.5,
51, 57 (German), 46, 46, 52 (Greek), 45, 47, 54 (Italian), 45, 50, 55
(Korean) and 44, 48, 55 (Spanish). Material effects, relative to the
uncontrolled sentences, are -3, +7, +3 (complex-syllable sentences), +3,
-6, -4 (simple-syllable sentences), -1, +2, +2 (story) and -1.5, +6, +7
(spontaneous). Language-by-material deviations have SD 1, 3 and 3,
speaker effects SD 2, 4 and 4, and residuals SD 2, 5 and 6. ΔC falls by
6 ms per syllable per second. All values were chosen for the simulation
to reproduce the pattern Arvaniti (2012) reports; they are not her
measurements.

## References

Arvaniti, A. (2012). The usefulness of metrics in the quantification of
speech rhythm. *Journal of Phonetics*, 40(3), 351-373.
[doi:10.1016/j.wocn.2012.02.003](https://doi.org/10.1016/j.wocn.2012.02.003)

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
round(tapply(rhythm_metrics$percent_v, rhythm_metrics[c("material", "language")], mean), 1)
#>                             language
#> material                     English German Greek Italian Korean Spanish
#>   uncontrolled sentences        43.3   43.8  46.8    42.7   44.9    44.3
#>   complex-syllable sentences    39.1   41.3  43.5    40.8   42.0    41.4
#>   simple-syllable sentences     46.9   46.7  49.7    48.7   47.9    50.1
#>   story                         42.3   43.8  47.0    43.9   43.7    44.7
#>   spontaneous                   42.4   42.2  45.7    42.5   43.0    43.3
boxplot(percent_v ~ material, data = rhythm_metrics)

lang <- aggregate(cbind(percent_v, delta_c, varco_v) ~ language, data = rhythm_metrics,
                  FUN = mean)
set.seed(1)
data.frame(language = lang$language,
           cluster = kmeans(scale(lang[, -1]), centers = 2, nstart = 20)$cluster)
#>   language cluster
#> 1  English       1
#> 2   German       1
#> 3    Greek       2
#> 4  Italian       1
#> 5   Korean       1
#> 6  Spanish       2
speakers <- aggregate(percent_v ~ speaker + language, data = rhythm_metrics, FUN = mean)
t.test(percent_v ~ language,
       data = droplevels(subset(speakers, is.element(language, c("English", "Spanish")))))
#> 
#>  Welch Two Sample t-test
#> 
#> data:  percent_v by language
#> t = -1.8831, df = 13.979, p-value = 0.08066
#> alternative hypothesis: true difference in means between group English and group Spanish is not equal to 0
#> 95 percent confidence interval:
#>  -4.187344  0.272344
#> sample estimates:
#> mean in group English mean in group Spanish 
#>               42.7945               44.7520 
#> 
coef(lm(delta_c ~ rate + language + material, data = rhythm_metrics))["rate"]
#>      rate 
#> -6.414159 
if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(percent_v ~ language + material + (1 | speaker), data = rhythm_metrics)
  round(lme4::fixef(m), 2)
}
#>                        (Intercept)                     languageGerman 
#>                              42.82                               0.76 
#>                      languageGreek                    languageItalian 
#>                               3.72                               0.90 
#>                     languageKorean                    languageSpanish 
#>                               1.51                               1.96 
#> materialcomplex-syllable sentences  materialsimple-syllable sentences 
#>                              -2.95                               4.04 
#>                      materialstory                materialspontaneous 
#>                              -0.08                              -1.11 
```
