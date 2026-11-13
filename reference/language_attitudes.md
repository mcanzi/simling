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
head(language_attitudes)
#> # A tibble: 6 × 15
#>   respondent   age dialect_speaker intelligent educated competent  lazy friendly
#>   <fct>      <int> <fct>                 <int>    <int>     <int> <int>    <int>
#> 1 R001          69 yes                       1        3         1     4        2
#> 2 R002          72 yes                       2        3         3     5        3
#> 3 R003          74 no                        4        4         3     2        3
#> 4 R004          65 no                        2        2         3     5        3
#> 5 R005          30 no                        4        5         2     2        5
#> 6 R006          25 no                        2        4         2     1        3
#> # ℹ 7 more variables: warm <int>, trustworthy <int>, cold <int>,
#> #   used_by_young <int>, will_survive <int>, teach_school <int>, identity <int>
```
