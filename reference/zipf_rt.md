# Reaction times and Zipfian word frequency

2000 words sampled at random from the 50,000 most frequent word types of
a corpus whose frequencies follow Zipf's law (frequency proportional to
1 / rank). As in real corpora, most words are rare and a few are very
frequent, so frequency is extremely skewed. Useful for log
transformations.

## Usage

``` r
zipf_rt
```

## Format

A tibble with 2000 rows and 4 columns:

- word:

  Word ID, `w0001` to `w2000`.

- rank:

  Frequency rank in the corpus, 1 to 50,000.

- freq:

  Frequency per million words, `50000 / rank`.

- rt:

  Reaction time in ms.

## Source

`data-raw/zipf_rt.R`

## Details

True model: `log(rt) = 6.62 - 0.08 * log10(freq) + e`, with `e` normal,
SD 0.15.

## Examples

``` r
head(zipf_rt)
#> # A tibble: 6 × 4
#>   word   rank  freq    rt
#>   <fct> <int> <dbl> <dbl>
#> 1 w0001    49 1020.   511
#> 2 w0002    70  714.   738
#> 3 w0003   125  400    624
#> 4 w0004   135  370.   522
#> 5 w0005   136  368.   589
#> 6 w0006   169  296.   598
```
