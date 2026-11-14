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
1.6 vs 1.2 vowel ratio and 5.2 vs 4.7 syllables/s. VOT and vowel ratio
vary log-normally around the speaker mean, so they stay positive. f0 is
210 Hz for female and 120 Hz for male speakers. H1-H2 differs between
speakers but not by L1 or gender, and intensity varies only between
tokens.

## Examples

``` r
aggregate(cbind(vot, vowel_ratio, rate, f0) ~ l1 + gender, data = accent, FUN = mean)
#>        l1 gender      vot vowel_ratio     rate       f0
#> 1 English female 75.49688    1.576250 5.412125 204.3281
#> 2 Italian female 40.28929    1.208286 4.923964 213.5179
#> 3 English   male 76.25714    1.561071 5.291464 114.3607
#> 4 Italian   male 47.57500    1.183750 4.680313 122.8594
speakers <- levels(accent$speaker)
test <- is.element(accent$speaker, speakers[seq(1, length(speakers), by = 5)])
m <- glm(l1 ~ vot + vowel_ratio + rate, data = accent[!test, ], family = binomial)
predicted <- predict(m, accent[test, ], type = "response") > 0.5
mean(predicted == (accent$l1[test] == "Italian"))
#> [1] 0.9166667
if (requireNamespace("randomForest", quietly = TRUE)) {
  set.seed(1)
  rf <- randomForest::randomForest(l1 ~ vot + vowel_ratio + rate + f0 + h1h2 + intensity,
                                   data = accent[!test, ], importance = TRUE)
  print(round(randomForest::importance(rf, type = 1), 1))
  mean(predict(rf, accent[test, ]) == accent$l1[test])
}
#>             MeanDecreaseAccuracy
#> vot                        104.1
#> vowel_ratio                 76.2
#> rate                        20.9
#> f0                          23.6
#> h1h2                        36.7
#> intensity                    2.7
#> [1] 0.9083333
```
