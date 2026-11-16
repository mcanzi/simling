# Word skipping and fixation times in reading

28 readers read 54 sentences while their eye movements are recorded.
Each sentence has a target word that is short (4-6 letters), medium
(7-9) or long (10-12), and the context makes it either predictable or
unpredictable. Each reader sees each sentence once, in one of the two
conditions. Short and predictable words are skipped more often. When a
word is fixated, long and unpredictable words are looked at for longer.
Length and predictability do not interact. Fixation times are missing
for skipped words. For mixed logistic regression of skipping, mixed
models of log durations and data missing by design.

## Usage

``` r
reading_skipping
```

## Format

A tibble with 1512 rows and 9 columns:

- reader:

  Reader ID, `R01` to `R28`.

- item:

  Sentence, `I01` to `I54`.

- length:

  Length group of the target word: `"short"`, `"medium"` or `"long"`.

- letters:

  Length of the target word in letters.

- predictability:

  `"unpredictable"` or `"predictable"`.

- cloze:

  Cloze probability of the target word in this context.

- skipped:

  1 if the target was skipped on the first pass, 0 if not.

- first_fixation:

  Duration of the first fixation on the target in ms. `NA` if skipped.

- gaze_duration:

  Sum of all first-pass fixations on the target in ms. `NA` if skipped.

## Source

`data-raw/reading_skipping.R`

## Details

True model: cell means are those in Rayner et al. (2011, Table 3).
Skipping rates are 36, 22 and 18% for predictable and 28, 18 and 10% for
unpredictable short, medium and long words. First fixations last 193 to
211 ms and gaze durations 211 to 246 ms. Skipping is logistic, with
by-reader (SD 0.6) and by-item (SD 0.4) effects. First fixations are
log-normal, with by-reader (SD 0.12), by-item (SD 0.06) and residual (SD
0.25) variation. A word is refixated with probability
`(gaze - first fixation) / 180` for its cell, and a refixation adds
about 180 ms. Cloze values are drawn around 0.74 for predictable and
0.15 for unpredictable words, close to the norms in the same paper.
Readers, items and eye movements are simulated.

## References

Rayner, K., Slattery, T. J., Drieghe, D. & Liversedge, S. P. (2011). Eye
movements and word skipping during reading: Effects of word length and
predictability. *Journal of Experimental Psychology: Human Perception
and Performance*, 37(2), 514-528.
[doi:10.1037/a0020990](https://doi.org/10.1037/a0020990)

## Examples

``` r
aggregate(skipped ~ length + predictability, data = reading_skipping, FUN = mean)
#>   length predictability   skipped
#> 1  short  unpredictable 0.2539683
#> 2 medium  unpredictable 0.1944444
#> 3   long  unpredictable 0.1031746
#> 4  short    predictable 0.3293651
#> 5 medium    predictable 0.2658730
#> 6   long    predictable 0.1944444
aggregate(gaze_duration ~ length + predictability, data = reading_skipping, FUN = mean)
#>   length predictability gaze_duration
#> 1  short  unpredictable      226.7447
#> 2 medium  unpredictable      218.2414
#> 3   long  unpredictable      244.8496
#> 4  short    predictable      211.2781
#> 5 medium    predictable      214.8649
#> 6   long    predictable      217.7044
colSums(is.na(reading_skipping))
#>         reader           item         length        letters predictability 
#>              0              0              0              0              0 
#>          cloze        skipped first_fixation  gaze_duration 
#>              0              0            338            338 
if (requireNamespace("lme4", quietly = TRUE)) {
  m1 <- lme4::glmer(skipped ~ length * predictability + (1 | reader) + (1 | item),
                    data = reading_skipping, family = binomial)
  m0 <- update(m1, . ~ . - length:predictability)
  print(anova(m0, m1))
  m <- lme4::lmer(log(gaze_duration) ~ length + predictability + (1 | reader) + (1 | item),
                  data = reading_skipping)
  round(lme4::fixef(m), 3)
}
#> Data: reading_skipping
#> Models:
#> m0: skipped ~ length + predictability + (1 | reader) + (1 | item)
#> m1: skipped ~ length * predictability + (1 | reader) + (1 | item)
#>    npar    AIC    BIC  logLik -2*log(L) Chisq Df Pr(>Chisq)
#> m0    6 1547.8 1579.7 -767.88    1535.8                    
#> m1    8 1550.3 1592.9 -767.15    1534.3  1.46  2     0.4819
#>               (Intercept)              lengthmedium                lengthlong 
#>                     5.367                    -0.016                     0.038 
#> predictabilitypredictable 
#>                    -0.055 
```
