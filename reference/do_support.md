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

## Examples

``` r
head(do_support)
#> # A tibble: 6 × 5
#>   text   year context                    do eligible
#>   <fct> <int> <fct>                   <int>    <int>
#> 1 T001   1481 affirmative declarative     0       56
#> 2 T001   1481 affirmative question        2       16
#> 3 T001   1481 negative declarative        0       10
#> 4 T001   1481 negative question           4       15
#> 5 T002   1522 affirmative declarative     0       75
#> 6 T002   1522 affirmative question        9       12
```
