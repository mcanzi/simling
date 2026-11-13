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

  10 languages.

- conversation:

  12 per language.

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

True model: \`offset = language_mean + c0 + 120 \* disconfirmation

- 250 \* non-answer - 70 \* gaze +
  e`, where `c0`is a by-conversation offset (SD 60 ms) and`e\` is
  ex-Gaussian (a normal with SD 200 ms plus an exponential with mean 150
  ms, centred). Language means range from 10 ms (Japanese) to 460 ms
  (Danish). The design and the general pattern follow Stivers et al.
  (2009); the language means are invented.

## References

Stivers, T., Enfield, N. J., Brown, P., Englert, C., Hayashi, M.,
Heinemann, T., Hoymann, G., Rossano, F., de Ruiter, J. P., Yoon, K.-E. &
Levinson, S. C. (2009). Universals and cultural variation in turn-taking
in conversation. *Proceedings of the National Academy of Sciences*,
106(26), 10587-10592.

## Examples

``` r
head(turn_taking)
#> # A tibble: 6 × 6
#>   language      conversation response        answer gaze  offset
#>   <fct>         <fct>        <fct>           <fct>  <fct>  <dbl>
#> 1 ‡Ākhoe Hai‖om ‡Āk_01       disconfirmation answer no       242
#> 2 ‡Ākhoe Hai‖om ‡Āk_01       disconfirmation answer no       402
#> 3 ‡Ākhoe Hai‖om ‡Āk_01       disconfirmation answer no       463
#> 4 ‡Ākhoe Hai‖om ‡Āk_01       confirmation    answer no        28
#> 5 ‡Ākhoe Hai‖om ‡Āk_01       disconfirmation answer yes      447
#> 6 ‡Ākhoe Hai‖om ‡Āk_01       confirmation    answer yes      -13
```
