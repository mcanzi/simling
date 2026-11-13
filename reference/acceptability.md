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
table(acceptability$length, acceptability$structure, acceptability$rating)
#> , ,  = 1
#> 
#>        
#>         non-island island
#>   short         11     25
#>   long          24     65
#> 
#> , ,  = 2
#> 
#>        
#>         non-island island
#>   short         23     30
#>   long          41     65
#> 
#> , ,  = 3
#> 
#>        
#>         non-island island
#>   short         46     48
#>   long          62     69
#> 
#> , ,  = 4
#> 
#>        
#>         non-island island
#>   short         69     68
#>   long          68     74
#> 
#> , ,  = 5
#> 
#>        
#>         non-island island
#>   short         75     86
#>   long          80     50
#> 
#> , ,  = 6
#> 
#>        
#>         non-island island
#>   short         72     59
#>   long          56     41
#> 
#> , ,  = 7
#> 
#>        
#>         non-island island
#>   short         88     68
#>   long          53     20
#> 
```
