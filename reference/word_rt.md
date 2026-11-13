# Reaction times, word frequency and word length

400 words with their frequency, length in letters and syllables, and a
reaction time. Frequent words are shorter, so frequency and length are
correlated.

## Usage

``` r
word_rt
```

## Format

A tibble with 400 rows and 4 columns:

- log_freq:

  log10 word frequency, 1 to 6.

- length:

  Length in letters, 2 to 14.

- syllables:

  Number of syllables, roughly `length / 3`.

- rt:

  Reaction time in ms.

## Source

`data-raw/word_rt.R`

## Details

True model:
`log(rt) = 6.62 - 0.04 * (log_freq - 3.5) + 0.0186 * (length - 7) + e`,
with `e` normal, SD 0.06. Syllables have no effect of their own.

## Examples

``` r
head(word_rt)
#> # A tibble: 6 × 4
#>   log_freq length syllables    rt
#>      <dbl>  <int>     <int> <dbl>
#> 1     4.03      9         3   776
#> 2     5.69      4         1   610
#> 3     2.32      8         2   751
#> 4     2.9       7         2   763
#> 5     5.04      4         1   626
#> 6     5.89      3         2   611
```
