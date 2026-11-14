# Picture naming before and after therapy for word-finding difficulties

16 people with chronic aphasia name 120 pictures each, twice before and
once after eight weeks of cueing therapy. Half of each person's items
were practised in therapy and half were not. Naming of treated items
improves for almost every participant, and the two baselines do not
differ. Naming of untreated items improves only for the five
participants with a phonological profile: relatively good semantic
processing and impaired phonological output. For mixed logistic
regression of repeated measures, three-way interactions and
generalisation in therapy studies.

## Usage

``` r
aphasia_naming
```

## Format

A tibble with 5760 rows and 6 columns:

- participant:

  Participant ID, `P01` to `P16`.

- profile:

  `"other"` or `"phonological"`.

- item:

  Picture, numbered within participant (`P01_001`).

- set:

  `"untreated"` or `"treated"`.

- session:

  `"baseline 1"`, `"baseline 2"` or `"post-therapy"`.

- correct:

  1 if the picture was named correctly, 0 if not.

## Source

`data-raw/aphasia_naming.R`

## Details

True model: the logit of a correct response is `p0 + i0 + post * gain`.
Participant intercepts `p0` have mean -0.45 (SD 0.9) and item effects
`i0` SD 1.2. For treated items, `gain` is the participant's own gain
(mean 1, SD 0.35). For untreated items it is 0.7 in the phonological
profile and 0.05 otherwise, plus noise (SD 0.1). The design follows Best
et al. (2013). In their 16 participants, naming of treated items rose
from 43.5 to 62% correct, and only participants with relatively good
semantic and impaired phonological processing generalised to untreated
items. The number of items, the size of the subgroup and all data are
simulated.

## References

Best, W., Greenwood, A., Grassly, J., Herbert, R., Hickin, J. & Howard,
D. (2013). Aphasia rehabilitation: Does generalisation from anomia
therapy occur and is it predictable? A case series study. *Cortex*,
49(9), 2345-2357.
[doi:10.1016/j.cortex.2013.01.005](https://doi.org/10.1016/j.cortex.2013.01.005)

## Examples

``` r
round(tapply(aphasia_naming$correct, aphasia_naming[c("set", "session")], mean), 2)
#>            session
#> set         baseline 1 baseline 2 post-therapy
#>   untreated       0.40       0.42         0.46
#>   treated         0.44       0.44         0.64
round(tapply(aphasia_naming$correct,
             aphasia_naming[c("profile", "set", "session")], mean), 2)
#> , , session = baseline 1
#> 
#>               set
#> profile        untreated treated
#>   other             0.41    0.47
#>   phonological      0.39    0.38
#> 
#> , , session = baseline 2
#> 
#>               set
#> profile        untreated treated
#>   other             0.43    0.47
#>   phonological      0.38    0.38
#> 
#> , , session = post-therapy
#> 
#>               set
#> profile        untreated treated
#>   other             0.43    0.66
#>   phonological      0.53    0.58
#> 
p01 <- subset(aphasia_naming, participant == "P01" & set == "treated" &
                session != "baseline 1")
mcnemar.test(table(before = p01$correct[p01$session == "baseline 2"],
                   after = p01$correct[p01$session == "post-therapy"]))
#> 
#>  McNemar's Chi-squared test with continuity correction
#> 
#> data:  table(before = p01$correct[p01$session == "baseline 2"], after = p01$correct[p01$session == "post-therapy"])
#> McNemar's chi-squared = 14.815, df = 1, p-value = 0.0001186
#> 
if (requireNamespace("lme4", quietly = TRUE)) {
  d <- subset(aphasia_naming, session != "baseline 1")
  m <- lme4::glmer(correct ~ session * set * profile + (1 | participant) + (1 | item),
                   data = d, family = binomial,
                   control = lme4::glmerControl(optimizer = "bobyqa"))
  round(lme4::fixef(m), 2)
}
#>                                        (Intercept) 
#>                                              -0.34 
#>                                sessionpost-therapy 
#>                                              -0.03 
#>                                         settreated 
#>                                               0.20 
#>                                profilephonological 
#>                                              -0.29 
#>                     sessionpost-therapy:settreated 
#>                                               1.01 
#>            sessionpost-therapy:profilephonological 
#>                                               0.82 
#>                     settreated:profilephonological 
#>                                              -0.18 
#> sessionpost-therapy:settreated:profilephonological 
#>                                              -0.75 
```
