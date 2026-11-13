# Attitudes towards a regional dialect

320 respondents rate speakers of a regional dialect on 12 statements (1
= strongly disagree, 5 = strongly agree). The items measure three
correlated attitudes: status, solidarity and vitality. Two items are
negatively worded and need reverse-coding. Dialect speakers rate
solidarity and vitality higher. About 2% of answers are missing. For
factor analysis and scale construction.

## Usage

``` r
language_attitudes
```

## Format

A tibble with 320 rows and 15 columns:

- respondent:

  Respondent ID, `R001` to `R320`.

- age:

  Age in years.

- dialect_speaker:

  Whether the respondent speaks the dialect, `"no"` or `"yes"`.

- intelligent, educated, competent, lazy:

  Status items: dialect speakers sound intelligent / educated /
  competent / lazy. *lazy* is negatively worded.

- friendly, warm, trustworthy, cold:

  Solidarity items. *cold* is negatively worded.

- used_by_young, will_survive, teach_school, identity:

  Vitality items: the dialect is used by young people / will survive /
  should be taught at school / is important for local identity.

## Source

`data-raw/language_attitudes.R`

## Details

True model: three latent attitudes with correlations 0.2
(status-solidarity), 0.3 (status-vitality) and 0.5
(solidarity-vitality). Dialect speakers score 0.6 SD higher on
solidarity and 0.5 SD higher on vitality; vitality falls by 0.01 SD per
year of age. Loadings are 0.55 to 0.8 (negative for *lazy* and *cold*);
responses are the latent item scores cut at -1.3, -0.4, 0.4 and 1.3.

## Examples

``` r
la <- language_attitudes
la$lazy <- 6 - la$lazy
la$cold <- 6 - la$cold
items <- na.omit(la[, 4:15])
fa <- factanal(items, factors = 3, rotation = "promax")
print(fa$loadings, cutoff = 0.3)
#> 
#> Loadings:
#>               Factor1 Factor2 Factor3
#> intelligent            0.732         
#> educated               0.763         
#> competent              0.643         
#> lazy                   0.503         
#> friendly       0.804                 
#> warm           0.758                 
#> trustworthy    0.666                 
#> cold           0.654                 
#> used_by_young                  0.661 
#> will_survive                   0.584 
#> teach_school                   0.645 
#> identity                       0.609 
#> 
#>                Factor1 Factor2 Factor3
#> SS loadings      2.107   1.797   1.582
#> Proportion Var   0.176   0.150   0.132
#> Cumulative Var   0.176   0.325   0.457
aggregate(cbind(intelligent, friendly, will_survive) ~ dialect_speaker, data = la, FUN = mean)
#>   dialect_speaker intelligent friendly will_survive
#> 1              no    3.005618 3.179775         3.00
#> 2             yes    2.933333 3.416667         3.35
```
