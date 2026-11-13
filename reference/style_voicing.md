# Vowel duration by speaking style and voicing

A 2 x 2 design: casual or clear speech, voiceless or voiced following
consonant, 40 tokens per cell. The voicing effect is larger in clear
speech: a categorical-by-categorical interaction.

## Usage

``` r
style_voicing
```

## Format

A tibble with 160 rows and 3 columns:

- style:

  `"casual"` or `"clear"`.

- voicing:

  `"voiceless"` or `"voiced"`.

- duration:

  Vowel duration in ms.

## Source

`data-raw/style_voicing.R`

## Details

True model: cell means are 110 (casual, voiceless), 145 (casual,
voiced), 125 (clear, voiceless) and 180 ms (clear, voiced); SD 18 ms.

## Examples

``` r
head(style_voicing)
#> # A tibble: 6 × 3
#>   style  voicing   duration
#>   <fct>  <fct>        <dbl>
#> 1 casual voiceless       99
#> 2 casual voiceless      110
#> 3 casual voiceless       83
#> 4 casual voiceless       85
#> 5 casual voiceless      131
#> 6 casual voiceless       93
```
