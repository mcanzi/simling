# Perceptual training of a non-native contrast

18 learners identify a non-native consonant contrast in 40 trials before
and after a week of perceptual training. A small paired design in wide
format.

## Usage

``` r
perception_training
```

## Format

A tibble with 18 rows and 3 columns:

- learner:

  Learner ID, `L01` to `L18`.

- pre:

  Correct responses out of 40 before training.

- post:

  Correct responses out of 40 after training.

## Source

`data-raw/perception_training.R`

## Details

True model: binomial out of 40, with log-odds `0.4 + ability` before and
`0.4 + ability + gain` after training. `ability` has SD 0.6; `gain` has
mean 0.6 and SD 0.35.

## Examples

``` r
t.test(perception_training$post, perception_training$pre, paired = TRUE)
#> 
#>  Paired t-test
#> 
#> data:  perception_training$post and perception_training$pre
#> t = 4.5553, df = 17, p-value = 0.0002806
#> alternative hypothesis: true mean difference is not equal to 0
#> 95 percent confidence interval:
#>  1.729816 4.714629
#> sample estimates:
#> mean difference 
#>        3.222222 
#> 
t.test(perception_training$post, perception_training$pre)
#> 
#>  Welch Two Sample t-test
#> 
#> data:  perception_training$post and perception_training$pre
#> t = 2.36, df = 32.132, p-value = 0.02451
#> alternative hypothesis: true difference in means is not equal to 0
#> 95 percent confidence interval:
#>  0.4415294 6.0029150
#> sample estimates:
#> mean of x mean of y 
#>  29.66667  26.44444 
#> 
```
