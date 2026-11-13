# Frequency effects in L1 and L2 speakers

Reaction times of L1 and L2 speakers to words of varying frequency. The
frequency effect is stronger for L2 speakers, so frequency and group
interact (a continuous-by-categorical interaction).

## Usage

``` r
l2_frequency
```

## Format

A tibble with 400 rows and 3 columns:

- group:

  `"L1"` or `"L2"`, 200 responses each.

- log_freq:

  log10 word frequency, 1 to 6.

- rt:

  Reaction time in ms.

## Source

`data-raw/l2_frequency.R`

## Details

True model: `log(rt) = 6.56 - 0.04 * log_freq` for L1 and
`6.85 - 0.07 * log_freq` for L2 speakers, plus normal noise with SD
0.06.

## Examples

``` r
m <- lm(log(rt) ~ log_freq * group, data = l2_frequency)
coef(m)
#>      (Intercept)         log_freq          groupL2 log_freq:groupL2 
#>       6.57721546      -0.04308238       0.29221918      -0.03213221 
plot(log(rt) ~ log_freq, data = l2_frequency, col = group)
```
