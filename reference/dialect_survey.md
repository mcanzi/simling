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
head(dialect_survey)
#> # A tibble: 6 × 7
#>   town       lat  long speaker      age words degeminated
#>   <fct>    <dbl> <dbl> <fct>      <int> <int>       <int>
#> 1 Acerra    41    14.4 Acerra_1      49    10           0
#> 2 Acerra    41    14.4 Acerra_2      40    10           0
#> 3 Acerra    41    14.4 Acerra_3      57    10           0
#> 4 Acerra    41    14.4 Acerra_4      78    10           0
#> 5 Acireale  37.6  15.2 Acireale_1    28    10           0
#> 6 Acireale  37.6  15.2 Acireale_2    29    10           0
```
