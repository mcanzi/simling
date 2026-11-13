# A dialect survey of degemination in Italy

Degemination (*gatto* pronounced with a single *t*) in the speech of 4
speakers at each of 145 towns in mainland Italy and Sicily, with
coordinates for mapping. Northern dialects degeminate, central and
southern ones keep geminates, with a sharp transition along a stylised
La Spezia-Rimini line at about 44.1° N. Older speakers degeminate more.
Each speaker reads 10 words with a geminate.

## Usage

``` r
dialect_survey
```

## Format

A tibble with 580 rows and 7 columns:

- town:

  Town name.

- lat, long:

  Coordinates of the town in decimal degrees.

- speaker:

  Speaker ID, `town_1` to `town_4`.

- age:

  Age in years.

- words:

  Words read with a geminate: always 10.

- degeminated:

  Of these, words produced with a single consonant.

## Source

`data-raw/dialect_survey.R`

## Details

True model, in log-odds:
`-1.5 + 6 * (lat - 44.1) + t0 + 0.03 * (age - 50)`, with by-town
intercepts `t0` (SD 0.6). Town names and coordinates are the Italian
towns of over 50,000 inhabitants in `maps::world.cities` (without
Sardinia); the dialect data are simulated.

## Examples

``` r
dialect_survey$p <- dialect_survey$degeminated / dialect_survey$words
plot(lat ~ long, data = dialect_survey, col = grey(1 - p), pch = 16, asp = 1.3)
abline(h = 44.1, lty = 2)

if (requireNamespace("lme4", quietly = TRUE)) {
  m <- lme4::glmer(cbind(degeminated, words - degeminated) ~ I(lat - 44.1) + I(age - 50) +
                     (1 | town), data = dialect_survey, family = binomial)
  lme4::fixef(m)
}
#>   (Intercept) I(lat - 44.1)   I(age - 50) 
#>   -1.46171334    6.43810397    0.02378499 
```
