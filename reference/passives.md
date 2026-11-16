# Passives in four registers

Number of passive constructions in 400 texts, 100 each from
conversation, fiction, news and academic writing. Texts differ in
length, so counts need an exposure term. The counts are overdispersed.

## Usage

``` r
passives
```

## Format

A tibble with 400 rows and 4 columns:

- text:

  Text ID, `T001` to `T400`.

- register:

  `"conversation"`, `"fiction"`, `"news"` or `"academic"`.

- words:

  Text length in words.

- passives:

  Number of passives.

## Source

`data-raw/passives.R`

## Details

True model: negative binomial with mean `rate * words / 1000` and size
4, where `rate` per 1000 words is 2 (conversation), 5 (fiction), 10
(news) and 20 (academic). Biber, Conrad and Leech (2002) note that
passive verbs are about ten times more frequent in academic prose than
in conversation. The other rates and all data are simulated.

## References

Biber, D., Conrad, S. & Leech, G. (2002). *Longman Student Grammar of
Spoken and Written English*. Harlow: Longman.

## Examples

``` r
if (requireNamespace("MASS", quietly = TRUE)) {
  m <- MASS::glm.nb(passives ~ 0 + register + offset(log(words / 1000)), data = passives)
  exp(coef(m))
  m$theta
}
#> [1] 3.983186
```
