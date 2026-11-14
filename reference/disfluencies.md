# Filled pauses in Italian dialogue

Filled pauses (*ehm*, *eeh*) in 60 turns from each of 40 speakers in 20
Italian Map Task dialogues, in which an instruction giver guides a
follower along a route. Filled pauses are rare: about 4% of turns
contain one, about 0.4 per 100 syllables. Many turns are fluent and
cannot contain a filled pause at all, so the data have more zeros than a
Poisson model predicts. Givers produce more filled pauses than
followers. For zero-inflated count models with an exposure.

## Usage

``` r
disfluencies
```

## Format

A tibble with 2400 rows and 6 columns:

- dialogue:

  Dialogue ID, `D01` to `D20`.

- speaker:

  Speaker ID, `S01` to `S40`.

- role:

  `"follower"` or `"giver"`.

- turn:

  Turn number, 1 to 60.

- syllables:

  Length of the turn in syllables.

- filled_pauses:

  Number of filled pauses in the turn.

## Source

`data-raw/disfluencies.R`

## Details

True model: with probability 0.55 a turn is fluent and has no filled
pauses. Otherwise the count is Poisson with mean
`rate * syllables / 100`, where `rate` is 1.2 for givers and 0.6 for
followers, multiplied by a speaker effect (SD 0.5 on the log scale).
Turn lengths are log-normal with a median of 9 syllables.

## References

Di Napoli, J. (2020). Filled pauses and prolongations in Roman Italian
task-oriented dialogue. In *Laughter and Other Non-Verbal Vocalisations
Workshop: Proceedings (2020)* (pp. 24-27). Bielefeld.
[doi:10.4119/lw2020-915](https://doi.org/10.4119/lw2020-915)

## Examples

``` r
m0 <- glm(filled_pauses ~ role + offset(log(syllables / 100)), data = disfluencies,
          family = poisson)
c(observed_zeros = mean(disfluencies$filled_pauses == 0),
  poisson_zeros = mean(dpois(0, fitted(m0))))
#> observed_zeros  poisson_zeros 
#>      0.9575000      0.9508454 
if (requireNamespace("pscl", quietly = TRUE)) {
  m <- pscl::zeroinfl(filled_pauses ~ role + offset(log(syllables / 100)) | 1,
                      data = disfluencies)
  exp(coef(m, "count"))
  plogis(coef(m, "zero"))
}
#> (Intercept) 
#>   0.6950195 
```
