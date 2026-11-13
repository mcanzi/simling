# Vowel duration in three speaking styles

50 vowels each in casual, clear and loud speech.

## Usage

``` r
speech_styles
```

## Format

A tibble with 150 rows and 2 columns:

- style:

  `"casual"`, `"clear"` or `"loud"`.

- duration:

  Vowel duration in ms.

## Source

`data-raw/speech_styles.R`

## Details

True model: mean 110 ms (SD 18) in casual, 150 ms (SD 20) in clear and
132 ms (SD 19) in loud speech.

## Examples

``` r
head(speech_styles)
#> # A tibble: 6 × 2
#>   style  duration
#>   <fct>     <dbl>
#> 1 casual       96
#> 2 casual       95
#> 3 casual      107
#> 4 casual      105
#> 5 casual      118
#> 6 casual       89
```
