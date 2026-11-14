# Turn-taking in 10 languages

The gap between the end of a yes/no question and the start of its
answer, in 25 question-answer pairs from each of 12 conversations in
each of 10 languages. Negative values are overlaps. In every language,
gaps cluster just above zero and are skewed to the right; languages
differ in their average gap by a few hundred milliseconds.
Disconfirmations and non-answers come later; answers to a questioner who
is looking at the responder come sooner.

## Usage

``` r
turn_taking
```

## Format

A tibble with 3000 rows and 6 columns:

- language:

  Language of the conversation: `"Danish"`, `"Dutch"`, `"English"`,
  `"Italian"`, `"Japanese"`, `"Korean"`, `"Lao"`, `"Tzeltal"`,
  `"Yélî Dnye"` or `"ǂĀkhoe Haiǁom"`.

- conversation:

  Conversation ID: a three-letter code for the language and a number,
  from `akh_01` to `yel_12`; 12 per language.

- response:

  `"confirmation"` or `"disconfirmation"`.

- answer:

  `"answer"` or `"non-answer"` (e.g. *I don't know*).

- gaze:

  Whether the questioner was looking at the responder, `"no"` or
  `"yes"`.

- offset:

  Time from the end of the question to the start of the answer in ms.

## Source

`data-raw/turn_taking.R`

## Details

True model:

    offset = baseline + c0 + 207 * disconfirmation + 132 * non_answer
      - 69 * gaze + e

`c0` is a by-conversation offset (SD 120 ms) and `e` is ex-Gaussian (a
normal with SD 200 ms plus an exponential with mean 150 ms, centred).
The three effects and the size of the conversation variation follow the
model in Stivers et al. (2009, Table 1). Baselines are set so that each
language's expected mean equals its reported mean: 7 ms for Japanese,
310 ms for Italian and 469 ms for Danish (Stivers et al. 2009), and the
others from Levinson and Torreira (2015, Table 1). The conversations and
answers are simulated.

## References

Stivers, T., Enfield, N. J., Brown, P., Englert, C., Hayashi, M.,
Heinemann, T., Hoymann, G., Rossano, F., de Ruiter, J. P., Yoon, K.-E. &
Levinson, S. C. (2009). Universals and cultural variation in turn-taking
in conversation. *Proceedings of the National Academy of Sciences*,
106(26), 10587-10592.
[doi:10.1073/pnas.0903616106](https://doi.org/10.1073/pnas.0903616106)

Levinson, S. C. & Torreira, F. (2015). Timing in turn-taking and its
implications for processing models of language. *Frontiers in
Psychology*, 6, 731.
[doi:10.3389/fpsyg.2015.00731](https://doi.org/10.3389/fpsyg.2015.00731)

## Examples

``` r
sort(tapply(turn_taking$offset, turn_taking$language, median))
#>      Japanese       Tzeltal     Yélî Dnye       English        Korean 
#>          11.0          47.0         103.0         178.0         207.0 
#>         Dutch       Italian           Lao        Danish ǂĀkhoe Haiǁom 
#>         229.0         302.0         417.5         462.0         475.0 
hist(turn_taking$offset, breaks = 60)

if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::lmer(offset ~ response + answer + gaze + language + (1 | conversation),
                  data = turn_taking)
  lme4::fixef(m)[c("responsedisconfirmation", "answernon-answer", "gazeyes")]
}
#> responsedisconfirmation        answernon-answer                 gazeyes 
#>               215.57395               111.65792               -82.41778 
```
