# Acceptability judgments for whether-islands

7-point acceptability ratings in a 2 x 2 factorial design: dependency
length (short or long) by structure (non-island or island). Island
effects show up as an interaction: long dependencies out of islands are
worse than the two main effects predict. 48 participants rate 32 items,
each item in one condition per participant (four counterbalanced lists).

## Usage

``` r
acceptability
```

## Format

A tibble with 1536 rows and 6 columns:

- participant:

  Participant ID, `P01` to `P48`.

- list:

  Counterbalancing list, 1 to 4.

- item:

  Item ID, `i01` to `i32`.

- length:

  Dependency length, `"short"` or `"long"`.

- structure:

  `"non-island"` or `"island"`.

- rating:

  Rating from 1 (unacceptable) to 7 (acceptable).

## Source

`data-raw/acceptability.R`

## Details

True model: a cumulative logit model with thresholds at -2.5, -1.5,
-0.5, 0.5, 1.5 and 2.5 on a latent scale
`1.5 - 0.6 * long - 0.4 * island - 0.9 * long * island`. By-participant
intercepts (SD 0.8) and interaction slopes (SD 0.3); by-item intercepts
(SD 0.4). The design follows Experiment 1 of Sprouse, Wagers and
Phillips (2012), who crossed gap position (matrix or embedded clause,
i.e. a short or long dependency) with structure and used a 7-point
scale; for whether islands they found both main effects and a
superadditive interaction. The number of participants and items, the
effect sizes and the ratings are simulated.

## References

Sprouse, J., Wagers, M. & Phillips, C. (2012). A test of the relation
between working-memory capacity and syntactic island effects.
*Language*, 88(1), 82-123.
[doi:10.1353/lan.2012.0004](https://doi.org/10.1353/lan.2012.0004)

## Examples

``` r
round(tapply(acceptability$rating, acceptability[c("length", "structure")], mean), 2)
#>        structure
#> length  non-island island
#>   short       4.93   4.59
#>   long        4.35   3.47
# \donttest{
if (requireNamespace("ordinal", quietly = TRUE)) {
  acceptability$rating <- factor(acceptability$rating, ordered = TRUE)
  m <- ordinal::clmm(rating ~ length * structure + (1 | participant) + (1 | item),
                     data = acceptability)
  coef(summary(m))
}
#>                              Estimate Std. Error    z value     Pr(>|z|)
#> 1|2                        -3.6771585  0.2058756 -17.861070 2.370507e-71
#> 2|3                        -2.5896943  0.1910695 -13.553678 7.535764e-42
#> 3|4                        -1.6227889  0.1838110  -8.828574 1.060188e-18
#> 4|5                        -0.6520930  0.1801418  -3.619887 2.947318e-04
#> 5|6                         0.3802503  0.1798911   2.113781 3.453398e-02
#> 6|7                         1.4589720  0.1850249   7.885275 3.138429e-15
#> lengthlong                 -0.7158602  0.1290834  -5.545720 2.927464e-08
#> structureisland            -0.4314978  0.1299174  -3.321324 8.959159e-04
#> lengthlong:structureisland -0.5824123  0.1828323  -3.185501 1.445037e-03
# }
```
