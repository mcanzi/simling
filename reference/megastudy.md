# Megastudy of 6000 words

Item-level norms for 6000 words, as in large lexical decision
megastudies: mean RT and accuracy per word, with correlated lexical
predictors. For multiple regression, collinearity, non-linear effects
and variable importance.

## Usage

``` r
megastudy
```

## Format

A tibble with 6000 rows and 8 columns:

- word:

  Word ID, `w0001` to `w6000`.

- log_freq:

  log10 frequency per million words.

- length:

  Length in letters, 2 to 16.

- neighbours:

  Number of orthographic neighbours.

- aoa:

  Age of acquisition in years.

- concreteness:

  Concreteness rating, 1 to 5.

- rt:

  Mean lexical decision RT in ms.

- accuracy:

  Proportion of correct responses.

## Source

`data-raw/megastudy.R`

## Details

True model:
`rt = 720 - 120 * plogis(log_freq - 2.5) + 9 * (length - 7) - 2 * neighbours + 10 * (aoa - 7) - 6 * (concreteness - 3) + e`,
with `e` normal, SD 35 ms. The frequency effect is S-shaped: it levels
off for very rare and very frequent words. Accuracy is \`plogis(2.5

- 0.7 \* (log_freq - 2.5) - 0.2 \* (aoa - 7) + e)`, with `e\` SD 0.5.
  Frequent words are shorter, have more neighbours and are acquired
  earlier.

## Examples

``` r
head(megastudy)
#> # A tibble: 6 × 8
#>   word  log_freq length neighbours   aoa concreteness    rt accuracy
#>   <fct>    <dbl>  <int>      <int> <dbl>        <dbl> <dbl>    <dbl>
#> 1 w0001     1.08      6          1   8.9         3.21   678    0.789
#> 2 w0002     3.45      8          1   6.8         2.22   628    0.981
#> 3 w0003     1.49      4          7  11.2         2.43   723    0.946
#> 4 w0004     2.96      7          3  10.1         1      679    0.921
#> 5 w0005     2.6       7          2   7.5         2.4    671    0.924
#> 6 w0006     2.86      9          0   6.3         1.72   712    0.903
```
