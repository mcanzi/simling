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
(news) and 18 (academic).

## Examples

``` r
head(passives)
#> # A tibble: 6 × 4
#>   text  register     words passives
#>   <fct> <fct>        <int>    <int>
#> 1 T001  conversation  1560        4
#> 2 T002  conversation  1715        3
#> 3 T003  conversation  3753        1
#> 4 T004  conversation  4373       11
#> 5 T005  conversation   927        0
#> 6 T006  conversation  1027        5
```
