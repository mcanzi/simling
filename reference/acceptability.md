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
(SD 0.4).

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
#> 1|2                        -3.6771610  0.2058756 -17.861081 2.370054e-71
#> 2|3                        -2.5896919  0.1910694 -13.553672 7.536382e-42
#> 3|4                        -1.6227843  0.1838109  -8.828555 1.060365e-18
#> 4|5                        -0.6520936  0.1801418  -3.619891 2.947276e-04
#> 5|6                         0.3802502  0.1798911   2.113781 3.453402e-02
#> 6|7                         1.4589747  0.1850250   7.885285 3.138180e-15
#> lengthlong                 -0.7158624  0.1290833  -5.545740 2.927128e-08
#> structureisland            -0.4315010  0.1299174  -3.321349 8.958332e-04
#> lengthlong:structureisland -0.5824085  0.1828321  -3.185483 1.445126e-03
# }
```
