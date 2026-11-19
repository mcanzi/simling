# Vowel and /l/ articulation by morphological context

Ultrasound tongue imaging of GOOSE + /l/ and FOOT + /l/ in Southern
British English, from 20 speakers in two age groups. Each speaker reads
24 words four times. The /l/ is inside a morpheme (*hula*, *bully*), at
the end of a morpheme before a suffix (*fool-ing*, *pull-ing*), at the
end of a word before a vowel (*fool it*) or at the end of a word before
a consonant (*fool five*). `ld` places each frame on a scale from the
clear /l/ and front vowel of *hula* to the dark /l/ and back vowel of
*fool five*. *fool-ing* is much further along that scale than *hula*;
*pull-ing* is only slightly further than *bully*, and more so for
younger speakers. For GAMMs and morphology-phonetics interactions.

## Usage

``` r
fuzzy_contrasts
```

## Format

A tibble with 21120 rows and 11 columns:

- speaker:

  `OF1` to `OF7`, `OM1` to `OM3`, `YF1` to `YF7` and `YM1` to `YM3`
  (older or younger, female or male).

- age_group:

  `"older"` (45 to 66) or `"younger"` (20 to 28).

- sex:

  `"female"` or `"male"`.

- vowel:

  `"GOOSE"` or `"FOOT"`.

- context:

  `"morpheme_internal"`, `"morpheme_final"`, `"word_prevocalic"` or
  `"word_preconsonantal"`.

- word:

  Test item, three per vowel and context. A hyphen marks a suffix and a
  hash a word boundary.

- repetition:

  1 to 4.

- token:

  One level per token (`speaker.word.repetition`).

- duration:

  Duration of the vowel + /l/ sequence in ms.

- time:

  Normalised time over the first half of the vowel + /l/ sequence, 0 to
  100 in steps of 10.

- ld:

  Linear discriminant value. Higher values mean a backer vowel and a
  darker /l/.

## Source

`data-raw/fuzzy_contrasts.R`

## Details

True model:

    ld = -2 + s0 + w0 + t0 + 0.6 * time / 100 + effect * (1 - 0.25 * time / 100) + e

where `effect` is 0 for `morpheme_internal`, 2.6 (GOOSE) or 2 (FOOT) for
`word_prevocalic` and 4 for `word_preconsonantal`. For `morpheme_final`
it varies by speaker. For GOOSE it is uniform between 1 and 2.2. For
FOOT it is 0.7 for four older speakers (`OF3`, `OF5`, `OF7`, `OM3`) and
0 for the other six; 0.8 for younger speakers, except 0.2 for `YF6`, 0
for `YM1` and -0.6 for `YF7`. With a Welch t-test of `morpheme_internal`
against `morpheme_final` on each speaker's token means (p \< 0.05), this
gives the speaker counts reported in the paper: a GOOSE contrast for all
20 speakers; a FOOT contrast in the expected direction for 11 (4 older,
7 younger), none for 8 and a reversed one for `YF7`. The contrasts
shrink by a quarter over the time window. By-speaker intercepts for each
vowel `s0` have SD 0.3, by-word intercepts `w0` SD 0.1 and by-token
intercepts `t0` SD 0.3. Residuals `e` are AR(1) with rho 0.8 and
innovation SD 0.2, so their SD is 0.33 (0.2 / sqrt(1 - 0.8^2)).
Durations are normal with the means and SDs of each vowel and context in
Table 2 of Strycharczuk and Scobbie (2017), at least 80 ms.

The speakers, words, repetitions, durations and the order of the
contexts follow Strycharczuk and Scobbie (2017). In the paper, `ld` came
from a separate linear discriminant analysis for each speaker and vowel,
trained on principal components of the ultrasound images to separate
`morpheme_internal` from `word_preconsonantal`. Values are therefore not
comparable between the two vowels. The `ld` values and effect sizes are
simulated.

## References

Strycharczuk, P. & Scobbie, J. M. (2017). Whence the fuzziness?
Morphological effects in interacting sound changes in Southern British
English. *Laboratory Phonology*, 8(1), 7.
[doi:10.5334/labphon.24](https://doi.org/10.5334/labphon.24)

## Examples

``` r
aggregate(ld ~ vowel + context, data = fuzzy_contrasts, FUN = mean)
#>   vowel             context          ld
#> 1 GOOSE   morpheme_internal -1.56670303
#> 2  FOOT   morpheme_internal -1.76651023
#> 3 GOOSE      morpheme_final -0.29459280
#> 4  FOOT      morpheme_final -1.32580492
#> 5 GOOSE     word_prevocalic  0.60080417
#> 6  FOOT     word_prevocalic -0.06529356
#> 7 GOOSE word_preconsonantal  2.02781364
#> 8  FOOT word_preconsonantal  1.75710871
if (requireNamespace("mgcv", quietly = TRUE)) {
  foot <- droplevels(subset(fuzzy_contrasts, vowel == "FOOT" &
                              context %in% c("morpheme_internal", "morpheme_final")))
  foot$group <- interaction(foot$age_group, foot$context)
  m <- mgcv::bam(ld ~ group + s(time, by = group, k = 5) +
                   s(time, speaker, bs = "fs", m = 1, k = 5),
                 data = foot, discrete = TRUE)
  summary(m)$p.table
}
#>                                  Estimate Std. Error    t value     Pr(>|t|)
#> (Intercept)                    -1.8588059 0.10718164 -17.342578 1.466957e-65
#> groupyounger.morpheme_internal  0.1906198 0.15157879   1.257563 2.086059e-01
#> groupolder.morpheme_final       0.3001819 0.01861126  16.129047 3.705864e-57
#> groupyounger.morpheme_final     0.7713528 0.15157773   5.088827 3.728475e-07
```
