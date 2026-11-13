# The rise of periphrastic do

Use of *do* (*Did he go?*, *He did not go*) in 300 texts dated 1400 to
1700, in four sentence types: the number of clauses with *do* out of all
eligible clauses. In three contexts the change follows S-curves with the
same slope and different starting points (the Constant Rate Effect).
Affirmative declaratives barely take part.

## Usage

``` r
do_support
```

## Format

A tibble with 1200 rows and 5 columns:

- text:

  Text ID, `T001` to `T300`.

- year:

  Year of the text.

- context:

  `"affirmative declarative"`, `"negative declarative"`,
  `"affirmative question"` or `"negative question"`.

- do:

  Clauses with *do*.

- eligible:

  All clauses in this context in this text.

## Source

`data-raw/do_support.R`

## Details

True model, in log-odds: `baseline + 0.035 * (year - 1550)` (3.5 per
century in every context), with baselines 1.0 (affirmative questions),
1.6 (negative questions), -0.6 (negative declaratives) and -7.5
(affirmative declaratives), and by-text intercepts (SD 0.4). In the
historical data, *do* in affirmative declaratives later declined again;
the simulation leaves this out.

## References

Ellegård, A. (1953). *The auxiliary do: The establishment and regulation
of its use in English*. Stockholm: Almqvist & Wiksell.

Kroch, A. S. (1989). Reflexes of grammar in patterns of language change.
*Language Variation and Change*, 1(3), 199-244.
[doi:10.1017/S0954394500000168](https://doi.org/10.1017/S0954394500000168)

## Examples

``` r
do_support$century <- (do_support$year - 1550) / 100
m <- glm(cbind(do, eligible - do) ~ 0 + context + context:century, data = do_support,
         family = binomial)
round(coef(m), 2)
#>         contextaffirmative declarative            contextnegative declarative 
#>                                  -7.35                                  -0.63 
#>            contextaffirmative question               contextnegative question 
#>                                   1.02                                   1.61 
#> contextaffirmative declarative:century    contextnegative declarative:century 
#>                                   3.46                                   3.50 
#>    contextaffirmative question:century       contextnegative question:century 
#>                                   3.52                                   3.45 
rising <- subset(do_support, context != "affirmative declarative")
anova(glm(cbind(do, eligible - do) ~ context + century, data = rising, family = binomial),
      glm(cbind(do, eligible - do) ~ context * century, data = rising, family = binomial),
      test = "Chisq")
#> Analysis of Deviance Table
#> 
#> Model 1: cbind(do, eligible - do) ~ context + century
#> Model 2: cbind(do, eligible - do) ~ context * century
#>   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
#> 1       896     969.09                     
#> 2       894     968.92  2  0.17152   0.9178
```
